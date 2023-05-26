part of '../asp.dart';

class RxMap<K, V> extends ChangeNotifier with MapMixin<K, V> {
  late final Map<K, V> _map;

  RxMap([Map<K, V>? map]) {
    if (map != null) {
      _map = map;
    } else {
      _map = {};
    }
  }

  static RxMap<K, V> of<K, V>(Map<K, V> map) => RxMap<K, V>(map);

  @override
  void addAll(Map<K, V> other) {
    other.forEach((K key, V value) {
      _map[key] = value;
    });
    notifyListeners();
  }

  @override
  V? operator [](Object? key) {
    _rxMainContext.reportRead(this);
    return _map[key];
  }

  @override
  void operator []=(K key, V value) {
    _map[key] = value;
    notifyListeners();
  }

  @override
  void clear() {
    _map.clear();
    notifyListeners();
  }

  @override
  Iterable<K> get keys {
    _rxMainContext.reportRead(this);
    return _map.keys;
  }

  @override
  V? remove(Object? key) {
    final result = _map.remove(key);
    if (result != null) {
      notifyListeners();
    }
    return result;
  }
}
