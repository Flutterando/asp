import 'dart:developer';

import 'package:asp/asp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('concat operator extension', () {
    final rx1 = Atom(0);
    final rx2 = Atom(0);
    final listenables = rx1 + rx2;
    final list = [];
    listenables.addListener(() {
      list.add(rx1.value);
    });
    rx1.value = 1;
    rx2.value = 2;
    expect(list, equals([1, 1]));
  });

  test('should dispatch rx value', () {
    final c = Atom<int>(0);
    final list = <int>[];
    rxObserver(() {
      list.add(c.value);
    });
    c.value = 1;
    c.value = 2;
    c.value = 3;
    c.value = 4;
    c.value = 5;

    expect(list, equals([0, 1, 2, 3, 4, 5]));
  });

  test('should dispatch rx value and listen effect', () {
    final c = Atom<int>(0);
    final list = <int>[];
    rxObserver<int>(
      () => c.value,
      effect: (value) {
        list.add(value!);
      },
    );
    c.value = 1;
    c.value = 2;
    c.value = 3;
    c.value = 4;
    c.value = 5;
    expect(list, equals([1, 2, 3, 4, 5]));
  });
  test('convert ValueListenable to Rx', () {
    final c = ValueNotifier(0).asAtom();
    final list = <int>[];
    rxObserver(() {
      list.add(c.value);
    });
    c.value = 1;
    c.value = 2;
    c.value = 3;
    c.value = 4;
    c.value = 5;

    expect(list, equals([0, 1, 2, 3, 4, 5]));
  });
  test('filter rx', () {
    final c = ValueNotifier(0).asAtom();
    final list = <int>[];
    rxObserver(
      () {
        list.add(c.value);
      },
      filter: () => c.value != 3,
    );
    c.value = 1;
    c.value = 2;
    c.value = 3;
    c.value = 4;
    c.value = 5;

    expect(list, equals([0, 1, 2, 4, 5]));
  });

  test('computed values', () {
    final a = Atom(0);
    final b = ValueNotifier(0).asAtom();
    final listA = <int>[];
    final listB = <int>[];
    rxObserver(() {
      log('A: ${a.value} | B: ${b.value}');
      listA.add(a.value);
      listB.add(b.value);
    });
    a.value = 1;
    b.value = 2;
    b.value = 3;

    expect(listA, equals([0, 1, 1, 1]));
    expect(listB, equals([0, 0, 2, 3]));
  });

  test('Buffer values', () {
    final a = Atom(0);
    expect(a.buffer(3), completion([1, 3, 3]));

    a.setValue(1);
    a.setValue(3);
    a.setValue(3);
  });

  test('Buffer values with state pattern', () {
    final a = Atom<TestState>(StartTestState());
    expect(
      a.buffer(2),
      completion([
        isA<LoadingTestState>(),
        isA<SuccessTestState>(),
      ]),
    );

    a.value = LoadingTestState();
    a.value = SuccessTestState();
  });
}

sealed class TestState {}

class StartTestState implements TestState {}

class LoadingTestState implements TestState {}

class SuccessTestState implements TestState {}
