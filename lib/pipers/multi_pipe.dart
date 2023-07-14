part of '../asp.dart';

/// Concat many pipes.
/// ```dart
/// final textState = Atom(
///      '',
///      key: 'textState',
///      pipe: multiPipe([
///         distinct(),
///         interval(),
///     ]),
/// );
/// ```
PipeCallback<T> multiPipe<T>(List<PipeCallback<T>> pipes) {
  return _MultiPipe<T>(pipes).pipe;
}

class _MultiPipe<T> {
  final List<PipeCallback<T>> pipes;

  _MultiPipe(this.pipes);

  void pipe(T value, void Function(T newValue) emit) {
    final piper = pipes.reduce((pipe1, pipe2) {
      return (value, emit) {
        pipe1(value, (value) => pipe2(value, emit));
      };
    });

    piper(value, emit);
  }
}
