import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDownAll(() => AtomObserver.changes(null));
  test('Atom Observer', () async {
    AtomObserver.changes((atom) {
      if (atom.key == 'atom1') {
        expect(atom.value, 'mudando1');
      }
      if (atom.key == 'atom2') {
        expect(atom.value, 'mudando2');
      }
    });

    final atom1 = Atom(
      key: 'atom1',
      'Test',
    );

    final atom2 = Atom(
      key: 'atom2',
      'Test',
    );

    atom1.value = 'mudando1';
    atom2.value = 'mudando2';

    await Future.delayed(const Duration(seconds: 1));
  });
}
