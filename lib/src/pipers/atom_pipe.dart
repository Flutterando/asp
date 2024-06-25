part of '../../asp.dart';

/// A pipe that can be used to transform the value of an Atom.
abstract class AtomPipe<T> {
  /// Initializes the pipe with the emit function.
  void init(T value, void Function(T value) emit);

  /// Pipes the value to the emit function.
  void pipe(T value, void Function(T newValue) emit);
}
