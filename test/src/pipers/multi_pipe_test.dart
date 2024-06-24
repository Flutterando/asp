import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('multi pipe ...', () {
    final textState = atom<String>(
      'n',
      pipe: multiPipe([
        (value, emit) {
          expect(value, 'fa');
          emit('${value}1');
        },
        (value, emit) {
          expect(value, 'fa1');
          emit('${value}2');
        },
        (value, emit) {
          expect(value, 'fa12');
          emit('${value}3');
        },
        (value, emit) {
          expect(value, 'fa123');
          emit('${value}4');
        },
      ]),
    );

    expect(textState.next(), completion('fa1234'));

    atomAction((set) {
      set(textState, 'fa');
    })();
  });
}
