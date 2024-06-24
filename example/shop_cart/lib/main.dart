import 'package:asp/asp.dart';
import 'package:example/src/module.dart';
import 'package:flutter/material.dart';
import 'package:uno/uno.dart';

import 'src/pages/home.dart';
import 'src/services/burg_service.dart';

void main() {
  injector.addInstance(Uno());
  injector.add(BurgService.new);
  injector.commit();
  AtomObserver.changes((status) {
    print(status);
  });
  runApp(MyApp());
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
