part of '../../asp.dart';

/// Listen for [Atom] changes present in the `builder` method.
/// <br>
/// [builder]: All [Atom] used in this function will be automatically
/// signed and this function will be called every
/// time the value of an [Atom] changes.
///
/// ```dart
/// Widget build(BuildContext context){
///     return AtomBuilder(
///         builder: (_, get) => Text('${get(counter)}'),
///     );
/// }
/// ```
class AtomBuilder extends StatefulWidget {
  /// All [Atom] used in this function will be automatically
  /// signed and this function will be called every
  /// time the value of an [Atom] changes.
  final Widget Function(BuildContext context, GetState get) builder;

  /// Listen for [Atom] changes present in the `builder` method. <br>
  /// [builder]: All [Atom] used in this function will be automatically
  /// signed and this function will be called every
  /// time the value of an [Atom] changes.
  ///
  /// ```dart
  /// Widget build(BuildContext context){
  ///     return AtomBuilder(
  ///         builder: (_, get) => Text('${get(counter)}'),
  ///     );
  /// }
  /// ```
  const AtomBuilder({
    super.key,
    required this.builder,
  });

  @override
  State<AtomBuilder> createState() => _AtomBuilderState();
}

class _AtomBuilderState extends State<AtomBuilder> {
  final _get = GetState._();

  @override
  void initState() {
    super.initState();
    _get._selectorNotifyListeners = () {
      setState(() {});
    };
  }

  @override
  void reassemble() {
    _get._removeListeners();
    super.reassemble();
  }

  @override
  void dispose() {
    _get._removeListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.builder(context, _get);
    return child;
  }
}
