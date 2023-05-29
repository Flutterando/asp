import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../atom/cart_atom.dart';

class CartDrawer extends StatelessWidget {
  const CartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    context.callback(() => cartBurgs.length, (value) {
      if (cartBurgs.isEmpty) {
        if (context.mounted) {
          Navigator.of(context).maybePop();
        }
      }
    });

    context.select(() => [cartBurgs.length, finalValue.value]);
    return Drawer(
      width: 240,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          children: [
            Text(
              'Sacola',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cartBurgs.length,
                itemBuilder: (context, index) {
                  final model = cartBurgs[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    leading: ClipOval(
                      child: Image.network(
                        model.image,
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    title: Text(model.title),
                    subtitle: Text(model.toMoney()),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline_rounded),
                      onPressed: () {
                        removeBurg.setValue(model);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Valor: ${finalValue.value}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Finalizar compra'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                cleanCart();
              },
              child: const Text('Limpar sacola'),
            ),
          ],
        ),
      ),
    );
  }
}
