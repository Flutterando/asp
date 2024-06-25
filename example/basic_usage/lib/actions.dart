import 'package:asp/asp.dart';

import 'atoms.dart';

final changeTextAction = atomAction1<String>(
  key: 'changeTextAction',
  (set, newText) {
    set(textState, newText);
  },
);
