# ASP - Atomic State Pattern

The [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) is a simple, native form of Flutter reactivity.
This extension aims to transparently apply **functional reactive programming (TFRP)**.

## Install

```yaml
flutter pub add asp
```

## Understanding Extension.

This extension adds a class **Atom** and a converter **ValueNotifier -> Atom** so that it can be observed transparently by the function **rxObserver()** and [Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html) **RxBuilder**.

The **Atom** is directly an extension of [ValueListenable](https://api.flutter.dev/flutter/foundation/ValueListenable-class.html) then any object that implements it can be converted to **Atom**

The only difference from **Atom** to [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) is the automatic signature function in Observers **rxObserver()** and **RxBuilder**, very similar to [MobX reactions](https://pub.dev/packages/mobx).

## Using

To start, instantiate an Atom.

```dart
final counter = Atom<int>(0);
```

or convert a  [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) already existing using the **.asAtom()** method:

```dart

final counter = myValueNotifierCounter.asAtom();

```
> **IMPORTANT**: The **Atom()** method has been added to [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) using [Extension Methods](https://dart.dev/guides/language/extension-methods).


And listen the changes using **rxObserver**:

```dart
RxDisposer disposer = rxObserver((){
    print(counter.value);
});

disposer();
```

All declared values in the current scope **fn()** are observables and can generate a value that is listened in property **effect**.

```dart
RxDisposer disposer = rxObserver<String>((){
    return '${name.value} + ${lastName.value}';
}, effect: (String fullName){
  print(fullName);
});

disposer();
```

This is the transparent use of individual reactivity, but we can also combine **Atom Objects** producing new value. This technique is called **Computed**

## Computed: Combining reactive values

To combine two or more **Atom Objects** we need to use a **getter** returning a new combined value:

```dart
final num1 = Atom<int>(1);
final num2 = Atom<int>(2);

String get result => 'num1: ${num1.value} + num2: ${num2.value} = ${num1.value + num2.value}';

...

rxObserver((){
    print(result); // print´s "num1: 1 + num2: 2 = 3
});
```

> **IMPORTANT**: It is really necessary that **computed** are **Getters** and not assignments. The reaction will happen when any of the **Atom** changes the value.

## Using Getters

We can also use **getters** to combine other getters which themselves point to **Atom Objects**, let's repeat the example above:

```dart

final _num1 = Atom<int>(1);
int get num1 => _num1.value;

final _num2 = Atom<int>(2);
int get num2 => _num2.value;

String get result => 'num1: $num1 + num2: $num2 = ${num1 + num2}';

...

rxObserver((){
    print(result); // print´s "num1: 1 + num2: 2 = 3
});


```

## Filters

All Rx listeners have a property **filter** which is a function that returns a **bool**. Use this to define when (or not) to reflect changes:

```dart
RxDisposer disposer = rxObserver<String>((){
    return '${name.value} + ${lastName.value}';
}, filter: (fullName) => fullName.isNotEmpty);

disposer();
```



## Flutter and Atom

RxNotifier has tools that help with the state management and propagation for the Widget.

1. Add the RxRoot Widget to the root of the app:

```dart
void main(){
  runApp(RxRoot(child: AppWidget()));
}
```

2. Now just use the `context.select` method passing the Atom objects:

```dart

final counter = Atom(0);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = context.select(() => counter.value);

    return Scaffold(
      body: Center(
        child: Text(
          '${home.count}',
           style: TextStyle(fontSize: 23),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => counter.count++,
      ),
    );
  }
}
```

3. To call [Dialogs], [SnackBars], etc. based on state changes, listen to one or more [Atoms], subscribing to a callback, using `context.callback`:

```dart

 @override
  Widget build(BuildContext context) {
    context.callback(() => errorState.value, _showSnachbar);

    ...
```


## Widgets: RxBuilder
A builder for managing state in a scoped way is also available:

```dart
Widget build(BuildContext context){
    return RxBuilder(
        builder: (_) => Text('${counter.value}'),
    );
}
```

> **IMPORTANT**: Both the `context.select` method and the builder have the `filter` property.


## Widgets: RxCallback
This widget can replace `context.callback` by getting a product list from rxObserver.
```dart
Widget build(BuildContext context){
    return RxCallback(
        effects: [
          rxObserver(() => errorState.value, effect: _showSnachbar)
        ]
        child: BodyWidget(),
    );
}
```

## AtomObserver

This component can pick up all changes made to any Atom that is in the project. This will be useful for logs or analytics. You can only subscribe once to see notifications, we recommend doing this in function `main()`;

```dart
main(){
  AtomObserver.changes((atom){
    // send to analytics.
  });
}
```

## Awaiters

Atom has methods that can either wait for the next value change or buffer those changes. For this we will use the `Atom.next` and `Atom.buffer` methods.

These methods can be useful in specific situations that require this wait, but they were thought to help mainly in unit tests.

**next**:

Wait the next change of a `Atom`.<br>
The `timeLimit` is 10 seconds by default.

```dart

final atom = Atom('string');
final nextValue = await atom.next();

```

**buffer**:

Buffer changes of a `Atom`.<br>
The `count` is a number of a buffered items.<br>
The [timeLimit] is 10 seconds by default.

```dart

final atom = Atom('string');
final listOfValues = await atom.buffer(3);

```

## PIPERS

Atoms can now rely on operators to modify the setter's behavior. We call these operators Pipers.
We can add Pipers in Atom or create our own piper.
The ASP library already has some Pipers to start with.


**DebounceTime**:

Emits a notification from an Atom only after a specified period 
of time has passed without another source issuing:

```dart
 final searchTextAction = Atom(
    '',
    key: 'searchTextAction',
    pipe: debounceTime()
 );

  searchTextAction.value = 'j';
  searchTextAction.value = 'jac';
  searchTextAction.value = 'jacob';

  // prints: 'jacob'


```

**ThrottleTime**:

Emits a notification from an `Atom`, then ignores subsequent
source values for duration milliseconds, then repeats this process:

```dart
 final searchTextAction = Atom(
    '',
    key: 'searchTextAction',
    pipe: throttleTime()
 );

  searchTextAction.value = 'j';
  searchTextAction.value = 'jac';
  searchTextAction.value = 'jacob';

  // prints: 'j'


```

**Interval**:

Emits a notification from an `Atom` after a given duration:

```dart
 final textAction = Atom(
    '',
    key: 'searchTextAction',
    pipe: interval(const Duration(seconds: 1))
 );

  searchTextAction.value = 'j';
  searchTextAction.value = 'jac';
  searchTextAction.value = 'jacob';

  // prints: 'j' after 1 seconds.
  // prints: 'jac' after 1 seconds.
  // prints: 'jacob' after 1 seconds.


```

**Distinct**:

Skips data value if they are equal to the previous data value:

```dart
 final textAction = Atom(
    '',
    key: 'searchTextAction',
    pipe: interval(const Duration(seconds: 1))
 );

  searchTextAction.value = 'jacob';
  searchTextAction.value = 'jacob';
  searchTextAction.value = 'jacob';
  searchTextAction.value = 'mia';
  searchTextAction.value = 'mia';

  // prints: 'jacob'.
  // prints: 'mia'.


```

**MuiltiPipe**:

Concat many pipes.
```dart
final textState = Atom(
     '',
     key: 'textState',
     pipe: multiPipe([
        distinct(),
        interval(),
    ]),
);
```

## Implementing the Atomic State.

It is possible to implement [Recoil](https://recoiljs.org) Atoms pattern using `asp`.
This pattern consists of the state being an object with its own reactivity.

![atom](/assets/atom.png)


## Motivation

Developers still have trouble understanding state management in Flutter.
We had this conclusion after several research in the community fluttering and also
in partner companies.
Atomic State is a noob-friendly state management approach at the same time
that maintains a reliable structure thinking of scalability and maintenance.

More details, read this [Medium article on the subject](https://medium.com/@jacobmoura/introdu%C3%A7%C3%A3o-ao-estado-at%C3%B4mico-no-flutter-com-Atom-73ad9edf8718).


## Rules

We must take into account some architectural limits to execute this Approach:

1. All states must be an atom(`Atom` instance).
2. All actions must be an atom(`Atom` instance).
3. Business rules must be created in the `Reducer` and not in the `Atom`.


## Layers

We will have 3 main layers, they are: `Atoms`, `Reducers` and `Views`;

![atom](/assets/arch.png)

Note that the View (which is the presentation layer) does not know about the `Reducer` (which is the business rule execution layer).
These two layers share atoms that in turn represent the state and the dispatch of state actions.


## Atom`s

Atom represents the reactive state of an application.
Each atom has its own reactivity.


```dart
// atoms
final productsState = <Product>[].asAtom();
final productTextFilterState = Atom<String>('');

// computed
List<Product> get filteredProductsState {
     if(productTextFilterState.value.isEmpty()){
         return productsState.value;
     }

     return productsState.where(
         (p) => p.title.contains(productTextFilterState.value),
     );
}

// actions
final selectedProductState = Atom<Product?>(null);
final fetchProductsState = Atom.action();
```



## Reducer

In this architecture you are forced to separate state management
from business rules, which may seem strange at first because we are used to manage and reduce state in the same layer with approaches like `BLoC` or `ChangeNotifier`.<br>
However, dividing state management and business rule execution will help us distribute multiple states to the same widget, and these multiple states will not need to be concatenated beforehand through a `facade` or `proxy`.

The layer responsible for making business decisions will be called `Reducer`:

```dart
class ProductReducer extends Reducer {

    ProductReducer(){
        on(() => [fetchProductsState.action], _fetchProducts);
        on(() => [selectedProductState.value], _selectProduct);
    }

    void _fetchProducts(){
        ...
    }

    void _selectProduct(){
        ...
    }
}
```

`Reducers` can register methods/functions that listen to the reactivity of an `Atom`.

## View (Widget)

Any widget can listen to changes of one or more atoms,
as long as they have the `RxRoot` widget as their ancestor.

The `context.select()` method is added via Extension to `BuildContext` and can be called on any type of Widget, `StatefulWidget` and `StatelessWidget`.

```dart

...
Widget build(BuildContext context){
     final products = context.select(
                 () => filteredProductsState.value
              );
     ...
}

```

## FAQ

### How to test an Atom?

We can use `AWAITERS` to help us test.
See an example with `Atom.buffer`.

```dart
sealed class TestState {}

class StartTestState implements TestState {}

class LoadingTestState implements TestState {}

class SuccessTestState implements TestState {}

....

test('Buffer values with state pattern', () {
    final a = Atom<TestState>(StartTestState());

    expect(
      a.buffer(2),
      completion([
        isA<LoadingTestState>(),
        isA<SuccessTestState>(),
      ]),
    );
  
    a.value = LoadingTestState();
    a.value = SuccessTestState();
  });
}
```

It is interesting to note that expect must be declared before changing the atom so that it can listen to the changes.
`Atom.buffer` returns a [Future](https://api.flutter-io.cn/flutter/dart-async/Future-class.html), thus enabling the use of matchers [completion](https://api.flutter-io.cn/flutter/package-matcher_expect/completion.html) and [completes](https://api.flutter.dev/flutter/package-matcher_expect/completes.html).

### Can one Atom call another?

In some cases, a single action can trigger multiple reactions, but it is generally recommended to avoid directly chaining actions.
The main problem that the `ASP` (Atomic State Pattern) pattern aims to solve is the distribution of state in situations where it is necessary to wait for an event to reduce the current state.

An example of this is when using a `BLoC` (Business Logic Component) that depends on the state of another `BLoC`. In this case, one would have to wait for the dependency propagation in the initState method, for example, before sending the data to the main `BLoC`. This configuration can become complex in many cases.

We should consider that `ATOM`'s can be reduced in the `Reducer`, which can listen to more than one action or change of an ATOM and perform the necessary filtering.
Therefore, it is preferable to avoid listening to one action only to trigger another action. Instead, it is recommended to improve the filter in the `Reducer`.



## Examples

Flutter projects using Atom

- [Trivial Counter](https://github.com/Flutterando/asp/tree/main/example/trivial_counter).

- [Shop Cart](https://github.com/Flutterando/asp/tree/main/example/shop_cart).

## Features and bugs

Please send feature requests and bugs at the issue tracker.

This README was created based on templates made available by Stagehand under a BSD-style license.
