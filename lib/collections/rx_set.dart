part of '../asp.dart';

class RxSet<T> extends ChangeNotifier with SetMixin<T> implements RxValueListenable<RxSet<T>> {
  late final Set<T> _set;
  RxSet([Set<T>? set]) {
    if (set != null) {
      _set = set;
    } else {
      _set = {};
    }
  }

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
