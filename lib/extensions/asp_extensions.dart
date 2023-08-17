part of '../asp.dart';

/// Merge [Listenable] objects.
/// ```dart
/// final newListenable = listenable1 + listenable2;
/// ```
extension ListenableMergeExtension on Listenable {
  /// Merge [Listenable] objects.
  /// ```dart
  /// final newListenable = listenable1 + listenable2;
  /// ```

  Listenable operator +(Listenable listenable) => Listenable.merge([
        this,
        listenable,
      ]);
}

/// Convert a [ValueListenable] to [Atom].
extension ValueNotifierParse<T> on ValueListenable<T> {
  /// Convert a [ValueListenable] to [Atom].
  Atom<T> asAtom() => Atom<T>(value);
}

/// Convert a [Stream] to [AtomStream].
extension StreamExtension<T> on Stream<T> {
  /// Convert a [Stream] to [AtomStream].
  AtomStream<T> asAtom([Stream<T>? stream]) => AtomStream.of<T>(stream ?? this);
}

/// Convert a [Future] to [AtomFuture].
extension FutureExtension<T> on Future<T> {
  /// Convert a [Future] to [AtomFuture].
  AtomFuture<T> asAtom([Future<T>? future]) => AtomFuture.of<T>(future ?? this);
}

/// Convert a [List] to [AtomList].
extension ListExtension<T> on List<T> {
  /// Convert a [List] to [AtomList].
  AtomList<T> asAtom([List<T>? list]) => AtomList.of<T>(list ?? this);
}

/// Convert a [Set] to [AtomSet].
extension SetExtension<T> on Set<T> {
  /// Convert a [Set] to [AtomSet].
  AtomSet<T> asAtom([Set<T>? set]) => AtomSet.of<T>(set ?? this);
}

/// Convert a [Map] to [AtomMap].
extension MapExtension<K, V> on Map<K, V> {
  /// Convert a [Map] to [AtomMap].
  AtomMap<K, V> asAtom([Map<K, V>? map]) => AtomMap.of<K, V>(map ?? this);
}

/// Propagates the changes of the Atom placed in the
/// body function in this widget.<br>
/// To use this feature, you need to add [ASPRoot]
/// at the beginning of your application's Widget tree.
extension ContextSelectionExtension on BuildContext {
  /// Propagates the changes of the Atom placed in the
  /// body function in this widget.<br>
  /// To use this feature, you need to add [ASPRoot]
  /// at the beginning of your application's Widget tree.
  T select<T>(T Function() selectFunc, {bool Function()? filter}) {
    return ASPRoot._select<T>(this, selectFunc, filter: filter);
  }

  /// Used to assign effect functions that will react to the
  /// reactivity of the declared Atom,
  /// similar to the [aspObserver] function.
  void callback<T>(
    T Function() selectFunc,
    void Function(T? value) effectFunc, {
    bool Function()? filter,
  }) {
    return ASPRoot._callback(this, selectFunc, effectFunc, filter: filter);
  }
}
