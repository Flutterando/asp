import 'package:asp/asp.dart';
import 'package:example/src/module.dart';

import '../models/burg_model.dart';
import '../services/burg_service.dart';

// atoms
final burgsState = atom<List<BurgModel>>(
  [],
  key: 'burgsState',
);

final burgLoadingState = atom(
  true,
  key: 'burgLoadingState',
);

final cartBurgsState = atom<List<BurgModel>>(
  [],
  key: 'cartBurgsState',
);

// selectors
final cartTotalState = Atom<String>.selector((get) {
  final burgs = get(cartBurgsState);
  final value = burgs.fold(
    0.0,
    (previousValue, element) => previousValue + element.price,
  );
  return r'R$ ' + value.toStringAsFixed(2);
});

// actions
final burgsAction = atomAction1<String>(
  (set, action) async {
    final service = injector.get<BurgService>();

    if (action == 'fetchAll') {
      set(burgLoadingState, true);
      final result = await service.fetchBurgs();
      set(burgLoadingState, false);

      set(burgsState, result);
    }
  },
);

final addCartBurgAction = atomAction1<BurgModel>(
  (set, burg) {
    set(cartBurgsState, [...cartBurgsState.state, burg]);
  },
);

final removeBurgCartAction = atomAction1<BurgModel>(
  (set, burg) {
    final newBurgs = cartBurgsState.state.where((element) => element.id != burg.id).toList();
    set(cartBurgsState, newBurgs);
  },
);

final cleanCartAction = atomAction(
  (set) {
    set(cartBurgsState, <BurgModel>[]);
  },
);
