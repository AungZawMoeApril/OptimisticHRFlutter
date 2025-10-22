import 'package:flutter/foundation.dart';

/// Notifier to track storage migration progress
class MigrationProgress extends ChangeNotifier {
  bool _isRunning = false;
  bool _isComplete = false;
  String _currentStep = '';
  double _progress = 0.0;
  String? _error;

  bool get isRunning => _isRunning;
  bool get isComplete => _isComplete;
  String get currentStep => _currentStep;
  double get progress => _progress;
  String? get error => _error;

  void startMigration() {
    _isRunning = true;
    _isComplete = false;
    _currentStep = 'Starting migration...';
    _progress = 0.0;
    _error = null;
    notifyListeners();
  }

  void updateProgress(String step, double progress) {
    _currentStep = step;
    _progress = progress;
    notifyListeners();
  }

  void completeMigration() {
    _isRunning = false;
    _isComplete = true;
    _currentStep = 'Migration complete';
    _progress = 1.0;
    notifyListeners();
  }

  void setError(String message) {
    _isRunning = false;
    _error = message;
    notifyListeners();
  }

  void reset() {
    _isRunning = false;
    _isComplete = false;
    _currentStep = '';
    _progress = 0.0;
    _error = null;
    notifyListeners();
  }
}