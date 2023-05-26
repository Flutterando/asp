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

The only difference from **Atom** to [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) is the automatic signature function in Observers **rxObserver()** e **RxBuilder**, very similar to [MobX reactions](https://pub.dev/packages/mobx).

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

We can also use **getters** in reactive values making, let's repeat the example above:

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

All Rx listeners have a property filter **filter** which is a function that returns a **bool**. Use this to define when (or not) to reflect changes:

```dart
RxDisposer disposer = rxObserver<String>((){
    return '${name.value} + ${lastName.value}';
}, filter: (fullName) => fullName.isNotEmpty);

disposer();
```



## Flutter and Atom

RxNotifeir has tools that help with state management and propagation for the Widget.

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

3. To execute methods that call something external to the state like [Dialog], [SnackBar] and etc,
use `context.callback` to listen for one or several [Atom] subscribing to a callback.

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

## Collections and Asyncs

**RxList**

An RxList gives you a deeper level of observability on a list of values. It tracks when items are added, removed or modified and notifies the observers. Use an RxList when a change in the list matters.

**RxMap**

An RxMap gives you a deeper level of observability on a map of values. It tracks when keys are added, removed or modified and notifies the observers. Use an RxMap when a change in the map matters.

**RxSet**

An RxSet gives you a deeper level of observability on a set of values. It tracks when values are added, removed or modified and notifies the observers. Use an RxSet when a change in the set matters.

**RxFuture**

The RxFuture is the reactive wrapper around a Future. You can use it to show the UI under various states of a Future, from pending to fulfilled or rejected. The status, result and error fields of an RxFuture are observable and can be consumed on the UI.
You can add a new Future using **.value**
```dart
final rxFuture = RxFuture.of(myFuture);
...

rxFuture.value = newFuture;
```

**RxStream**

The stream that is tracked for status and value changes.
T initialValue: The starting value of the stream.

## Implementing the Atomic State.

It is possible to implement [Recoil](https://recoiljs.org) Atoms pattern using `asp`.
This pattern consists of the state being an object with its own reactivity.

![atom](/assets/atom.png)


## Motivation

Developers still have trouble understanding state management in Flutter.
We had this conclusion after several research in the community fluttering and also
in partner companies.
Atomic State is a noob-friendly state management approuch at the same time
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

Atom represent the reactive state of an application.
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

In this architecture you are forced to split state management
of business rules, which may seem strange at first when seen
that we are always managing and reducing state in the same layer as `BLoC` and `ChangeNotifier` for example.<br>
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

Any widget can listen to changes of one or many atoms,
provided they have the `RxRoot` widget as their ancestor.
k
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

## Examples

Flutter projects using Atom

[Trivial Counter](https://github.com/Flutterando/asp/tree/master/asp/example/trivial_counter).

[Shop Cart](https://github.com/Flutterando/asp/tree/master/asp/example/shop_cart).

## Features and bugs

Please send feature requests and bugs at the issue tracker.

This README was created based on templates made available by Stagehand under a BSD-style license.