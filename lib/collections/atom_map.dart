part of '../asp.dart';

/// An AtomMap gives you a deeper level of observability on a map of values.
/// It tracks when keys are added, removed or modified and notifies the observers.
///
/// Use an AtomMap when a change in the map matters.
class AtomMap<K, V> extends ChangeNotifier
    with MapMixin<K, V>
    implements ValueListenableAtom<AtomMap<K, V>> {
  late final Map<K, V> _map;
  @override
  late final String key;

  /// Creates a [AtomMap] that may be initialized with a [map].
  ///
  /// [map]: The initial list to populate the RxList.
  /// [key]: An optional key for identification.
  ///
  /// {@tool snippet}
  /// Example:
  /// ```dart
  /// final list = AtomMap.of({'name': 'jacob'});
  /// ```
  /// {@end-tool}
  AtomMap._(Map<K, V>? map, {String? key}) {
    this.key = key ?? 'RxList:$hashCode';

    _map = map ?? {};
  }

  /// Creates a [AtomMap] that may be initialized with a [map].
  ///
  /// [map]: The initial list to populate the RxList.
  /// [key]: An optional key for identification.
  ///
  /// {@tool snippet}
  /// Example:
  /// ```dart
  /// final list = AtomMap.of({'name': 'jacob'});
  /// ```
  /// {@end-tool}
  static AtomMap<K, V> of<K, V>(Map<K, V>? map, {String? key}) => AtomMap<K, V>._(map, key: key);

  @override
  void addAll(Map<K, V> other) {
    other.forEach((K key, V value) {
      _map[key] = value;
    });
    notifyListeners();
  }

  @override
  V? operator [](Object? key) {
    _aspContext.reportRead(this);
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
    _aspContext.reportRead(this);
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

  @override
  Future<AtomMap<K, V>> next({
    Duration timeLimit = const Duration(seconds: 10),
  }) {
    return aspNext<AtomMap<K, V>>(
      this,
      timeLimit: timeLimit,
    );
  }

  @override
  AtomMap<K, V> get value {
    _aspContext.reportRead(this);
    return this;
  }

  @override
  Future<List<AtomMap<K, V>>> buffer(
    int count, {
    Duration timeLimit = const Duration(seconds: 10),
  }) {
    // TODO: implement buffer
    throw UnimplementedError();
  }
}
