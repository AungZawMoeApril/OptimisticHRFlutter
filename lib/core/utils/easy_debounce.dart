/// Simple debounce implementation to replace easy_debounce package
class EasyDebounce {
  static final Map<String, _Debouncer> _debouncers = {};

  static void debounce(
    String tag,
    Duration duration,
    void Function() onExecute,
  ) {
    if (_debouncers.containsKey(tag)) {
      _debouncers[tag]!.cancel();
    }

    _debouncers[tag] = _Debouncer(duration, onExecute);
  }

  static void cancel(String tag) {
    if (_debouncers.containsKey(tag)) {
      _debouncers[tag]!.cancel();
      _debouncers.remove(tag);
    }
  }

  static void cancelAll() {
    for (var debouncer in _debouncers.values) {
      debouncer.cancel();
    }
    _debouncers.clear();
  }
}

class _Debouncer {
  final Duration duration;
  final void Function() onExecute;
  Future<void>? _future;

  _Debouncer(this.duration, this.onExecute) {
    _future = Future.delayed(duration, onExecute);
  }

  void cancel() {
    _future = null;
  }
}
