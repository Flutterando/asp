part of '../asp.dart';

class _AtomSelector<T> extends Atom<T> {
  final SelectorFunction<T> _selector;
  late final GetState _get;

  @override
  late T _state;

  _AtomSelector(
    this._selector,
    String key,
    List<AtomPipe<T>> pipes,
  ) : super._(key, pipes, true) {
    _get = GetState._();
    _get._selectorNotifyListeners = () {
      _setState(_selector(_get), key);
    };
    _state = _selector(_get);
  }

  @override
  void dispose() {
    _get._removeListeners();
    super.dispose();
  }
}

class _AsyncAtomSelector<T> extends Atom<T> {
  final FutureOr<T> Function(GetState get) _scope;

  final Queue<FutureOr Function()> _requestQueue = Queue();
  bool _isProcessing = false;
  bool _isInitialized = false;

  late final _get = GetState._();

  @override
  T _state;

  @override
  T get state {
    _initialize();
    return super.state;
  }

  void _initialize() {
    if (!_isInitialized) {
      _isInitialized = true;
      _requestQueue.add(_initializeSelector);
      _processQueue();
    }
  }

  /// Constructs an AsyncValueSelector with an initial value
  /// and a scope function.
  _AsyncAtomSelector(
    this._state,
    this._scope, {
    required String key,
    List<AtomPipe<T>> pipes = const [],
  }) : super._(key, pipes, true);

  /// Processes the request queue, ensuring only one request is
  /// processed at a time.
  Future<void> _processQueue() async {
    if (_isProcessing || _requestQueue.isEmpty) return;

    _isProcessing = true;
    try {
      while (_requestQueue.isNotEmpty) {
        final request = _requestQueue.removeFirst();
        await request();
      }
    } catch (e) {
      rethrow;
    } finally {
      _isProcessing = false;
    }
  }

  /// Initializes the selector by computing the initial value.
  Future<void> _initializeSelector() async {
    _get._selectorNotifyListeners = () {
      _requestQueue.add(() async {
        final newState = await _scope(_get);
        _setState(newState, key);
      });
      _processQueue();
    };
    final newState = await _scope(_get);
    _setState(newState, key);
  }

  @override
  void dispose() {
    _get._removeListeners();
    super.dispose();
  }
}
