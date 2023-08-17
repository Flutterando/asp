import 'package:asp/asp.dart';
import 'package:example/src/module.dart';
import 'package:flutter/material.dart';
import 'package:uno/uno.dart';

import 'src/pages/home.dart';
import 'src/reducers/burg_reducer.dart';
import 'src/services/burg_service.dart';

void main() {
  injector.addInstance(Uno());
  injector.add(BurgService.new);
  injector.addSingleton(BurgReducer.new);
  injector.commit();

  runApp(const ASPRoot(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red,
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}
