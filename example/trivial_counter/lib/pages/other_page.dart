import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../atoms/counter.dart';

class OtherPage extends StatelessWidget with HookMixin {
  @override
  Widget build(BuildContext context) {
    final state = useAtomState(counterState);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              parityState.state,
              style: TextStyle(fontSize: 40),
            ),
            Text(
              '$state',
              style: TextStyle(fontSize: 23),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.remove),
        onPressed: () => counterAction('decrement'),
      ),
    );
  }
}
