import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Atom throttle', () async {
    final atom = Atom<String>(
      'Test',
      pipe: throttleTime(),
    );

    expect(atom.buffer(3), completion(['j', 'jac', 'jacob']));

    atom.value = 'j';
    atom.value = 'ja';
    await Future.delayed(const Duration(seconds: 1));
    atom.value = 'jac';
    atom.value = 'jaco';
    await Future.delayed(const Duration(seconds: 1));
    atom.value = 'jacob';
  });
}
