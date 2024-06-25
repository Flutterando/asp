part of '../../asp.dart';

/// Emits a notification from an Atom only after
/// a specified period of time has passed without
/// another source issuing.
/// ```dart
/// final searchTextAction = Atom.action(
///      key: 'searchTextAction',
///      pipe: debounceTime()
/// );
/// ```
AtomPipe<T> debounceTime<T>([
  Duration duration = const Duration(milliseconds: 500),
]) {
  return _DebounceTime<T>(duration: duration);
}

class _DebounceTime<T> implements AtomPipe<T> {
  Timer? timer;
  final Duration duration;

  _DebounceTime({required this.duration});

  @override
  void init(T value, void Function(T value) emit) {}

  @override
  void pipe(T value, void Function(T newValue) emit) {
    timer?.cancel();

    timer = Timer(duration, () {
      emit(value);
    });
  }
}
