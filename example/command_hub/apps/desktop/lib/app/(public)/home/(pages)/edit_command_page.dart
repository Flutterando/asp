import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class EditCommandPage extends StatefulWidget {
  const EditCommandPage({super.key});

  @override
  State<EditCommandPage> createState() => _EditCommandPageState();
}

class _EditCommandPageState extends State<EditCommandPage> {
  @override
  Widget build(BuildContext context) {
    return const CommandScaffold(
      title: 'Edit Command',
      subtitle: 'Edit your command',
      body: Center(
        child: Text('Edit Command Page'),
      ),
    );
  }
}
