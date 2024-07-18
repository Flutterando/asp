import 'package:core_module/core_module.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'routes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Desktop Example',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        platform: TargetPlatform.macOS,
        colorScheme: MaterialTheme.lightMediumContrastScheme(),
      ),
      darkTheme: ThemeData(
        platform: TargetPlatform.macOS,
        colorScheme: MaterialTheme.darkMediumContrastScheme(),
        brightness: Brightness.dark,
      ),
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.home.commands,
        // routeBuilder: (context, settings, child) {
        //   return PageRouteBuilder(
        //     settings: settings,
        //     pageBuilder: (context, _, __) {
        //       return child;
        //     },
        //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //       return FadeTransition(
        //         opacity: animation,
        //         child: child,
        //       );
        //     },
        //   );
        // },
      ),
    );
  }
}
