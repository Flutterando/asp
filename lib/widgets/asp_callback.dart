part of '../asp.dart';

/// Used to assign effect functions that will react to the
/// reactivity of the declared Atom,
/// similar to the [aspObserver] function.
class ASPCallback extends StatefulWidget {
  /// Child Widget
  final Widget child;

  /// All disposers that`s generated from rxObserver function
  final List<ASPDisposer> effects;

  /// Used to assign effect functions that will react to the
  /// reactivity of the declared Atom,
  /// similar to the [aspObserver] function.
  const ASPCallback({
    super.key,
    required this.child,
    this.effects = const [],
  });

  @override
  State<ASPCallback> createState() => _ASPCallbackState();
}

class _ASPCallbackState extends State<ASPCallback> {
  void _disposeEffects(List<ASPDisposer> disposers) {
    for (final disposer in disposers) {
      disposer();
    }
  }

  @override
  void didUpdateWidget(covariant ASPCallback oldWidget) {
    _disposeEffects(oldWidget.effects);

    if (widget.child != oldWidget.child) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _disposeEffects(widget.effects);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
