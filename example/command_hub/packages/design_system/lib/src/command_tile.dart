import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart' hide ColorScheme;

class CommandTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const CommandTile({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.title,
    required this.icon,
  });

  @override
  State<CommandTile> createState() => _CommandTileState();
}

class _CommandTileState extends State<CommandTile> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  late final Animation<double> opacityAnimation;
  late final Animation<double> slideAnimation;
  late final ColorScheme backgroundColor;

  @override
  void initState() {
    super.initState();

    backgroundColor = ColorByName.getSchemeByText(widget.title);

    _controller.addListener(() {
      setState(() {});
    });

    slideAnimation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.decelerate),
      ),
    );
    opacityAnimation = Tween<double>(begin: 0.2, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor.startColor,
              backgroundColor.endColor,
            ],
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onLongPress: widget.onLongPress,
          onTap: _controller.value == 0
              ? () {
                  _controller.forward().then((_) => _controller.reset());
                  widget.onTap?.call();
                }
              : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                FractionalTranslation(
                  translation: Offset(slideAnimation.value, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(opacityAnimation.value),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        widget.icon,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      Text(
                        widget.title,
                        style: Theme.of(context) //
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
