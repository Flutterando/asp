import 'package:asp/asp.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../atom/burg_atom.dart';
import '../atom/cart_atom.dart';
import '../widgets/burg_card.dart';
import '../widgets/cart_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldState get scaffoldState => scaffoldKey.currentState!;

  @override
  void initState() {
    super.initState();
    fetchBurgs();
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [burgs, burgLoading, cartBurgs]);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[Container()],
        title: const Text('Flutter Burge'),
        centerTitle: true,
      ),
      endDrawer: const CartDrawer(),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: burgs.length,
            itemBuilder: (context, index) {
              final model = burgs[index];
              return BurgCard(
                model: model,
                onTap: () {
                  addBurg.setValue(model);
                },
              );
            },
          ),
          if (burgLoading.value)
            const Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (cartBurgs.isNotEmpty) {
            scaffoldState.openEndDrawer();
          }
        },
        child: badges.Badge(
          badgeContent: Text('${cartBurgs.length}'),
          child: const Icon(Icons.shopping_bag_outlined),
        ),
      ),
    );
  }
}
