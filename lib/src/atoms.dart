part of '../asp.dart';

/// An [Atom] represents a microstate for the application.<br>
/// Anyone can read an [Atom], but only an [atomAction] can modify it.<br>
/// Being a [Listenable], it can be observed traditionally using
/// [addListener] and [removeListener].
/// However, using [atomEffect] allows you to observe multiple [Atom]s
/// at once.<br>
/// ```dart
/// final counterState = atom(0);
///
/// final disposable = atomEffect<int>(
///   (get) => get(counterState),
///   effect: (state) => print(state),
/// );
///
/// disposable();
/// ```
sealed class Atom<T> extends ChangeNotifier {
  /// Waits for the next change of an [Atom].
  /// The [timeLimit] is 10 seconds by default.
  Future<T> next({Duration timeLimit = const Duration(seconds: 10)}) async {
    final completer = Completer<T>();
    final disposable = atomEffect<T>(
      (get) => get(this),
      effect: completer.complete,
    );
    final result = await completer.future.timeout(
      timeLimit,
      onTimeout: () => state,
    );
    disposable();
    return result;
  }

  /// Buffers changes of an [Atom].
  /// The [count] is the number of buffered items.
  /// The [timeLimit] is 10 seconds by default.
  Future<List<T>> buffer(
    int count, {
    Duration timeLimit = const Duration(seconds: 10),
  }) async {
    final completer = Completer<List<T>>();
    final states = <T>[];

    final disposable = atomEffect<T>(
      (get) => get(this),
      effect: (_) {
        states.add(state);
        if (count == states.length) {
          completer.complete(states);
        }
      },
    );

    final result = await completer.future.timeout(
      timeLimit,
      onTimeout: () => states.isEmpty ? [state] : states,
    );

    disposable();
    return result;
  }

  /// [Atom] Identifier
  final String key;

  /// Transforms the set value.
  final PipeCallback<T>? _pipe;

  /// The current value stored in this notifier.
  T get state => _state;

  T get _state;
  set _state(T newState);

  final bool _distinct;

  factory Atom.selector(
    SelectorFunction<T> scope, {
    String? key,
    PipeCallback<T>? pipe,
  }) {
    final fixKey = key ?? 'Selector($T)';
    return _AtomSelector<T>(scope, fixKey, pipe);
  }

  factory Atom.asyncSelector(
    T state,
    AsyncSelectorFunction<T> scope, {
    String? key,
    PipeCallback<T>? pipe,
  }) {
    final fixKey = key ?? 'AsyncSelector($T)';
    return _AsyncAtomSelector<T>(state, scope, key: fixKey, pipe: pipe);
  }

  Atom._(this.key, this._pipe, this._distinct);

  void _setState(T newValue, String keyAction) {
    if (_pipe == null) {
      _changeValue(newValue, keyAction);
    } else {
      _pipe!.call(newValue, (v) => _changeValue(v, keyAction));
    }
  }

  void _changeValue(T newValue, String keyAction) {
    if (_distinct && _state == newValue) return;
    _state = newValue;
    notifyListeners();
    AtomObserver._dispatcher?.call(
      AtomStatus(
        AtomEvent.change,
        this,
        keyAction,
      ),
    );
  }

  @override
  void addListener(VoidCallback listener) {
    AtomObserver._dispatcher?.call(AtomStatus(AtomEvent.listen, this, null));
    super.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    AtomObserver._dispatcher?.call(AtomStatus(AtomEvent.unlisten, this, null));
    super.removeListener(listener);
  }

  @override
  void dispose() {
    AtomObserver._dispatcher?.call(AtomStatus(AtomEvent.dispose, this, null));
    super.dispose();
  }
}

class _Atom<T> extends Atom<T> {
  @override
  T _state;

  _Atom(
    this._state, {
    required String key,
    PipeCallback<T>? pipe,
    bool distinct = true,
  }) : super._(
          key,
          pipe,
          distinct,
        );
}

/// Registers a notifier and returns its value.
final class GetState {
  late final void Function() _selectorNotifyListeners;
  final Set<Atom> _listenables = {};
  var _tracking = true;

  GetState._();

  /// Registers a notifier and returns its value.
  R call<R>(Atom<R> atom) {
    if (_tracking) {
      atom.addListener(_selectorNotifyListeners);
      _listenables.add(atom);
    }
    return atom.state;
  }

  void _untrack() => _tracking = false;

  /// Disposes of all registered listeners.
  void _removeListeners() {
    for (final listenable in _listenables) {
      listenable.removeListener(_selectorNotifyListeners);
    }
    _tracking = true;
  }
}

/// Encapsulates the callback to change the state of an [Atom].
class SetState {
  final String _keyAction;

  /// Encapsulates the callback to change the state of an [Atom].
  SetState(this._keyAction);

  /// Encapsulates the callback to change the state of an [Atom].
  void call<T>(Atom<T> atom, T newState) {
    atom._setState(newState, _keyAction);
  }
}
