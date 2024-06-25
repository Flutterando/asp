import 'package:asp/asp.dart';

import 'atoms.dart';

final charCountState = selector<int>(
  key: 'charCountState',
  (get) {
    final text = get(textState);
    return text.length;
  },
);
