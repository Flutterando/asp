import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Atom interval', () {
    final textState = atom<String>(
      'Test',
      pipe: interval(const Duration(seconds: 1)),
    );

    final start = DateTime.now();

    final diff = expectLater(
      textState.buffer(5),
      completion([
        'j',
        'ja',
        'jac',
        'jaco',
        'jacob',
      ]),
    ).then((_) => DateTime.now().difference(start).inSeconds);

    expect(diff, completion(5));

    atomAction((set) {
      set(textState, 'j');
      set(textState, 'ja');
      set(textState, 'jac');
      set(textState, 'jaco');
      set(textState, 'jacob');
    })();
  });
}
