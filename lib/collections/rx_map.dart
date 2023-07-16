part of '../asp.dart';

/// An RxMap gives you a deeper level of observability on a map of values.
/// It tracks when keys are added, removed or modified and notifies the observers.
///
/// Use an RxMap when a change in the map matters.

@Deprecated('Collections, Futures and Streams will no longer be '
    'supported by this package as they violate the ASP standard. '
    'It is better to use a pure [Atom] synchronously '
    'to understand the flow of reactivity.')
class RxMap<K, V> extends ChangeNotifier with MapMixin<K, V> implements RxValueListenable<RxMap<K, V>> {
  late final Map<K, V> _map;
  @override
  late final String key;

  /// Creates a [RxMap] that may be initialized with a [map].
  /// {@tool snippet}
  /// ```dart
  /// final map = RxMap({'name': 'jacob'});
  /// ```
  /// {@end-tool}
  ///
  @Deprecated('Collections, Futures and Streams will no longer be '
      'supported by this package as they violate the ASP standard. '
      'It is better to use a pure [Atom] synchronously '
      'to understand the flow of reactivity.')
  RxMap([Map<K, V>? map, String? key]) {
    this.key = key ?? 'RxList:$hashCode';

    if (map != null) {
      _map = map;
    } else {
      _map = {};
    }
  }

  /// Creates a [RxMap] from a [map].
  /// {@tool snippet}
  /// ```dart
  /// final map = RxMap.of({'name': 'jacob'});
  /// ```
  /// {@end-tool}
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

  @override
  Future<RxMap<K, V>> next(
    Function onAction, {
    Duration timeLimit = const Duration(seconds: 10),
  }) {
    return rxNext<RxMap<K, V>>(
      this,
      onAction: onAction,
      timeLimit: timeLimit,
    );
  }

  @override
  RxMap<K, V> get value {
    _rxMainContext.reportRead(this);
    return this;
  }
}
