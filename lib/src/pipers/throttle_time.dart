part of '../../asp.dart';

/// Emits a notification from an [Atom], then ignores subsequent
/// source values for duration milliseconds,
/// then repeats this process.
/// ```dart
/// final searchTextAction = Atom.action(
///      key: 'searchTextAction',
///      pipe: throttleTime()
/// );
/// ```
AtomPipe<T> throttleTime<T>([
  Duration duration = const Duration(milliseconds: 500),
]) {
  return _ThrottleTime<T>(duration: duration);
}

class _ThrottleTime<T> extends AtomPipe<T> {
  DateTime? lastEmit;
  final Duration duration;

  _ThrottleTime({required this.duration});

  @override
  void pipe(T value, void Function(T newValue) emit) {
    final now = DateTime.now();

    if (lastEmit != null) {
      final diff = now.difference(lastEmit!);
      final canEmit = diff > duration;
      if (canEmit) {
        emit(value);
      }
    } else {
      emit(value);
    }
    lastEmit = now;
  }

  @override
  void init(T value, void Function(T value) emit) {}
}
