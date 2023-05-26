part of '../asp.dart';

enum StreamStatus { waiting, active, done, error }

class RxStream<T> extends Stream<T> {
  late final StreamSubscription _sub;

  static RxStream<T> of<T>(Stream<T> stream) => RxStream._(stream);

  final Atom<StreamStatus> _status = Atom<StreamStatus>(StreamStatus.waiting);

  late final Atom<T?> _result;
  T? get data => _result.value;
  StreamStatus get status => _status.value;

  final Atom _error = Atom(null);
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

  @mustCallSuper
  Future close() async {
    await _sub.cancel();
  }
}
