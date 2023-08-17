import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('rx add', () async {
    final list = RxList(['jacob', 'sara']);
    var addCount = 0;
    aspObserver(
      () => list.value,
      effect: (val) {
        addCount++;
      },
    );
    await Future.delayed(const Duration(milliseconds: 800));
    list.add('novo');
    await Future.delayed(const Duration(milliseconds: 800));
    list.add('novo 2');
    await Future.delayed(const Duration(milliseconds: 800));
    expect(addCount, equals(2));
    expect(list.length, equals(4));
  });

  test('rx contains', () async {
    final list = RxList.of(['jacob', 'sara']);
    expect(list, contains('jacob'));
  });

  test('rx list observer effect', () async {
    final list = Atom(RxList(['jacob', 'sara']));
    var effectHappened = false;
    aspObserver(
      () => list.value,
      effect: (val) {
        effectHappened = list.value.contains('coco');
      },
    );
    list.value.add('coco');
    expect(effectHappened, isTrue);
  });

  test('replace rxlist and keep reactivity', () async {
    final list = Atom(RxList(['jacob', 'sara']));
    var ignoreFirstReaction = true;
    aspObserver(
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
