part of '../asp.dart';

/// Listen for [Atom] changes present in the body.
/// <br>
/// [body]: All Atom used in this function will be automatically
/// signed and this function will be called every
/// time the value of an Atom changes.
/// [filter]: Filter reactions and prevent unwanted effects.<br>
/// [effect]: The `body` function generates a value that can be
/// retrieved from the effect function.
///
/// ```dart
/// final counter = Atom<int>(0);
///
/// RxDisposer disposer = rxObserver((){
///    print(counter.value);
/// });
///
/// disposer();
/// ```
RxDisposer rxObserver<T>(
  T? Function() body, {
  bool Function()? filter,
  void Function(T? value)? effect,
}) {
  _stackTrace = StackTrace.current;

  _rxMainContext.track();
  _resolveTrack(body());
  final listenables = _rxMainContext.untrack(_stackTrace);

  void dispatch() {
    if (filter?.call() ?? true) {
      final value = body();
      effect?.call(value);
    }
  }

  if (listenables.isNotEmpty) {
    final listenable = Listenable.merge(listenables.toList());
    listenable.addListener(dispatch);

    return RxDisposer(() {
      listenable.removeListener(dispatch);
    });
  }
  return RxDisposer(() {});
}

T _resolveTrack<T>(T body) {
  if (body is RxValueListenable) {
    body.value;
    return body;
  } else if (body is Iterable) {
    for (final element in body) {
      _resolveTrack(element);
    }
    return body;
  } else {
    return body;
  }
}

/// Wait the next change of a [Atom].
/// The [timeLimit] is 10 seconds by default.
Future<T> rxNext<T>(
  RxValueListenable<T> rx, {
  Duration timeLimit = const Duration(seconds: 10),
}) async {
  final completer = Completer<T>();
  final disposable = rxObserver<T>(
    () => rx.value,
    effect: completer.complete,
  );
  final result = await completer.future.timeout(
    timeLimit,
    onTimeout: () => rx.value,
  );
  disposable();
  return result;
}

/// Remove all listeners of rxObserver;
class RxDisposer {
  final void Function() _disposer;

  /// Remove all listeners of rxObserver;
  RxDisposer(this._disposer);

  /// Remove all listeners of rxObserver;
  void call() => _disposer();
}
