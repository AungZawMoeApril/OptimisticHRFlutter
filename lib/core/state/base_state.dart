import 'package:flutter/foundation.dart';

/// Base class for all state models
abstract class BaseState with ChangeNotifier {
  bool _initialized = false;
  bool get isInitialized => _initialized;

  void markInitialized() {
    _initialized = true;
    notifyListeners();
  }

  Future<void> initialize();
  Future<void> clear();
}