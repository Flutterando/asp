import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Atom interval', () {
    final atom = Atom<String>(
      'Test',
      pipe: interval(const Duration(seconds: 1)),
    );

    final start = DateTime.now();

    final diff = expectLater(
      atom.buffer(5),
      completion([
        'j',
        'ja',
        'jac',
        'jaco',
        'jacob',
      ]),
    ).then((_) => DateTime.now().difference(start).inSeconds);

    expect(diff, completion(5));

    atom.value = 'j';
    atom.value = 'ja';
    atom.value = 'jac';
    atom.value = 'jaco';
    atom.value = 'jacob';
  });
}
