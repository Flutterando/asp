import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../atoms/counter.dart';

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = context.select(() => counterState.value);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              countText,
              style: TextStyle(fontSize: 40),
            ),
            Text(
              '$value',
              style: TextStyle(fontSize: 23),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.remove),
        onPressed: () => counterState.value--,
      ),
    );
  }
}
