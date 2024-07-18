import 'package:core_module/core_module.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../routes.g.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var selectedIndex = 0;

  final _pagesTiles = const [
    _PageTile('Home', Icons.home),
    _PageTile('Settings', Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          NavigationRail(
            extended: true,
            minExtendedWidth: 200,
            useIndicator: true,
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Logo(),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('New Command'),
              ),
            ),
            destinations: [
              for (final tile in _pagesTiles)
                NavigationRailDestination(
                  icon: Icon(tile.icon),
                  label: Text(tile.title),
                ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });

              if (value == 0) {
                Routefly.navigate(routePaths.home.commands);
              } else if (value == 1) {
                Routefly.navigate(routePaths.home.config);
              }
            },
          ),
          const Expanded(
            child: RouterOutlet(),
          ),
        ],
      ),
    );
  }
}

class _PageTile {
  final String title;
  final IconData icon;

  const _PageTile(this.title, this.icon);
}
