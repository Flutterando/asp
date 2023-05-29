import 'package:asp/asp.dart';

import '../atom/burg_atom.dart';
import '../atom/cart_atom.dart';
import '../services/burg_service.dart';

class BurgReducer extends Reducer {
  final BurgService service;

  BurgReducer(this.service) {
    on(() => [fetchBurgs], _fetchBurgs);
    on(() => [addBurg], _addBurg);
    on(() => [removeBurg], _removeBurg);
    on(() => [cleanCart], _cleanCart);
    on(() => [cartBurgs.length], _changeFinalValue);
  }

  _changeFinalValue() {
    final value = cartBurgs.fold(0.0, (previousValue, element) => previousValue + element.price);
    finalValue.value = r'R$ ' + value.toStringAsFixed(2);
  }

  _fetchBurgs() async {
    burgLoading.value = true;

    final result = await service.fetchBurgs();
    burgs.clear();
    burgs.addAll(result);

    burgLoading.value = false;
  }

  _addBurg() {
    final burg = addBurg.value;
    if (burg != null) {
      cartBurgs.add(burg);
    }
  }

  _removeBurg() {
    final burg = removeBurg.value;
    if (burg != null) {
      cartBurgs.remove(burg);
    }
  }

  _cleanCart() => cartBurgs.clear();
}
