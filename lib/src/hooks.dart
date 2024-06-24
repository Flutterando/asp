part of '../asp.dart';

/// A set of hooks provided by the `hook_state` package for ASP.
extension AtomHookExtension on HookState {
  /// Gets the state of the [Atom] and registers the Widget to be
  /// rebuilt when the [Atom] is modified.
  T useAtomState<T>(Atom<T> atom) {
    return useListenable(atom).state;
  }

  /// Listens to the [Atom] and executes the [effect] whenever the [Atom]
  /// is modified.<br>
  /// [body]: A function that registers the [Atom]s to be observed and returns
  /// a derivation.<br>
  /// [effect]: An optional effect function for the derivation
  /// of the [body].<br>
  ///
  /// The [effect] is optional and is not called on the first
  /// execution. The [body] is called
  /// on the first execution and whenever the [Atom] is modified.
  void useAtomEffect<T>(
    T Function(GetState) body, {
    Function(T value)? effect,
  }) {
    final hook = _AtomEffectHook(body, effect);
    use(hook);
  }
}

class _AtomEffectHook<T> extends Hook<T> {
  late RxDisposer disposer;
  final T Function(GetState) body;
  final Function(T value)? effect;

  _AtomEffectHook(this.body, [this.effect]);

  @override
  void init() {
    disposer = atomEffect<T>(body, effect: effect);
  }

  @override
  void dispose() {
    disposer();
  }
}
