import 'package:command_hub/routes.g.dart';
import 'package:core_module/core_module.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

Route routeBuilder(BuildContext context, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, a1, a2) => const CommandsPage(),
    transitionsBuilder: (_, a1, a2, child) {
      return FadeTransition(opacity: a1, child: child);
    },
  );
}

class CommandsPage extends StatefulWidget {
  const CommandsPage({super.key});

  @override
  State<CommandsPage> createState() => _CommandsPageState();
}

class _CommandsPageState extends State<CommandsPage> {
  @override
  Widget build(BuildContext context) {
    return CommandScaffold(
      title: 'Home',
      subtitle: 'View and create yours commands',
      body: LayoutBuilder(builder: (context, constraints) {
        double itemHeight = 100;
        double itemWidth = 150;
        int crossAxisCount = (constraints.maxWidth / itemWidth).floor();
        final aspect = (constraints.maxWidth / crossAxisCount) / itemHeight;

        return GridView.count(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspect,
          children: [
            CommandTile(
              title: 'Command 1',
              icon: Icons.ac_unit,
              onLongPress: () {
                Routefly.push(routePaths.home.editCommand);
              },
            ),
            CommandTile(
              title: 'Command 2',
              icon: Icons.access_alarm,
              onLongPress: () {
                Routefly.push(routePaths.home.editCommand);
              },
            ),
          ],
        );
      }),
    );
  }
}
