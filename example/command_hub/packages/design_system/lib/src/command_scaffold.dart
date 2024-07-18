import 'package:flutter/material.dart';

class CommandScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? body;
  final Widget? floatingActionButton;

  const CommandScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.onSecondaryFixed,
      floatingActionButton: floatingActionButton,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (Navigator.canPop(context))
                  const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: BackButton(),
                  ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleLarge),
                    Text(subtitle, style: theme.textTheme.titleSmall),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 28),
            if (body != null) Expanded(child: body!),
          ],
        ),
      ),
    );
  }
}
