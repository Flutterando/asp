part of '../asp.dart';

class RxSet<T> extends ChangeNotifier with SetMixin<T> {
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
  Set<T> toSet() {
    return this;
  }
}
