import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import 'actions.dart';
import 'atoms.dart';

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
