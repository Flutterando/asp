---
sidebar_position: 4
---

# Hooks

Hooks are special functions that allow a component to connect to the lifecycle of a widget.

We are adding a **hooks** system to subscribe **Atoms** to a **Widget**. Unlike **flutter_hook**, which is excellent but invasive, we use **hook_state** that doesn’t require changing **widgets**. Just add a mixin and you’re ready to go.

We have two hooks:
1. **useAtomState**: Subscribes to the **Atom** and rebuilds the **Widget** when the state changes.
2. **useAtomEffect**: Subscribes to one or more **Atoms** and triggers a callback when they change. This does not affect the **Widget’s** state. It is great for executing code like **Snackbar** or **Navigator**.

**Pay attention to the mixin that enables Hooks!!!**

For **StatelessWidget**, add the **HookMixin** mixin.<br></br>
For **StatefulWidget**, add the **HookStateMixin** mixin to the **State**.

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


