import 'package:asp/asp.dart';
import 'package:example/models/product_model.dart';

import '../atoms/product.dart';

class ShopReducer extends RxReducer {
  ShopReducer() {
    on(() => [fetchProductsAction], _fetchProductsReducer);
    on(() => [addProductAction], _addProductReducer);
  }

  void _addProductReducer() {
    if (addProductAction.value != null) {
      cartProductsState.add(addProductAction.value!);
    }
  }

  void _fetchProductsReducer() {
    productsState.addAll([
      ProductModel(
        title: 'Product 1',
        imageUrl: '',
        price: 1000,
      ),
      ProductModel(
        title: 'Product 2',
        imageUrl: '',
        price: 1000,
      ),
      ProductModel(
        title: 'Product 3',
        imageUrl: '',
        price: 1000,
      ),
      ProductModel(
        title: 'Product 4',
        imageUrl: '',
        price: 1000,
      ),
    ]);
  }
}
