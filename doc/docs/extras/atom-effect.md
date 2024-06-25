---
sidebar_position: 2
---

# AtomEffect

Auxiliary function to listen to changes in one or more **Atom**.<br></br>
This was the old way of listening to the effects of reactivities, and using the
hook **useAtomEffect()** will always be the best option, as it handles the
life cycle automatically.<br></br>
However, we maintain this API to help in some very specific cases, such as
unit tests.

```dart

final disposer = atomEffect(
    (get) => get(counterState),
    (state) => print('Number is $state'),
);

// release
disposer();
```





