import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('status', () async {
    final rxFuture = getCounterFuture(1).asAtom();
    final completer = Completer();
    var number = 0;
    rxObserver(() {
      if (rxFuture.status == FutureStatus.pending) {
        return;
      }
      number = rxFuture.data ?? 0;
      completer.complete(true);
    });
    await completer.future;
    expect(number, 1);
  });

  test('added new Future', () async {
    final rxFuture = getCounterFuture(1).asAtom();
    final completer = Completer();
    final list = [];
    rxObserver(() {
      if (rxFuture.status == FutureStatus.pending) {
        return;
      }
      list.add(rxFuture.data);
      if (rxFuture.data == 1) {
        rxFuture.value = getCounterFuture(2);
      } else if (rxFuture.data == 2) {
        completer.complete(true);
      }
    });

    await completer.future;
    expect(list, [1, 2]);
  });
}

Future<int> getCounterFuture(int value) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return value;
}
