---
sidebar_position: 3
---

# Observability

The biggest challenge in reactivity is observability. We have taken this to the next level with **ASP**. Now, you can track which action modified the state of an **Atom**, and when someone starts or stops listening to an **Atom**. 

```dart
void main() {

  AtomObserver.changes((status) {
    print(status.atom); // counterState
    print(status.action); // incrementAction
    print(status.event.name) // change
  });

  runApp(MyApp());
}


