import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Atom interval', () async {
    final atom = Atom<String>(
      'Test',
      pipe: interval(const Duration(seconds: 1)),
    );

    var i = 0;

    atom.addListener(
      expectAsync0(
        max: 5,
        () {
          i++;
          expect(atom.value, 'jacob'.substring(0, i));
        },
      ),
    );

    atom.value = 'j';
    atom.value = 'ja';
    atom.value = 'jac';
    atom.value = 'jaco';
    atom.value = 'jacob';

    await Future.delayed(const Duration(seconds: 7));
  });
}
