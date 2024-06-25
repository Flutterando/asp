---
sidebar_position: 1
---

# Atom

## Atomic State

**Atoms** represent the state. Each **Atom** can be listened to individually and, when changed, can trigger effects that may rebuild Widgets.

```dart
final counterState = atom(0);
```

Usually, the type of the **Atom** is inferred automatically, but it can also be specified during creation:

```dart
final counterState = atom<int>(0);
```

In Flutter terms, an **Atom** is also a **Listenable**, meaning the **addListener** and **removeListener** methods are available to observe an **Atom** individually.

:::tip[NOTE]

Although it is possible to use the **Listenable** methods like **addListener**, it is recommended to use **atomEffect** instead.

This will help maintain a healthy pattern in the project.

:::

## Key

**Atoms** are prepared to be observed. Therefore, it is important to identify each **Atom** with a unique identifier to make it easier to identify. See more details in the [Observability Section](/docs/extras/observability).

```dart
final counterState = atom<int>(0, key: 'counterState');
```

## Pipes

Sometimes it is necessary to interfere in the normal flow of changing the state of an **Atom** and to do this
We can transform the value right after the state change or right at creation using **AtomPipe**.

Each **Atom** can receive a list of **AtomPipe** that are executed synchronously.<br></br>
**ASP** has some very useful **pipes** already pre-built. Are they:

- `debounceTime`: Emits a notification from an Atom only after a specified period of time has passed without another source issuing. 
- `throttleTime`: Emits a notification from an [Atom], then ignores subsequent source values for duration milliseconds, then repeats this process.
- `intervalPipe`: Emits a notification from an Atom after a given duration.

```dart

final textState = atom<String>(
  'Test',
  pipes: [debounceTime()],
);

expect(textState.buffer(3), completion(['ja', 'jaco', 'jacob']));

final action = atomAction((set) async {
  set(textState, 'j');
  set(textState, 'ja');
  await Future.delayed(const Duration(seconds: 1));
  set(textState, 'jac');
  set(textState, 'jaco');
  await Future.delayed(const Duration(seconds: 1));
  set(textState, 'jacob');
});

action();

```

:::tip[NOTE]

Be sure to look at how to create a custom pipe in the [Custom Pipe Section](/docs/extras/custom-pipe).
:::



