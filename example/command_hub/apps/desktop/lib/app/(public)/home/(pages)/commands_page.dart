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
  void _createCommand() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create command'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('data'),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete command'),
          content: const Text('Are you sure you want to delete this command?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

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
              actions: const ['Edit', 'Delete'],
              onAction: (action) {
                _confirmDelete();
              },
              onLongPress: () {
                Routefly.push(routePaths.home.editCommand);
              },
            ),
            CommandTile(
              title: 'Command 2',
              icon: Icons.access_alarm,
              actions: const ['Edit', 'Delete'],
              onAction: (action) {
                _createCommand();
              },
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
