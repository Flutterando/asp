part of '../asp.dart';

/// An RxSet gives you a deeper level of observability on a set of values.
/// It tracks when values are added, removed or modified and notifies the observers.
///
/// Use an RxSet when a change in the set matters.
@Deprecated('Collections, Futures and Streams will no longer be '
    'supported by this package as they violate the ASP standard. '
    'It is better to use a pure [Atom] synchronously '
    'to understand the flow of reactivity.')
class RxSet<T> extends ChangeNotifier with SetMixin<T> implements ValueListenableAtom<RxSet<T>> {
  late final Set<T> _set;
  @override
  late final String key;

  /// Creates a [RxSet] that may be initialized with a [set].
  /// {@tool snippet}
  /// ```dart
  /// final set = RxSet({'jacob', 'sara'});
  /// ```
  /// {@end-tool}
  @Deprecated('Collections, Futures and Streams will no longer be '
      'supported by this package as they violate the ASP standard. '
      'It is better to use a pure [Atom] synchronously '
      'to understand the flow of reactivity.')
  RxSet([Set<T>? set, String? key]) {
    this.key = key ?? 'RxList:$hashCode';

    if (set != null) {
      _set = set;
    } else {
      _set = {};
    }
  }

  /// Creates a [RxSet] from a [set].
  /// {@tool snippet}
  /// ```dart
  /// final set = RxSet({'jacob', 'sara'});
  /// ```
  /// {@end-tool}
  static RxSet<T> of<T>(Set<T> set) => RxSet<T>(set);

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
  Future<RxSet<T>> next({
    Duration timeLimit = const Duration(seconds: 10),
  }) {
    return aspNext<RxSet<T>>(
      this,
      timeLimit: timeLimit,
    );
  }

  @override
  RxSet<T> get value {
    _aspContext.reportRead(this);
    return this;
  }

  @override
  Future<List<RxSet<T>>> buffer(int count, {Duration timeLimit = const Duration(seconds: 10)}) {
    // TODO: implement buffer
    throw UnimplementedError();
  }
}
