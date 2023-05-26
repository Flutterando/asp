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

/// Convert a [Stream] to [RxStream].
extension RxStreamExtension<T> on Stream<T> {
  /// Convert a [Stream] to [RxStream].
  RxStream<T> asAtom() => RxStream.of<T>(this);
}

/// Convert a [Future] to [RxFuture].
extension RxFutureExtension<T> on Future<T> {
  /// Convert a [Future] to [RxFuture].
  RxFuture<T> asAtom() => RxFuture.of<T>(this);
}

/// Convert a [List] to [RxList].
extension RxListExtension<T> on List<T> {
  /// Convert a [List] to [RxList].
  RxList<T> asAtom() => RxList.of<T>(this);
}

/// Convert a [Set] to [RxSet].
extension RxSetExtension<T> on Set<T> {
  /// Convert a [Set] to [RxSet].
  RxSet<T> asAtom() => RxSet.of<T>(this);
}

/// Convert a [Map] to [RxMap].
extension RxMapExtension<K, V> on Map<K, V> {
  /// Convert a [Map] to [RxMap].
  RxMap<K, V> asAtom() => RxMap.of<K, V>(this);
}

/// Propagates the changes of the Atom placed in the
/// body function in this widget.<br>
/// To use this feature, you need to add [RxRoot]
/// at the beginning of your application's Widget tree.
extension ContextSelectionExtension on BuildContext {
  /// Propagates the changes of the Atom placed in the
  /// body function in this widget.<br>
  /// To use this feature, you need to add [RxRoot]
  /// at the beginning of your application's Widget tree.
  T select<T>(T Function() selectFunc, {bool Function()? filter}) {
    return RxRoot._select<T>(this, selectFunc, filter: filter);
  }

  /// Used to assign effect functions that will react to the
  /// reactivity of the declared Atom,
  /// similar to the [rxObserver] function.
  void callback<T>(
    T Function() selectFunc,
    void Function(T? value) effectFunc, {
    bool Function()? filter,
  }) {
    return RxRoot._callback(this, selectFunc, effectFunc, filter: filter);
  }
}
