import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import 'pages/counter_page.dart';

void main() {
  AtomObserver.changes((status) {
    print(status);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: DefaultTextStyle(style: TextStyle(fontSize: 50), child: CounterPage()),
    );
  }
}
