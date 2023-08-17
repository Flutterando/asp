import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('rxNext', () async {
    final atom = Atom(0);

    Future.delayed(const Duration(seconds: 1)).then((value) {
      atom.value++;
    });

    final value = await aspNext(atom);
    expect(value, 1);
  });
}
