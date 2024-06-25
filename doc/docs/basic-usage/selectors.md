---
sidebar_position: 3
---

# Selector

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
