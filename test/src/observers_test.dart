import 'package:asp/asp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Observers Register changes', () {
    AtomObserver.changes(
      expectAsync1((status) {
        expect(status.toString(), isNotNull);
        expect(status.event, AtomEvent.change);
        expect(status.atom.key, 'counter');
        expect(status.atom.state, 1);
        expect(status.action, 'atomAction3');
      }),
    );

    final counterState = atom<int>(0, key: 'counter');
    atomAction3((set, arg1, arg2, arg3) => set(counterState, 1))('', '', '');
  });

  test('Observers Register listen and unlisten', () async {
    AtomObserver.changes(
      expectAsync1((status) {
        expect(status.toString(), isNotNull);
        expect(status.event, AtomEvent.listen);
        expect(status.atom.key, 'counter');
        expect(status.atom.state, 0);
        expect(status.action, isNull);
      }),
    );

    final counterState = atom<int>(0, key: 'counter');
    final disposer = atomEffect((get) => get(counterState));
    await Future.delayed(const Duration(milliseconds: 500));

    AtomObserver.changes(
      expectAsync1((status) {
        expect(status.toString(), isNotNull);
        expect(status.event, AtomEvent.unlisten);
        expect(status.atom.key, 'counter');
        expect(status.atom.state, 0);
        expect(status.action, isNull);
      }),
    );

    disposer();
  });

  test('Observers Register dispose', () {
    AtomObserver.changes(
      expectAsync1((status) {
        expect(status.toString(), isNotNull);
        expect(status.event, AtomEvent.dispose);
        expect(status.atom.key, 'counter');
        expect(status.atom.state, 0);
        expect(status.action, isNull);
      }),
    );

    final counterState = atom<int>(0, key: 'counter');

    counterState.dispose();
  });
}
