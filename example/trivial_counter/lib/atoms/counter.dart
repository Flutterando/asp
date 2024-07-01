import 'package:asp/asp.dart';

// atom
final counterState = atom<int>(
  key: 'counterState',
  0,
);

// selectors
final parityState = selector(
  key: 'parityState',
  (get) {
    return get(counterState).isEven ? 'Even' : 'Odd';
  },
);

// actions
final counterAction = atomAction1<String>(
  key: 'counterAction',
  (set, action) {
    final state = counterState.state;
    if (action == 'increment') {
      set(counterState, state + 1);
    } else if (action == 'decrement') {
      set(counterState, state - 1);
    }
  },
);
