import 'package:asp/asp.dart';
import 'package:example/pages/other_page.dart';
import 'package:flutter/material.dart';

import '../atoms/counter.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.select(() => counterState.value);

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => OtherPage(),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                countText,
                style: const TextStyle(fontSize: 40),
              ),
              Text(
                '$value',
                style: const TextStyle(fontSize: 23),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => counterState.value++,
      ),
    );
  }
}
