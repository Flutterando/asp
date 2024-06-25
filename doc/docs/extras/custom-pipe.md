---
sidebar_position: 5
---

# Custom pipe

We can create our own pipes just by implementing the **AtomPipe** interface.<br></br>
The **init()** method is called when creating **Atom** while the **pipe** method is called when changing
of State.

```dart

class StringHydratedPipe implements AtomPipe<String> {

  @override
  void init(String state, void Function(String state) emit) async {
    final shared = await SharedPreferences.getInstance();
    final newState = shared.getString('KEY-STRING') ?? '';
    emit(newState);
  }

  @override
  void pipe(String state, void Function(String state) emit) async {
    final shared = await SharedPreferences.getInstance();
    shared.setString('KEY-STRING', state);
    emit(state);
  }

}

```