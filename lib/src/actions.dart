part of '../asp.dart';

/// An [Atom] can only be modified within an [AtomAction].<br>
/// This ensures that the state is changed in a safe and predictable manner,
/// allowing state observation.<br><br>
/// There are several variations of [AtomAction] that accept arguments: <br>
/// - [AtomAction]: () <br>
/// - [AtomAction1]: (arg1) <br>
/// - [AtomAction2]: (arg1, arg2) <br>
/// - [AtomAction3]: (arg1, arg2, arg3) <br>
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
sealed class AtomAction {
  final FutureOr Function(SetState set) _scope;
  final String _key;

  /// An [Atom] can only be modified within an [AtomAction].<br>
  /// This ensures that the state is changed in a safe and predictable manner,
  /// allowing state observation.<br><br>
  /// There are several variations of [AtomAction] that accept arguments: <br>
  /// - [AtomAction]: () <br>
  /// - [AtomAction1]: (arg1) <br>
  /// - [AtomAction2]: (arg1, arg2) <br>
  /// - [AtomAction3]: (arg1, arg2, arg3) <br>
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
  AtomAction(this._scope, this._key);

  /// Executes the action
  FutureOr call() => _scope(SetState(_key));
}

class _AtomAction extends AtomAction {
  _AtomAction(
    FutureOr Function(SetState set) _scope,
    String? key,
  ) : super(_scope, key ?? 'atomAction');
}

/// An [Atom] can only be modified within an [AtomAction].<br>
/// This ensures that the state is changed in a safe and predictable manner,
/// allowing state observation.<br><br>
/// There are several variations of [AtomAction] that accept arguments: <br>
/// - [AtomAction]: () <br>
/// - [AtomAction1]: (arg1) <br>
/// - [AtomAction2]: (arg1, arg2) <br>
/// - [AtomAction3]: (arg1, arg2, arg3) <br>
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
sealed class AtomAction1<A> {
  final FutureOr Function(SetState set, A arg1) _scope;
  final String _key;

  /// An [Atom] can only be modified within an [AtomAction].<br>
  /// This ensures that the state is changed in a safe and predictable manner,
  /// allowing state observation.<br><br>
  /// There are several variations of [AtomAction] that accept arguments: <br>
  /// - [AtomAction]: () <br>
  /// - [AtomAction1]: (arg1) <br>
  /// - [AtomAction2]: (arg1, arg2) <br>
  /// - [AtomAction3]: (arg1, arg2, arg3) <br>
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
  AtomAction1(this._scope, this._key);

  /// Executes the action
  FutureOr call(A arg1) => _scope(SetState(_key), arg1);
}

class _AtomAction1<A> extends AtomAction1<A> {
  _AtomAction1(
    FutureOr Function(SetState set, A arg1) _scope,
    String? key,
  ) : super(_scope, key ?? 'atomAction1');
}

/// An [Atom] can only be modified within an [AtomAction].<br>
/// This ensures that the state is changed in a safe and predictable manner,
/// allowing state observation.<br><br>
/// There are several variations of [AtomAction] that accept arguments: <br>
/// - [AtomAction]: () <br>
/// - [AtomAction1]: (arg1) <br>
/// - [AtomAction2]: (arg1, arg2) <br>
/// - [AtomAction3]: (arg1, arg2, arg3) <br>
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
sealed class AtomAction2<A1, A2> {
  final FutureOr Function(SetState set, A1 arg1, A2 arg2) _scope;
  final String _key;

  /// An [Atom] can only be modified within an [AtomAction].<br>
  /// This ensures that the state is changed in a safe and predictable manner,
  /// allowing state observation.<br><br>
  /// There are several variations of [AtomAction] that accept arguments: <br>
  /// - [AtomAction]: () <br>
  /// - [AtomAction1]: (arg1) <br>
  /// - [AtomAction2]: (arg1, arg2) <br>
  /// - [AtomAction3]: (arg1, arg2, arg3) <br>
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
  AtomAction2(this._scope, this._key);

  /// Executes the action
  FutureOr call(A1 arg1, A2 arg2) => _scope(SetState(_key), arg1, arg2);
}

class _AtomAction2<A1, A2> extends AtomAction2<A1, A2> {
  _AtomAction2(
    FutureOr Function(SetState set, A1 arg1, A2 arg2) _scope,
    String? key,
  ) : super(_scope, key ?? 'atomAction2');
}

/// An [Atom] can only be modified within an [AtomAction].<br>
/// This ensures that the state is changed in a safe and predictable manner,
/// allowing state observation.<br><br>
/// There are several variations of [AtomAction] that accept arguments: <br>
/// - [AtomAction]: () <br>
/// - [AtomAction1]: (arg1) <br>
/// - [AtomAction2]: (arg1, arg2) <br>
/// - [AtomAction3]: (arg1, arg2, arg3) <br>
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
sealed class AtomAction3<A1, A2, A3> {
  final FutureOr Function(SetState set, A1 arg1, A2 arg2, A3 arg3) _scope;
  final String _key;

  /// An [Atom] can only be modified within an [AtomAction].<br>
  /// This ensures that the state is changed in a safe and predictable manner,
  /// allowing state observation.<br><br>
  /// There are several variations of [AtomAction] that accept arguments: <br>
  /// - [AtomAction]: () <br>
  /// - [AtomAction1]: (arg1) <br>
  /// - [AtomAction2]: (arg1, arg2) <br>
  /// - [AtomAction3]: (arg1, arg2, arg3) <br>
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
  AtomAction3(this._scope, this._key);

  /// Executes the action
  FutureOr call(A1 arg1, A2 arg2, A3 arg3) => _scope(
        SetState(_key),
        arg1,
        arg2,
        arg3,
      );
}

class _AtomAction3<A1, A2, A3> extends AtomAction3<A1, A2, A3> {
  _AtomAction3(
    FutureOr Function(SetState set, A1 arg1, A2 arg2, A3 arg3) _scope,
    String? key,
  ) : super(_scope, key ?? 'atomAction3');
}
