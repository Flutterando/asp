---
sidebar_position: 2
---

# Action

**Atom** is the core of the atomic state. It allows creating an object that stores an autonomous micro-state, observable by anything—whether a widget or a function. However, an Atom could be modified by anything, anywhere, leading to classic side-effect problems. To address this, we removed the state setter and added **AtomAction**. This ensures that while an **Atom** can be listened to by anything, it can only be modified in a specific place, enhancing predictability and reducing uncontrolled side effects.

```dart
// Atom creation
final counterState = atom(0);

// Listen to changes
counterState.addListener(() {
    print(counterState.state); // 1
});

// Action creation
final increment = atomAction((set) {
    set(counterState, 1);
});

// Execute action
increment();
```

This simple limitation provides significant predictability in state propagation. The scope of **AtomAction** contains the **set** property, which is the only way to update a state. You can have **AtomAction** with up to 3 parameters:
- `atomAction1`
- `atomAction2`
- `atomAction3`

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
