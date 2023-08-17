part of '../asp.dart';

/// An AtomSet gives you a deeper level of observability on a set of values.
/// It tracks when values are added, removed or modified and notifies the observers.
///
/// Use an AtomSet when a change in the set matters.
class AtomSet<T> extends ChangeNotifier
    with SetMixin<T>
    implements ValueListenableAtom<AtomSet<T>> {
  late final Set<T> _set;
  @override
  late final String key;

  /// Creates a [AtomSet] that may be initialized with a [set].
  ///
  /// [set]: The initial list to populate the AtomSet.
  /// [key]: An optional key for identification.
  ///
  /// {@tool snippet}
  /// Example:
  /// ```dart
  /// final list = AtomSet.of({'name': 'jacob'});
  /// ```
  /// {@end-tool}
  AtomSet._(Set<T>? set, {String? key}) {
    this.key = key ?? 'RxList:$hashCode';

    _set = set ?? {};
  }

  /// Creates a [AtomSet] that may be initialized with a [set].
  ///
  /// [set]: The initial list to populate the RxList.
  /// [key]: An optional key for identification.
  ///
  /// {@tool snippet}
  /// Example:
  /// ```dart
  /// final list = AtomSet.of({'name': 'jacob'});
  /// ```
  /// {@end-tool}
  static AtomSet<T> of<T>(Set<T> set, {String? key}) => AtomSet<T>._(set, key: key);

  @override
  bool add(T value) {
    final result = _set.add(value);
    if (result) {
      notifyListeners();
    }
    return result;
  }

  @override
  bool contains(Object? element) {
    return _set.contains(element);
  }

  @override
  Iterator<T> get iterator {
    _aspContext.reportRead(this);
    return _set.iterator;
  }

  @override
  int get length {
    _aspContext.reportRead(this);
    return _set.length;
  }

  @override
  T? lookup(Object? element) {
    return _set.lookup(element);
  }

  @override
  bool remove(Object? value) {
    final result = _set.remove(value);
    if (result) {
      notifyListeners();
    }
    return result;
  }

  @override
  void clear() {
    _set.clear();
    notifyListeners();
  }

  @override
  Set<T> toSet() {
    return this;
  }

  @override
  Future<AtomSet<T>> next({
    Duration timeLimit = const Duration(seconds: 10),
  }) {
    return aspNext<AtomSet<T>>(
      this,
      timeLimit: timeLimit,
    );
  }

  @override
  AtomSet<T> get value {
    _aspContext.reportRead(this);
    return this;
  }

  @override
  Future<List<AtomSet<T>>> buffer(int count, {Duration timeLimit = const Duration(seconds: 10)}) {
    // TODO: implement buffer
    throw UnimplementedError();
  }
}
