---
sidebar_position: 1
---

# AtomBuilder

In most cases you should prefer to use hooks like **useAtomState()**, but if
it is really necessary to rebuild only a part of the screen, either through widgets
heavy on the tree or other reasons, use **AtomBuilder**.

The **AtomBuilder** contains the **get** property that will subscribe to an **Atom** or **Selector**
to react according to state changes.

```dart
  @override
  Widget build(BuildContext context) {
    return AtomBuilder(
      builder: (_, get) => Text('${get(counterState)}'),
    );
  }
```
