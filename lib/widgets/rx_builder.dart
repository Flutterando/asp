part of '../asp.dart';

/// Listen for [Atom] changes present in the `builder` method.
/// <br>
/// [builder]: All [Atom] used in this function will be automatically
/// signed and this function will be called every
/// time the value of an [Atom] changes.
/// [filter]: Filter reactions and prevent unwanted effects.<br>
///
/// ```dart
/// Widget build(BuildContext context){
///     return RxBuilder(
///         builder: (_) => Text('${counter.value}'),
///     );
/// }
/// ```
class RxBuilder extends StatelessWidget with _RxMixin {
  /// All [Atom] used in this function will be automatically
  /// signed and this function will be called every
  /// time the value of an [Atom] changes.
  final Widget Function(BuildContext context) builder;
  late final bool Function()? _filter;

  /// Listen for [Atom] changes present in the `builder` method.
  /// <br>
  /// [builder]: All [Atom] used in this function will be automatically
  /// signed and this function will be called every
  /// time the value of an [Atom] changes.
  /// [filter]: Filter reactions and prevent unwanted effects.<br>
  ///
  /// ```dart
  /// Widget build(BuildContext context){
  ///     return RxBuilder(
  ///         builder: (_) => Text('${counter.value}'),
  ///     );
  /// }
  /// ```
  RxBuilder({
    Key? key,
    required this.builder,
    bool Function()? filter,
  }) : super(key: key) {
    _filter = filter;
    _stackTrace = StackTrace.current;
  }

  @override
  bool filter() => _filter?.call() ?? true;

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}

mixin _RxMixin on StatelessWidget {
  bool filter() => true;

  @override
  StatelessElement createElement() => _StatelessMixInElement2(this);
}

class _StatelessMixInElement2<W extends _RxMixin> extends StatelessElement with _NotifierElement2 {
  _StatelessMixInElement2(
    W widget,
  ) : super(widget);

  @override
  void update(W newWidget) {
    super.update(newWidget);
  }
}

mixin _NotifierElement2 on ComponentElement {
  Listenable? listenable;

  void invalidate() {
    if ((widget as _RxMixin).filter()) {
      markNeedsBuild();
    }
  }

  @override
  Widget build() {
    late Widget child;
    listenable?.removeListener(invalidate);
    _rxMainContext.track();
    child = super.build();

    final listenables = _rxMainContext.untrack(_stackTrace);
    if (listenables.isNotEmpty) {
      listenable = Listenable.merge(listenables.toList());
    }

    listenable?.addListener(invalidate);

    return child;
  }

  @override
  void unmount() {
    listenable?.removeListener(invalidate);
    super.unmount();
  }
}
