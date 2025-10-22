import 'package:flutter/material.dart';

class CheckInProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> performCheckIn() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Implement check-in logic
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}