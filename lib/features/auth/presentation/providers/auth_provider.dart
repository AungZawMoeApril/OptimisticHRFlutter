import 'package:flutter/foundation.dart';
import 'package:h_r_optimistic_mobile/features/auth/domain/entities/auth.dart';
import 'package:h_r_optimistic_mobile/features/auth/domain/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  AuthStatus _status = AuthStatus();
  AuthStatus get status => _status;

  AuthCredentials? _credentials;
  AuthCredentials? get credentials => _credentials;

  AuthProvider(this._repository) {
    checkAuthStatus();
  }

  Future<void> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _repository.login(username, password);
      result.fold(
        (error) {
          _error = error;
          _status = AuthStatus(error: error);
        },
        (credentials) {
          _credentials = credentials;
          _status = AuthStatus(isAuthenticated: true);
        },
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyPinCode(String pinCode) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _repository.verifyPinCode(pinCode);
      result.fold(
        (error) {
          _error = error;
          _status = _status.copyWith(error: error);
        },
        (isVerified) {
          _status = _status.copyWith(isPinCodeVerified: isVerified);
        },
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createPinCode(String pinCode) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _repository.createPinCode(pinCode);
      result.fold(
        (error) {
          _error = error;
          _status = _status.copyWith(error: error);
        },
        (success) {
          _status = _status.copyWith(isPinCodeVerified: true);
        },
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _repository.logout();
      result.fold(
        (error) {
          _error = error;
          _status = _status.copyWith(error: error);
        },
        (_) {
          _status = AuthStatus();
          _credentials = null;
        },
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkAuthStatus() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _repository.checkAuthStatus();
      result.fold(
        (error) {
          _error = error;
          _status = AuthStatus(error: error);
        },
        (status) {
          _status = status;
        },
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
