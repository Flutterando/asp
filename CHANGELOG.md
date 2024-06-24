## [2.0.0] - 2024-06-24

After extensive feedback, we are changing the API to make the standard more intuitive and user-friendly. We also added stricter limits for more complex projects and introduced a “predictability” system in state changes to improve tracking and debugging while reducing unwanted side effects. Some changes may seem drastic, but we believe everything will make more sense once you give this new API a chance.

Let’s start with what has been removed, followed by the new features:

- [BREAKING CHANGE]: Removed all collections such as **RxList**, **RxSet**, and **RxMap**. Asynchronous converters like **RxFuture** and **RxStream** have also been removed. Initially, these helpers seemed beneficial, but they soon complicated things, prompting us to remove them. Consequently, all extensions have been removed as well. Now there is only one way to create an **Atom**:
```dart
    final productsState = atom<List<Product>>([]);
```

- [BREAKING CHANGE]: Due to the new API capabilities, some widgets have changed. **ASP** now adopts **hook_state** for state distribution, retiring **RxRoot**, which has been removed. We will discuss the new state distribution method based on hooks later. **RxCallback** has also been removed for the same reason. The **RxBuilder** has been renamed to **AtomBuilder** for semantic clarity.

- [BREAKING CHANGE]: The Reducer API in **ASP** was a major source of confusion and complaints. While it was magical and capable of deriving values from multiple **Atoms**, the reactive actions system needed a rethink to make the process more predictable and easier to learn. The steep learning curve of **RxReducer** led us to segregate it into two new APIs: **AtomAction** and **AtomSelector**. As a result, **RxReducer** no longer exists. However, don’t worry—something much better is coming.

- [BREAKING CHANGE]: **ASP** is moving towards a more functional approach, emphasizing functions over classes. Some components, such as Atom, have been converted to functions. The main difference you’ll notice is the change in the capitalization of the component name:

```dart
//v1
final counter = Atom(0);

//v2
final counter = atom(0);

```
- [BREAKING CHANGE]: The biggest challenge in reactivity is observability. We have taken this to the next level with **ASP**. Now, you can track which action modified the state of an **Atom**, and when someone starts or stops listening to an **Atom**. We needed to tweak our observability API slightly, but it is definitely worth it:

```dart
void main() {

  AtomObserver.changes((status) {
    print(status.atom); // counterState
    print(status.action); // incrementAction
    print(status.event.name) // change
  });

  runApp(MyApp());
}

```

### New Features and Future Direction of Atomic State Management


- [NEW]: **Atom** with more rigid architectural limits.

The **Atom** is the heart of atomic state. It allows creating an object that stores an autonomous micro-state, observable by anything—be it a widget or a function. However, an Atom could also be modified by anything, anywhere, leading to classic side-effect problems. To address this, we removed the state setter and added a new component called **AtomAction**. This way, while an **Atom** can still be listened to by anything, it can only be modified in a specific place, enhancing predictability and reducing uncontrolled side effects.

Example:
```dart
// atom creation
final counterState = atom(0);

// listen changes
counterState.addListener((){
    print(counterState.state); // 1
});

// action creation
final increment = atomAction((set){
    return set(counterState, 1);
});

// execute action
increment()

```

Actions can also accept up to 3 arguments and be used as a pub-sub mechanism:

```dart

final counterAction = atomAction1<String>((set, action){
    final state = counterState.state;

    if(action == 'INCREMENT'){
        set(counterState, state + 1);
    } else if(action == 'DECREMENT'){
        set(counterState, state - 1);
    }
});

```

The **atomAction** feature opens up numerous possibilities, functioning as both a simple action and a complex **reducer**.
We replaced RxReducer with **AtomAction** for action calls. To fully replace **RxReducer**, we also needed a way to handle the derivation of multiple **Atoms**, which we achieve using the **AtomSelector** API.

[NEW]: Data derivation with **AtomSelector**.<br>
Managing state distribution and converging multiple states into a new one was identified as the major challenge in the case study that led to the creation of **ASP**. We introduced a very simple way to combine multiple **Atoms** and compute a new value whenever any of them changes.
This is very straightforward with **AtomSelector**:

```dart
// atoms
final nameState = atom('');
final lastNameState = atom('');

// selectors
final fullName = selector((get){
    final name = get(nameState);
    final lastName = get(lastNameState);
    return '$name $lastName';
});

// actions
final changeName = atomAction1<String>((set, name){
    set(nameState, name);
});

changeName('Matias');

```

