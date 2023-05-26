import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import 'module.dart';
import 'pages/cart_page.dart';
import 'pages/home_page.dart';

void main() {
  injector.commit();
  runApp(RxRoot(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/cart': (context) => CartPage(),
      },
    );
  }
}
