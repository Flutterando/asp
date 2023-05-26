part of '../asp.dart';

/// Used to assign effect functions that will react to the
/// reactivity of the declared Atom,
/// similar to the [rxObserver] function.
class RxCallback extends StatefulWidget {
  /// Child Widget
  final Widget child;

  /// All disposers that`s generated from rxObserver function
  final List<RxDisposer> effects;

  /// Used to assign effect functions that will react to the
  /// reactivity of the declared Atom,
  /// similar to the [rxObserver] function.
  const RxCallback({
    super.key,
    required this.child,
    this.effects = const [],
  });

  @override
  State<RxCallback> createState() => _RxCallbackState();
}

class _RxCallbackState extends State<RxCallback> {
  void _disposeEffects(List<RxDisposer> disposers) {
    for (final disposer in disposers) {
      disposer();
    }
  }

  @override
  void didUpdateWidget(covariant RxCallback oldWidget) {
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
