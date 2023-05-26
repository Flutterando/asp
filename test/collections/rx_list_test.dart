import 'dart:developer';

import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('rx add', () async {
    final list = RxList(['jacob', 'sara']);
    rxObserver(() {
      log('----------------');
      for (final item in list) {
        log(item);
      }
    });
    await Future.delayed(const Duration(milliseconds: 800));
    list.add('novo');
    await Future.delayed(const Duration(milliseconds: 800));
    list.add('novo 2');
    await Future.delayed(const Duration(milliseconds: 800));
  });
  test('rx contains', () async {
    final list = RxList(['jacob', 'sara']);
    assert(list.contains('jacob'));
  });

  test('rx list observer effect', () async {
    final list = Atom(RxList(['jacob', 'sara']));
    var effectHappened = false;
    rxObserver(
      () => list.value,
      effect: (val) {
        effectHappened = list.value.contains('coco');
      },
    );
    list.value.add('coco');
    assert(effectHappened);
  });

  test('replace rxlist and keep reactivity', () async {
    final list = Atom(RxList(['jacob', 'sara']));
    var ignoreFirstReaction = true;
    rxObserver(
      () => list.value,
      effect: expectAsync1((val) {
        if (ignoreFirstReaction) {
          ignoreFirstReaction = false;
          return;
        }
        expect(list.value.contains('coco'), isTrue);
      }),
    );
    list.value = RxList();
    list.value.add('coco');
  });
}
