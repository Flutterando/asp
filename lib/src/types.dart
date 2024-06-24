part of '../asp.dart';

/// Used in [Atom.selector] propetie
typedef SelectorFunction<T> = T Function(GetState get);

/// Used in [Atom.asyncSelector] propetie
typedef AsyncSelectorFunction<T> = FutureOr<T> Function(GetState get);

/// Used in pipe propetie
typedef PipeCallback<T> = void Function(T value, void Function(T value) emit);
