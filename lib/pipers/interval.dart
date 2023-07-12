part of '../asp.dart';

/// Emits a notification from an Atom
/// after a given duration.
/// ```dart
/// final searchTextAction = Atom.action(
///      key: 'searchTextAction',
///      pipe: interval()
/// );
/// ```
PipeCallback<T> interval<T>([Duration duration = const Duration(milliseconds: 500)]) {
  return _Interval<T>(duration: duration).pipe;
}

class _Interval<T> {
  final _queue = Queue<T>();
  final Duration duration;
  var _openIntervals = 0;

  bool get noOpenIntervals => _openIntervals == 0;

  _Interval({required this.duration});

  void pipe(T value, void Function(T newValue) emit) {
    _queue.add(value);

    if (noOpenIntervals) {
      _addNext(emit);
    }
  }

  void _addNext(void Function(T newValue) emit) {
    if (_queue.isNotEmpty) {
      _addDelayed(_queue.removeFirst(), emit).whenComplete(() => _addNext(emit));
    }
  }

  Future<void> _addDelayed(T value, void Function(T newValue) emit) {
    _openIntervals++;

    return Future.delayed(duration, () => value).then(emit).whenComplete(() {
      _openIntervals--;
    });
  }
}
