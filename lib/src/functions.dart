part of '../asp.dart';

/// An [Atom] represents a microstate for the application.<br>
/// Anyone can read an [Atom], but only an [atomAction] can modify it.<br>
/// Being a [Listenable], it can be observed traditionally
/// using [Atom.addListener] and [Atom.removeListener].
/// However, using [atomEffect] allows you to observe multiple
/// [Atom]s at once.<br>
///
/// [state]: The current value of the [Atom].<br>
/// [key]: The identifier of the [Atom].<br>
/// [pipe]: A function that allows you to manipulate the value of the
/// [Atom].<br>
///
/// Example:
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
Atom<T> atom<T>(
  T state, {
  String? key,
  List<AtomPipe<T>> pipes = const [],
  bool distinct = true,
}) {
  return _Atom<T>(
    state,
    key: key ?? 'Atom($T)',
    pipes: pipes,
    distinct: distinct,
  );
}

/// Creates a selector [Atom] that derives its state from other Atoms.<br>
/// [scope]: A function that returns the derived state.<br>
/// [key]: The identifier of the [Atom].<br>
/// [pipe]: A function that allows you to manipulate the value of
/// the [Atom].<br>
///
/// Example:
/// ```dart
/// final counterState = atom(0);
/// final doubleCounterState = selector((get) => get(counterState) * 2);
/// ```
Atom<T> selector<T>(
  SelectorFunction<T> scope, {
  String? key,
  List<AtomPipe<T>> pipes = const [],
}) {
  return Atom<T>.selector(scope, key: key, pipes: pipes);
}

/// Creates an asynchronous selector [Atom] that derives its state from
/// other Atoms.<br>
/// [state]: The initial state of the [Atom].<br>
/// [scope]: A function that returns the derived state asynchronously.<br>
/// [key]: The identifier of the [Atom].<br>
/// [pipe]: A function that allows you to manipulate the value of the
/// [Atom].<br>
///
/// Example:
/// ```dart
/// final counterState = atom(0);
/// final asyncDoubleCounterState = asyncSelector(0, (get) async {
///   await Future.delayed(Duration(seconds: 1));
///   return get(counterState) * 2;
/// });
/// ```
Atom<T> asyncSelector<T>(
  T state,
  AsyncSelectorFunction<T> scope, {
  String? key,
  List<AtomPipe<T>> pipes = const [],
}) {
  return Atom<T>.asyncSelector(state, scope, key: key, pipes: pipes);
}

/// An [Atom] can only be modified within an [AtomAction].<br>
/// This ensures that the state is changed in a safe and predictable manner,
/// allowing state observation.<br><br>
/// There are several variations of [AtomAction] that accept arguments: <br>
/// - [atomAction]: () <br>
/// - [atomAction1]: (arg1) <br>
/// - [atomAction2]: (arg1, arg2) <br>
/// - [atomAction3]: (arg1, arg2, arg3) <br>
///
/// Example:
///
/// ```dart
/// final counterState = atom(0);
///
/// final counterAction = atomAction((set) {
///   set(counterState, 1);
/// });
///
/// counterAction();
/// ```
AtomAction atomAction(
  FutureOr Function(SetState set) scope, {
  String? key,
}) {
  return _AtomAction(scope, key ?? 'atomAction');
}

/// An [Atom] can only be modified within an [AtomAction].<br>
/// This ensures that the state is changed in a safe and predictable manner,
/// allowing state observation.<br><br>
/// There are several variations of [AtomAction] that accept arguments: <br>
/// - [atomAction]: () <br>
/// - [atomAction1]: (arg1) <br>
/// - [atomAction2]: (arg1, arg2) <br>
/// - [atomAction3]: (arg1, arg2, arg3) <br>
///
/// Example:
///
/// ```dart
/// final counterState = atom(0);
///
/// final counterAction = atomAction((set) {
///   set(counterState, 1);
/// });
///
/// counterAction();
/// ```
AtomAction1<A> atomAction1<A>(
  FutureOr Function(SetState set, A action) scope, {
  String? key,
}) {
  return _AtomAction1<A>(scope, key ?? 'atomAction1');
}

/// An [Atom] can only be modified within an [AtomAction].<br>
/// This ensures that the state is changed in a safe and predictable manner,
/// allowing state observation.<br><br>
/// There are several variations of [AtomAction] that accept arguments: <br>
/// - [atomAction]: () <br>
/// - [atomAction1]: (arg1) <br>
/// - [atomAction2]: (arg1, arg2) <br>
/// - [atomAction3]: (arg1, arg2, arg3) <br>
///
/// Example:
///
/// ```dart
/// final counterState = atom(0);
///
/// final counterAction = atomAction((set) {
///   set(counterState, 1);
/// });
///
/// counterAction();
/// ```
AtomAction2<A1, A2> atomAction2<A1, A2>(
  FutureOr Function(SetState set, A1 arg1, A2 arg2) scope, {
  String? key,
}) {
  return _AtomAction2<A1, A2>(scope, key ?? 'atomAction2');
}

/// An [Atom] can only be modified within an [AtomAction].<br>
/// This ensures that the state is changed in a safe and predictable manner,
/// allowing state observation.<br><br>
/// There are several variations of [AtomAction] that accept arguments: <br>
/// - [atomAction]: () <br>
/// - [atomAction1]: (arg1) <br>
/// - [atomAction2]: (arg1, arg2) <br>
/// - [atomAction3]: (arg1, arg2, arg3) <br>
///
/// Example:
///
/// ```dart
/// final counterState = atom(0);
///
/// final counterAction = atomAction((set) {
///   set(counterState, 1);
/// });
///
/// counterAction();
/// ```
AtomAction3<A1, A2, A3> atomAction3<A1, A2, A3>(
  FutureOr Function(
    SetState set,
    A1 arg1,
    A2 arg2,
    A3 arg3,
  ) scope, {
  String? key,
}) {
  return _AtomAction3<A1, A2, A3>(scope, key ?? 'atomAction3');
}

/// Listen for [Atom] changes present in the body.<br>
/// [body]: All Atoms used in this function will be automatically
/// subscribed and this function will be called every
/// time the value of an Atom changes.<br>
/// [filter]: Filter reactions and prevent unwanted effects.<br>
/// [effect]: The `body` function generates a value that can be
/// retrieved from the effect function.
///
/// Example:
/// ```dart
/// final counter = atom<int>(0);
///
/// RxDisposer disposer = atomEffect((get) {
///    print(get(counter));
/// });
///
/// disposer();
/// ```
RxDisposer atomEffect<T>(
  T Function(GetState get) body, {
  void Function(T value)? effect,
}) {
  final get = GetState._();
  get._selectorNotifyListeners = () {
    final value = body(get);
    effect?.call(value);
  };

  body(get);

  return RxDisposer(get._removeListeners);
}

/// Remove all listeners of atomEffect.
class RxDisposer {
  final void Function() _disposer;

  /// Remove all listeners of atomEffect.
  RxDisposer(this._disposer);

  /// Remove all listeners of atomEffect.
  void call() => _disposer();
}
