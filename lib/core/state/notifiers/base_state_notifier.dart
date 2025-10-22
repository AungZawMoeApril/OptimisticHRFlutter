import 'package:flutter/foundation.dart';
import '../../storage/storage_manager.dart';

/// Base class for all state notifiers
abstract class BaseStateNotifier extends ChangeNotifier {
  final String boxName;
  bool _initialized = false;

  BaseStateNotifier(this.boxName);

  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;
    await loadState();
    _initialized = true;
  }

  /// Get value from storage with type safety
  Future<T?> getValue<T>(String key, [T? defaultValue]) async {
    return StorageManager.getValue<T>(boxName, key, defaultValue);
  }

  /// Save value to storage with type safety
  Future<void> setValue<T>(String key, T? value) async {
    await StorageManager.setValue<T>(boxName, key, value);
  }

  /// Load state from storage
  Future<void> loadState();

  /// Save state to storage
  Future<void> saveState();

  /// Clear state and storage
  Future<void> clear() async {
    await StorageManager.clearBox(boxName);
    _initialized = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _initialized = false;
    super.dispose();
  }
}