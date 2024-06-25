import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('atom pipe', () {
    final counter = atom(0, pipes: [TestPipe()]);

    expect(counter.state, 1);

    expect(counter.next(), completion(3));

    atomAction((set) => set(counter, 2))();
  });

  test('atom pipe sequence', () {
    final counter = atom(
      0,
      pipes: [
        TestPipe(),
        TestPipe(),
        TestPipe(),
      ],
    );

    expect(counter.state, 1);

    expect(counter.next(), completion(5));

    atomAction((set) => set(counter, 2))();
  });
}

class TestPipe implements AtomPipe<int> {
  @override
  void init(int value, void Function(int value) emit) {
    emit(1);
  }

  @override
  void pipe(int value, void Function(int newValue) emit) {
    emit(value + 1);
  }
}
