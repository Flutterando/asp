part of '../asp.dart';

/// Skips data value if they are equal to the previous data value.
/// ```dart
/// final textState = Atom(
///      '',
///      key: 'textState',
///      pipe: distinct()
/// );
/// ```
PipeCallback<T> distinct<T>() {
  return _Distinct<T>().pipe;
}

class _Distinct<T> {
  T? cache;

  void pipe(T value, void Function(T newValue) emit) {
    if (cache != value) {
      cache = value;
      emit(value);
    }
  }
}
