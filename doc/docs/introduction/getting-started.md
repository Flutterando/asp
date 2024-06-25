---
sidebar_position: 4
---

# Getting Started

## Creating a New Flutter Project

**ASP** is a Flutter-exclusive state management package, so make sure you have the Flutter SDK installed on your machine. (This package will not work with only the Dart SDK).

```
flutter create echo_app
```

For more details, refer to the [official Flutter documentation](https://flutter.dev).

## Installation

To install **ASP** in your project, simply use the command below:

```dart
flutter pub add asp
```

## Atom

**Atoms** hold the micro-states of the application. Anyone can read the current value of an **Atom**, but only an **Action** can change it. All state modifications can trigger widget rebuilds or function calls.

```dart title="lib/atoms.dart"
final textState = atom<String>(
  key: 'textState',
  '',
);
```

## Action

ASP has a peculiar architectural limit: It is not possible to change the state of an **Atom** directly; this can only be done through an **Action**. The reason for this limit is simple: **PREDICTABILITY**. This way, we can visually know who is altering the **Atom**, and it aids in **debugging**.

```dart title="lib/actions.dart"
final changeTextAction = atomAction1<String>(
  key: 'changeTextAction',
  (set, newText) {
    set(textState, newText);
  },
);
```

## Integration with Widgets

No **RootWidget** or **Provider** is needed to connect **Atoms** to a **Widget**.

```dart title="lib/main.dart"
void main() => runApp(const AppWidget());

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Material(
        child: Column(
          children: [
            TextInput(),
            CharacterCount(),
          ],
        ),
      ),
    );
  }
}
```

**Atoms** integrate with Widgets using the **useAtomState()** hook, which should be added inside the **build** method.

```dart title="lib/text_input.dart"
class TextInput extends StatelessWidget with HookMixin {
  const TextInput({super.key});

  @override
  Widget build(BuildContext context) {
    final state = useAtomState(textState);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(onChanged: (text) {
          changeTextAction(text);
        }),
        Text(state),
      ],
    );
  }
}
```

## Selector

A **Selector** is a state derivator. It exclusively serves to combine multiple **Atoms** or transform a state.

```dart title="lib/selectors.dart"
final charCountState = selector<int>(
  key: 'charCountState',
  (get) {
    final text = get(textState);
    return text.length;
  },
);
```
A **Selector** is also an **Atom**, so it can be read using the **useAtomState()** hook.

```dart title="lib/character_count.dart"
class CharacterCount extends StatelessWidget with HookMixin {
  const CharacterCount({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useAtomState(charCountState);
    return Text('Character Count: $count');
  }
}
```

## Demo

<iframe src="https://aspexample.flutterando.com.br"/>


[Source Code](https://github.com/Flutterando/asp/tree/main/example/basic_usage)
