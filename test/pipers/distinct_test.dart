import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Atom Distinct', () async {
    final atom = Atom<String>(
      'Test',
      pipe: distinct(),
    );

    var count = 0;
    final completer = Completer();

    atom.addListener(
      expectAsync0(
        max: 2,
        () {
          if (count < 1) {
            expect(atom.value, 'changes');
          } else {
            expect(atom.value, 'UP');
            completer.complete();
          }

          count++;
        },
      ),
    );

    atom.value = 'changes';
    atom.value = 'changes';
    atom.value = 'changes';
    atom.value = 'changes';
    atom.value = 'UP';

    await completer.future;
  });
}
