part of '../asp.dart';

/// Listens to changes of all instantiated [Atom]s in the application.
/// ```dart
/// void main() {
///   AtomObserver.changes((status) {
///      print(status); // AtomStatus{event: change, atom: counter | 1}
///   });
///
///   runApp(MyApp());
/// }
/// ```
abstract final class AtomObserver {
  static void Function(AtomStatus status)? _dispatcher;

  /// Registers a dispatcher to listen to changes.
  static void changes(void Function(AtomStatus status)? dispatcher) {
    _dispatcher = dispatcher;
  }
}

/// Atom event types.
enum AtomEvent {
  /// Called when the [Atom]'s value is updated.
  change,

  /// Called when the [Atom] is disposed.
  dispose,

  /// Called when listeners are registered to the [Atom].
  listen,

  /// Called when a listener is removed from the [Atom].
  unlisten,
}

/// Represents the status of an [Atom].
/// [event]: Event of the [Atom].<br>
/// [atom]: The [Atom] that has changed.
class AtomStatus {
  /// Event of the [Atom].
  final AtomEvent event;

  /// The [Atom] that has changed.
  final Atom atom;

  /// The action that caused the change.
  final String? action;

  /// Constructs an [AtomStatus].
  /// [event]: Event of the [Atom].<br>
  /// [atom]: The [Atom] that has changed.
  AtomStatus(this.event, this.atom, this.action);

  @override
  String toString() {
    if (action == null) {
      return '''
AtomStatus{event: ${event.name}, atom: ${atom.key} | ${atom.state}'''
          .trim();
    } else {
      return '''
AtomStatus{event: ${event.name}, atom: ${atom.key} | ${atom.state} | $action
'''
          .trim();
    }
  }
}
