part of '../asp.dart';

/// RxStream status values.
enum StreamStatus {
  /// initial status
  waiting,

  /// on data status
  active,

  /// on finish status
  done,

  /// on error status
  error,
}

/// The RxStream is the reactive wrapper around a StreamSubscription.
/// You can use it to show the UI under various states of a Stream,
/// from waiting to active, done or rejected.
///
/// The status, data and error fields of an RxStream are observable and can be consumed on the UI.
class RxStream<T> extends Stream<T> {
  late final StreamSubscription _sub;

  /// Creates a [RxStream] from a [stream].
  /// {@tool snippet}
  /// ```dart
  /// final rxStream = RxStream.of(stream);
  /// ```
  /// {@end-tool}
  static RxStream<T> of<T>(Stream<T> stream) => RxStream._(stream);

  final Atom<StreamStatus> _status = Atom<StreamStatus>(StreamStatus.waiting);

  late final Atom<T?> _result;

  /// The current value, that may be null
  T? get data => _result.value;

  /// The current status
  StreamStatus get status => _status.value;

  final Atom _error = Atom(null);

  /// The current error
  dynamic get error => _error.value;

  late final Stream<T> _stream;

  RxStream._(Stream<T> stream, {T? initialValue}) {
    _result = Atom<T?>(initialValue);
    _stream = stream;
    _sub = _stream.listen(
      (value) {
        _status.value = StreamStatus.active;
        _result.value = value;
      },
      onError: (error) {
        _status.value = StreamStatus.error;
        _error.value = error;
      },
      onDone: () {
        _status.value = StreamStatus.done;
      },
    );
  }

  @override
  StreamSubscription<T> listen(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  /// Closes the origin stream
  @mustCallSuper
  Future close() async {
    await _sub.cancel();
  }
}
