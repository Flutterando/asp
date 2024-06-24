import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Atom next', () async {
    final counterState = atom(0);

    await expectLater(
      counterState.next(timeLimit: const Duration(milliseconds: 200)),
      completion(0),
    );

    expect(counterState.next(), completion(1));
    atomAction1<int>((set, arg) => set(counterState, arg))(1);
  });

  test('Atom buffer', () async {
    final counterState = atom(0);

    var buffer = counterState.buffer(
      3,
      timeLimit: const Duration(
        milliseconds: 500,
      ),
    );

    await expectLater(buffer, completion([0]));

    buffer = counterState.buffer(
      3,
      timeLimit: const Duration(
        milliseconds: 500,
      ),
    );

    atomAction1<int>((set, arg) => set(counterState, arg))(1);
    atomAction1<int>((set, arg) => set(counterState, arg))(2);
    atomAction1<int>((set, arg) => set(counterState, arg))(3);

    expect(buffer, completion([1, 2, 3]));
  });

  test('Selector', () async {
    final nameState = atom('Jacob');
    final nameLength = selector((get) => get(nameState).length);

    nameLength.addListener(
      expectAsync0(() {
        expect(nameLength.state, 4);
      }),
    );

    expect(nameLength.state, 5);
    expect(nameLength.next(), completion(4));
    atomAction2<String, String>((set, arg1, arg2) {
      set(nameState, arg1 + arg2);
    })('Jo', 'hn');

    await Future.delayed(const Duration(milliseconds: 500));
    nameLength.dispose();
  });

  test('AsyncSelector', () async {
    final nameState = atom('Jacob');
    final nameLength = asyncSelector(0, (get) async => get(nameState).length);

    await expectLater(nameLength.next(), completion(5));

    expect(nameLength.next(), completion(4));
    atomAction1((set, arg) => set(nameState, arg))('John');

    await Future.delayed(const Duration(milliseconds: 500));
    nameLength.dispose();
  });
}
