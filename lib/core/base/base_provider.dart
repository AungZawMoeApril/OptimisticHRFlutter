import 'package:flutter/material.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _disposed = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  @protected
  void setLoading(bool value) {
    _isLoading = value;
    safeNotifyListeners();
  }

  @protected
  void setError(String? message) {
    _errorMessage = message;
    safeNotifyListeners();
  }

  @protected
  void clearError() {
    _errorMessage = null;
    safeNotifyListeners();
  }

  void safeNotifyListeners() {
    if (!_disposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}