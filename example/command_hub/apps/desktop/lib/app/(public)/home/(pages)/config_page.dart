import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

Route routeBuilder(BuildContext context, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, a1, a2) => const ConfigPage(),
    transitionsBuilder: (_, a1, a2, child) {
      return FadeTransition(opacity: a1, child: child);
    },
  );
}

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommandScaffold(
      title: 'Config',
      subtitle: 'Configure your Command Hub',
      body: Center(
        child: Text('Config Page'),
      ),
    );
  }
}
