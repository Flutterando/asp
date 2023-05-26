import 'package:asp/asp.dart';
import 'package:example/models/product_model.dart';

// atoms
final productsState = RxList<ProductModel>();
final cartProductsState = RxList<ProductModel>();
final filterTextState = Atom('');

// computeds
List<ProductModel> get filteredProductsState {
  if (filterTextState.value.isEmpty) {
    return productsState;
  }
  return productsState.where((product) => product.title.contains(filterTextState.value)).toList();
}

// actions
final addProductAction = Atom<ProductModel?>(null);
final fetchProductsAction = Atom(null);
