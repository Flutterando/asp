import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../atoms/product.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final length = context.select(() => cartProductsState.length);

    return Scaffold(
      appBar: AppBar(title: Text(' Cart')),
      body: ListView.builder(
        itemCount: length,
        itemBuilder: (context, index) {
          final product = cartProductsState[index];
          return ListTile(
            title: Text(product.title),
            subtitle: Text('price: ${product.price}'),
            trailing: IconButton(
              onPressed: () {
                productsState.remove(product);
              },
              icon: Icon(Icons.remove_circle_outline),
            ),
          );
        },
      ),
    );
  }
}
