import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Atom Distinct', () {
    final atom = Atom<String>(
      'Test',
      pipe: distinct(),
    );

    expect(atom.buffer(2), completion(['changes', 'UP']));

    atom.value = 'changes';
    atom.value = 'changes';
    atom.value = 'changes';
    atom.value = 'changes';
    atom.value = 'UP';
  });
}
