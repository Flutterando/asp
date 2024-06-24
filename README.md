
# ASP - Atomic State Pattern

ASP (Atomic State Pattern) offers a simplified, predictable, and powerful state management solution for Flutter.

![ASP](/assets/ASP.png)

## Install

```sh
flutter pub add asp
```

## Migrate v1 to v2

For migration details, check out [this link](https://asp.flutterando.com.br).

## Motivation

We want state management to be enjoyable! However, we also aim to avoid creating magical tools that start great but eventually become a nightmare for the project. After years of grappling with this issue, we decided to take action.

We looked at successful patterns on the web and noticed the significant growth of Signals/Atoms. This inspired us to base our research on reactive micro-states, allowing us to derive multiple micro-states into one seamlessly.

Thus, ASP was born. While micro-states brought many benefits, they also introduced the challenge of state segmentation. In large projects, we often ended up with a file full of small ValueNotifiers or Atoms. Although everything functioned, some updates occurred without the developer's knowledge, leading to uncontrolled side effects.

Moreover, state updates became unpredictable, causing hours of troubleshooting among thousands of micro-states and their computations. ASP v2 aims to bring more predictability and architectural limits necessary for maintainability, creating a multi-modal pattern suitable for both small and large projects.

![atom](/assets/atom.png)

## Quick Start

**Atom** is the core of the atomic state. It allows creating an object that stores an autonomous micro-state, observable by anything—whether a widget or a function. However, an Atom could be modified by anything, anywhere, leading to classic side-effect problems. To address this, we removed the state setter and added **AtomAction**. This ensures that while an **Atom** can be listened to by anything, it can only be modified in a specific place, enhancing predictability and reducing uncontrolled side effects.

Example:
```dart
// Atom creation
final counterState = atom(0);

// Listen to changes
counterState.addListener(() {
    print(counterState.state); // 1
});

// Action creation
final increment = atomAction((set) {
    return set(counterState, 1);
});

// Execute action
increment();
```

This simple limitation provides significant predictability in state propagation. The scope of **AtomAction** contains the **set** property, which is the only way to update a state. You can have **AtomAction** with up to 3 parameters:
- atomAction1
- atomAction2
- atomAction3

Example:
```dart
final counterAction = atomAction1<String>((set, action) {
    final state = counterState.state;

    if(action == 'INCREMENT') {
        set(counterState, state + 1);
    } else if(action == 'DECREMENT') {
        set(counterState, state - 1);
    }
});

counterAction('INCREMENT');
```

This versatility allows for a simple common call, a pub-sub mechanism, or even turning an action into a state reducer, making everything more interesting.

## Combine multiple Atoms with SELECTORS

Managing state distribution and converging multiple states into a new one was a major challenge in the case study that led to the creation of **ASP**. We introduced a very simple way to combine multiple **Atoms** and compute a new value whenever any of them changes, using **AtomSelector**.

Example:
```dart
// Atoms
final nameState = atom('');
final lastNameState = atom('');

// Selector
final fullName = selector((get) {
    final name = get(nameState);
    final lastName = get(lastNameState);
    return '$name $lastName';
});

// Action
final changeName = atomAction1<String>((set, name) {
    set(nameState, name);
});

changeName('Matias');
```

Within the **selector’s** internal scope, the get property subscribes to an **Atom**, showing what is being observed. This example demonstrates the three pillars of **ASP**: **Atoms**, **Selectors**, and **Actions**.

Additionally, you can derive states asynchronously with **AsyncSelector**:

Example:
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

This example shows a more complex derivation where modifying an Atom triggers an external API call. Now that we’ve shown how to use Atom with **Selector** and modify it only in **Actions**, let’s talk about how we’ve made it easier to connect all this with Widgets.

## Automatic subscription with **HOOKS**

We are adding a **hooks** system to subscribe **Atoms** to a **Widget**. Unlike **flutter_hook**, which is excellent but invasive, we use **hook_state** that doesn’t require changing **widgets**. Just add a mixin and you’re ready to go.

We have two hooks:
1. **useAtomState**: Subscribes to the **Atom** and rebuilds the **Widget** when the state changes.
2. **useAtomEffect**: Subscribes to one or more **Atoms** and triggers a callback when they change. This does not affect the **Widget’s** state. It is great for executing code like **Snackbar** or **Navigator**.

**Pay attention to the mixin that enables Hooks!!!**

For **StatelessWidget**, add the **HookMixin** mixin.<br>
For **StatefulWidget**, add the **HookStateMixin** mixin to the **State**.<br>

**Hooks** will only be available after adding the mixin correctly.

Example:
```dart
class CounterPage extends StatelessWidget with HookMixin {
  const CounterPage({super.key});

  // Atom effect
  void callSnackBar(int state) {
    if (state > 5) {
        final snackBar = SnackBar(content: Text('Max $state'));
        Asuka.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to atom
    final state = useAtomState(counterState);

    // Listen and call function
    useAtomEffect(
        (get) => get(counterState),
        effect: callSnackBar,
    );
    ...
```

**Hooks** manage the lifecycle automatically, so there is no need to worry about memory "releases" like "dispose". A dream come true!

## Rules

To effectively use this approach, consider these architectural limits:

1. All states must be an **Atom**.
2. An **Atom** can only be altered by an **Action**.
3. Use **atomSelector** to combine multiple **Atoms**.
4. Anything outside these rules is incorrect.

## Learn more about ASP

This is just the beginning of a world of possibilities! Check out the [official documentation](https://asp.flutterando.com.br) for much more!

## Examples

Flutter projects using Atom:

- [Trivial Counter](https://github.com/Flutterando/asp/tree/main/example/trivial_counter).
- [Shop Cart](https://github.com/Flutterando/asp/tree/main/example/shop_cart).

## Features and bugs

Please send feature requests and bug reports to the issue tracker.

This README was created based on templates made available by Stagehand under a BSD-style license.