Within the **selector’s** internal scope, the get property is used to subscribe to an **Atom**. This visual indicator shows what is being observed.
The example above demonstrates the three pillars of **ASP**: **Atoms**, **Selectors**, and **Actions**.

There is also a way to derive states asynchronously with **AsyncSelector**:

```dart
final userIdState = atom(1);

final userState = asyncSelector<User>(
    User.empty(),
    (get) async {
        final id = get(userIdState);
        final response = await dio.get('/user/$id');
        return User.fromJson(response.data);
    }
);

```

This example shows a more complex derivation where modifying an Atom triggers an external API call. Despite this complexity, **RxReducer** users should find it familiar. It’s worth noting that any **Selector** is also an Atom and shares the same internal APIs.
Now that we’ve shown how to use Atom with **Selector** and modify it only in **Actions**, let’s talk about how we’ve made it easier to connect all this with Widgets.

- [NEW]: Replacing **rxObserver** with **atomEffect**.<br>
Before diving into **Widgets**, let’s discuss a small change in the default listener for an **Atom**, formerly known as **rxObserver**.
With the transparency of reactivity abandoned, we need to register each reactivity automatically using the get property seen in **Selectors**. This makes it more descriptive and easier to understand what is being subscribed. Additionally, it allows the use of other Atoms within the scope without needing additional subscriptions. The syntax hasn’t changed much, but it’s important to highlight since it’s also a [BREAKING CHANGE].

```dart

final disposer = atomEffect(
    (get) => get(counterState),
    (state) => print('Number is $state'),
);

// release
disposer();
```

The atomEffect might not be used as often, as there is a hook that does the same thing and automatically manages the lifecycle, including automatic disposal.

- [NEW]: Automatic subscription with **HOOKS**.
We are adding a **hooks** system to subscribe **Atoms** to a **Widget**. Unlike **flutter_hook**, which is excellent but invasive, we use **hook_state** that doesn’t require changing **widgets**. Just add a mixin and you’re ready to go.

We have two hooks:
	1.	**useAtomState**: Subscribes to the **Atom** and rebuilds the **Widget** when the state changes.
	2.	**useAtomEffect**: Subscribes to one or more **Atoms** and triggers a callback when they change. This does not affect the **Widget’s** state. It is great for executing code like **Snackbar** or **Navigator**.

With **useAtomEffect**, **RxCallback** is no longer necessary and has been removed.
Pay attention to the mixin that enables Hooks:<br>

For **StatelessWidget**, add the **HookMixin** mixin.<br>
For **StatefulWidget**, add the **HookStateMixin** mixin to the **State**.<br>

**Hooks** will only be available after adding the mixin correctly.

Example:

```dart
class CounterPage extends StatelessWidget with HookMixin {
  const CounterPage({super.key});

  void callSnackBar(int state){
    if(state > 5){
        final snackBar = SnackBar(content: Text('Max $state'));
        Asuka.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    //listen atom
    final state = useAtomState(counterState);

    // listen and call function
    useAtomEffect(
        (get) => get(counterState),
        effect: callSnackBar,
    );
    ...

```

**Hooks** manage the lifecycle automatically, so there is no need to worry about memory "releases" like "dispose". A dream come true!

**OTHER CHANGES**

- **[BREAKING CHANGE]:** **Atom.value** is now **Atom.state**.

- **[NEW]:** The **distinct** property has been added to **Atom** to specify if the user wants to trigger reactivity even if the same state is received.

- **[NEW]:** A new documentation available at [https://asp.flutterando.com.br](https://asp.flutterando.com.br).

- **[FIX]:** Corrected all usage examples.

All support is free in Brazil's largest Flutter community, Flutterando. Join us on [Discord](https://asp.flutterando.com.br).

Let's set the pattern together!


## [1.2.0] - 2023-07-16

* Added: `Atom.next` and `Atom.buffer`;
* Added: Doc FAQ.
* @Deprecated: RxList, RxMap, RxSet, RxFuture and RxStream.

## [1.1.1] - 2023-07-14

* Added: Pipers: Distinct and multiPipe;

## [1.1.0] - 2023-07-12

* Added: Pipes;
* Added: AtomObserver;

## [1.0.4] - 2023-06-08

* Fix callback error;

## [1.0.3] - 2023-05-29

* Added automatic track
* fix reactive callback

## [1.0.0] - 2023-05-26
* Release!

