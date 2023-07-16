part of '../asp.dart';

/// RxFuture status values.
@Deprecated('Collections, Futures and Streams will no longer be '
    'supported by this package as they violate the ASP standard. '
    'It is better to use a pure [Atom] synchronously '
    'to understand the flow of reactivity.')
enum FutureStatus {
  /// initial status
  pending,

  /// error status
  rejected,

  /// success status
  fulfilled,

  /// unused status
  none,
}

/// The RxFuture is the reactive wrapper around a Future.
/// You can use it to show the UI under various states of a Future,
/// from pending to fulfilled or rejected.
///
/// The status, result and error fields of an RxFuture are observable and can be consumed on the UI.
/// You can add a new Future using `.value`.

@Deprecated('Collections, Futures and Streams will no longer be '
    'supported by this package as they violate the ASP standard. '
    'It is better to use a pure [Atom] synchronously '
    'to understand the flow of reactivity.')
class RxFuture<T> implements Future<T> {
  late Future<T> _future;
  bool _isStartedFuture = false;

  /// Returns the future value
  Future<T> get value => _future;

  /// Updates the future value
  set value(Future<T> value) {
    _future = value;
    _isStartedFuture = false;
    _status.value = FutureStatus.pending;
  }

  final Atom<FutureStatus> _status = Atom<FutureStatus>(FutureStatus.pending);

  final Atom<T?> _result = Atom<T?>(null);

  /// The current status
  FutureStatus get status {
    _startedFuture();
    return _status.value;
  }

  void _startedFuture() {
    if (!_isStartedFuture) {
      _isStartedFuture = true;
      this.then((_) {});
    }
  }

  final Atom _error = Atom(null);

  /// The current error
  dynamic get error {
    _startedFuture();
    return _error.value;
  }

  @Deprecated('Collections, Futures and Streams will no longer be '
      'supported by this package as they violate the ASP standard. '
      'It is better to use a pure [Atom] synchronously '
      'to understand the flow of reactivity.')
  RxFuture._(Future<T> future) : _future = future;

  /// Creates a [RxFuture] from a [future].
  /// {@tool snippet}
  /// ```dart
  /// final rxValue = RxFuture.of(futureValue);
  /// ```
  /// {@end-tool}
  static RxFuture<T> of<T>(Future<T> future) => RxFuture._(future);

  /// The current value, that may be null
  T? get data {
    _startedFuture();
    return status == FutureStatus.fulfilled ? _result.value : null;
  }

  @override
  Stream<T> asStream() {
    return _future.asStream();
  }

  @override
  Future<R> then<R>(
    FutureOr<R> Function(T value) onValue, {
    Function? onError,
  }) {
    return RxFuture<R>._(
      _future.then(
        (T value) {
          _result.value = value;
          _status.value = FutureStatus.fulfilled;
          return onValue(value);
        },
        onError: (error) {
          _error.value = error;
          _status.value = FutureStatus.rejected;
          onError?.call(error == null ? null : [error]);
        },
      ),
    );
  }

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) {
    return RxFuture<T>._(_future.whenComplete(action));
  }

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) {
    return RxFuture<T>._(_future.catchError(onError, test: test));
  }

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) {
    return RxFuture<T>._(_future.timeout(timeLimit, onTimeout: onTimeout));
  }
}
