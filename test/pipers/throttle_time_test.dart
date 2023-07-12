import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Atom throttle', () async {
    final atom = Atom<String>(
      'Test',
      pipe: throttleTime(),
    );

    var i = 0;

    atom.addListener(
      expectAsync0(
        max: 3,
        () {
          if (i == 0) {
            expect(atom.value, 'j');
          } else if (i == 1) {
            expect(atom.value, 'jac');
          }
          if (i == 2) {
            expect(atom.value, 'jacob');
          }
          i++;
        },
      ),
    );

    atom.value = 'j';
    atom.value = 'ja';
    await Future.delayed(const Duration(seconds: 1));
    atom.value = 'jac';
    atom.value = 'jaco';
    await Future.delayed(const Duration(seconds: 1));
    atom.value = 'jacob';
    await Future.delayed(const Duration(seconds: 1));
  });
}
