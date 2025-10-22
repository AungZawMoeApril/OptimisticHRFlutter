import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../../domain/repositories/auth_repository.dart';

class PinCodeProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  final LocalAuthentication _localAuth;

  PinCodeProvider(this._authRepository, this._localAuth);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<String> _pinCode = [];
  List<String> get pinCode => _pinCode;

  bool _isResetting = false;
  bool get isResetting => _isResetting;

  bool _useBiometrics = false;
  bool get useBiometrics => _useBiometrics;

  void addDigit(String digit) {
    if (_pinCode.length < 6) {
      _pinCode.add(digit);
      notifyListeners();
    }
    
    if (_pinCode.length == 6) {
      _verifyPinCode();
    }
  }

  void removeDigit() {
    if (_pinCode.isNotEmpty) {
      _pinCode.removeLast();
      notifyListeners();
    }
  }

  void clearPinCode() {
    _pinCode.clear();
    notifyListeners();
  }

  Future<void> _verifyPinCode() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authRepository.verifyPinCode(_pinCode.join());
      clearPinCode();
      // Navigate to home on success
    } catch (e) {
      _error = e.toString();
      clearPinCode();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> startBiometricAuth() async {
    try {
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        throw Exception('Biometric authentication not available');
      }

      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to proceed',
      );

      if (didAuthenticate) {
        // Navigate to home on success
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> resetPinCode() async {
    _isResetting = true;
    _error = null;
    notifyListeners();

    try {
      await _authRepository.resetPinCode();
      clearPinCode();
      // Navigate to pin code setup
    } catch (e) {
      _error = e.toString();
    } finally {
      _isResetting = false;
      notifyListeners();
    }
  }

  Future<void> setupPinCode() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (_pinCode.length != 6) {
        throw Exception('Invalid PIN code');
      }

      await _authRepository.createPinCode(_pinCode.join());
      clearPinCode();
      // Navigate to home
    } catch (e) {
      _error = e.toString();
      clearPinCode();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}