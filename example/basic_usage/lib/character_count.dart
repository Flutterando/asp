import 'package:asp/asp.dart';
import 'package:basic_usage/selectors.dart';
import 'package:flutter/material.dart';

class CharacterCount extends StatelessWidget with HookMixin {
  const CharacterCount({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useAtomState(charCountState);
    return Text('Character Count: $count');
  }
}
