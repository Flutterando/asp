import 'package:flutter/material.dart';

import 'character_count.dart';
import 'input_text.dart';

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
