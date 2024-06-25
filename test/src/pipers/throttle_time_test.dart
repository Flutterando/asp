import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Atom throttle', () async {
    final textState = atom<String>(
      '',
      pipes: [throttleTime()],
    );

    expect(textState.buffer(3), completion(['j', 'jac', 'jacob']));

    atomAction((set) async {
      set(textState, 'j');
      set(textState, 'ja');
      await Future.delayed(const Duration(seconds: 1));
      set(textState, 'jac');
      set(textState, 'jaco');
      await Future.delayed(const Duration(seconds: 1));
      set(textState, 'jacob');
    })();
  });
}
