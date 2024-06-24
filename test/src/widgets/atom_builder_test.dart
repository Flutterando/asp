import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('atom builder', (tester) async {
    final counter = atom(0);
    final increment = atomAction((set) => set(counter, counter.state + 1));

    await tester.pumpWidget(
      MaterialApp(
        home: CustomPageForBuilder(counterState: counter),
      ),
    );
    WidgetsBinding.instance.reassembleApplication();

    expect(find.text('0'), findsOneWidget);
    increment();
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    increment();
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
  });
}

class CustomPageForBuilder extends StatelessWidget {
  final Atom<int> counterState;
  const CustomPageForBuilder({super.key, required this.counterState});

  @override
  Widget build(BuildContext context) {
    return AtomBuilder(
      builder: (_, get) => Text('${get(counterState)}'),
    );
  }
}
