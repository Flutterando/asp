part of '../asp.dart';

/// An RxSet gives you a deeper level of observability on a set of values.
/// It tracks when values are added, removed or modified and notifies the observers.
///
/// Use an RxSet when a change in the set matters.
class RxSet<T> extends ChangeNotifier
    with SetMixin<T>
    implements RxValueListenable<RxSet<T>> {
  late final Set<T> _set;

  /// Creates a [RxSet] that may be initialized with a [set].
  /// {@tool snippet}
  /// ```dart
  /// final set = RxSet({'jacob', 'sara'});
  /// ```
  /// {@end-tool}
  RxSet([Set<T>? set]) {
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
    _rxMainContext.reportRead(this);
    return _set.iterator;
  }

  @override
  int get length {
    _rxMainContext.reportRead(this);
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
  Future<RxSet<T>> next(
    Function onAction, {
    Duration timeLimit = const Duration(seconds: 10),
  }) {
    return rxNext<RxSet<T>>(
      this,
      onAction: onAction,
      timeLimit: timeLimit,
    );
  }

  @override
  RxSet<T> get value {
    _rxMainContext.reportRead(this);
    return this;
  }
}
