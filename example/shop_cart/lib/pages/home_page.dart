import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../atoms/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchProductsAction();
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [filteredProductsState.length, filteredProductsState]);

    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: filteredProductsState.length,
            padding: EdgeInsets.only(top: 60),
            itemBuilder: (context, index) {
              final product = filteredProductsState[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text('price: ${product.price}'),
                onTap: () {
                  addProductAction.value = product;
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: TextFormField(
                initialValue: '',
                onChanged: (value) {
                  filterTextState.value = value;
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
        child: RxBuilder(
          builder: (_) {
            return Text('${cartProductsState.length}');
          },
        ),
      ),
    );
  }
}
