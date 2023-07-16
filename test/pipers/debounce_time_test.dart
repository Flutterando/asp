import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Atom debounce', () async {
    final atom = Atom<String>(
      'Test',
      pipe: debounceTime(),
    );

    expect(atom.buffer(3), completion(['ja', 'jaco', 'jacob']));

    atom.value = 'j';
    atom.value = 'ja';
    await Future.delayed(const Duration(seconds: 1));
    atom.value = 'jac';
    atom.value = 'jaco';
    await Future.delayed(const Duration(seconds: 1));
    atom.value = 'jacob';
  });
}
