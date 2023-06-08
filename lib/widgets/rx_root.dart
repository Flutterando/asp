part of '../asp.dart';

/// Responsible for propagating Atom values
/// as a dependency of a child Widget.<br>
/// RxRoot should be one of the first Widgets in the Flutter tree.
/// ```dart
/// void main(){
///   runApp(RxRoot(child: AppWidget()));
/// }
/// ```
class RxRoot extends InheritedWidget {
  /// Start reducers.
  final List<Reducer>? reducers;

  /// Responsible for propagating Atom values
  /// as a dependency of a child Widget.<br>
  /// RxRoot should be one of the first Widgets in the Flutter tree.
  /// ```dart
  /// void main(){
  ///   runApp(RxRoot(child: AppWidget()));
  /// }
  /// ```
  const RxRoot({
    super.key,
    required super.child,
    this.reducers,
  });

  static T _select<T>(
    BuildContext context,
    T Function() selectFunc, {
    bool Function()? filter,
  }) {
    _stackTrace = StackTrace.current;

    _rxMainContext.track();
    final value = _resolveTrack(selectFunc());
    final listenables = _rxMainContext.untrack(_stackTrace);

    final registre = _Register<T>(listenables, filter);
    final inherited = context.dependOnInheritedWidgetOfExactType<RxRoot>(
      aspect: registre,
    );
    if (inherited == null) {
      final stackTraceString = StackTrace.current.toString();
      final stackFrame = LineSplitter //
              .split(stackTraceString)
          .skip(1)
          .firstWhere(
            (frame) => !frame.contains('RxRoot'),
            orElse: () => '',
          );

      debugPrintStack(
        stackTrace: StackTrace.fromString(stackFrame),
        label: '\u001b[31m'
            'Please, add the *RxRoot*'
            ' widget as your first widget.',
      );
    }
    inherited?.updateShouldNotify(inherited);

    return value;
  }

  static void _callback<T>(
    BuildContext context,
    T Function() selectFunc,
    void Function(T? value) effectFunc, {
    bool Function()? filter,
  }) {
    final disposer = rxObserver<T>(
      () {
        T? value;
        if (context.mounted) {
          value = selectFunc();
        }
        return value;
      },
      effect: effectFunc,
      filter: filter,
    );

    final registre = _Register<T>(
      const {},
      null,
      disposer: disposer,
      isCallback: true,
    );
    final inherited = context.dependOnInheritedWidgetOfExactType<RxRoot>(
      aspect: registre,
    );
    if (inherited == null) {
      disposer.call();
      final stackTraceString = StackTrace.current.toString();
      final stackFrame = LineSplitter //
              .split(stackTraceString)
          .skip(1)
          .firstWhere(
            (frame) => !frame.contains('RxRoot'),
            orElse: () => '',
          );

      debugPrintStack(
        stackTrace: StackTrace.fromString(stackFrame),
        label: '\u001b[31m'
            'Please, add the *RxRoot*'
            ' widget as your first widget.',
      );
    }
    inherited?.updateShouldNotify(inherited);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  @override
  InheritedElement createElement() => _RxRootElement(this);
}

class _RxRootElement extends InheritedElement {
  _RxRootElement(InheritedWidget widget) : super(widget);

  bool _dirty = false;

  _Register? currentRegister;

  @override
  void updateDependencies(Element dependent, covariant _Register register) {
    final registers = _getRegisters(dependent);

    final listener = Listenable.merge(register.listenables.toList());

    register.mutableCallback.dispose = () {
      listener.removeListener(register.listener);
    };

    register.mutableCallback.callback = () {
      if (dependent.mounted) {
        if (register.filter?.call() ?? true) _handleUpdate(register);
      } else {
        listener.removeListener(register.listener);
      }
    };
    listener.addListener(register.listener);

    registers.add(register);
    setDependencies(dependent, registers);
  }

  @override
  Widget build() {
    if (_dirty) notifyClients(widget);
    return super.build();
  }

  void _handleUpdate(_Register _register) {
    currentRegister = _register;
    _dirty = true;
    markNeedsBuild();
  }

  @override
  void notifyClients(covariant Widget oldWidget) {
    super.notifyClients(oldWidget as InheritedWidget);
    _dirty = false;
    currentRegister = null;
  }

  @override
  void notifyDependent(covariant InheritedWidget oldWidget, Element dependent) {
    final registers = _getRegisters(dependent);
    if (currentRegister?.hasListenable(registers) ?? false) {
      _removeListeners(registers);
      setDependencies(dependent, HashSet<_Register>());

      if (dependent.mounted) dependent.didChangeDependencies();
    }
  }

  void _removeListeners(HashSet<_Register> registers) {
    for (final register in registers) {
      register.dispose();
    }
    registers.clear();
  }

  HashSet<_Register> _getRegisters(Element dependent) {
    return getDependencies(dependent) as HashSet<_Register>? ?? HashSet<_Register>();
  }
}

class _MutableCallback {
  void Function()? callback;
  void Function()? dispose;
}

@immutable
class _Register<T> {
  final Set<Listenable> listenables;
  final mutableCallback = _MutableCallback();
  final bool Function()? filter;
  final RxDisposer? disposer;
  final bool isCallback;

  _Register(this.listenables, this.filter, {this.isCallback = false, this.disposer});

  void listener() {
    mutableCallback.callback?.call();
  }

  void dispose() {
    mutableCallback.dispose?.call();
    disposer?.call();
  }

  bool hasListenable(Set<_Register> registers) {
    final cache = <Listenable, bool>{};

    for (final listenable in registers.expand((e) => e.listenables)) {
      cache[listenable] = true;
    }

    return listenables.any(cache.containsKey);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _Register<T> && setEquals(other.listenables, listenables);
  }

  @override
  int get hashCode {
    return listenables.hashCode;
  }
}
