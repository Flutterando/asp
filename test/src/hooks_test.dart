import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('hooks', (tester) async {
    final counter = atom(0);
    final increment = atomAction((set) => set(counter, counter.state + 1));

    final effectResponse = <int>[];

    await tester.pumpWidget(
      MaterialApp(
        home: CustomPageForHooks(
          counterState: counter,
          effect: effectResponse.add,
        ),
      ),
    );

    expect(find.text('0'), findsOneWidget);
    increment();
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    increment();
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    expect(effectResponse, [1, 2]);
  });
}

class CustomPageForHooks extends StatelessWidget with HookMixin {
  final Atom<int> counterState;
  final void Function(int) effect;
  const CustomPageForHooks({
    super.key,
    required this.counterState,
    required this.effect,
  });

  @override
  Widget build(BuildContext context) {
    final state = useAtomState(counterState);
    useAtomEffect(
      (get) => get(counterState),
      effect: effect,
    );

    return Text('$state');
  }
}
