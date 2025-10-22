import 'base_state.dart';
import '../storage/secure_storage.dart';

/// Settings state model
class SettingsState extends BaseState {
  final SecureStorageProvider _storage;
  
  String _languageStatus = 'English';
  String _mainPinCode = '';
  bool _biometricEnabled = false;

  SettingsState(this._storage);

  String get languageStatus => _languageStatus;
  String get mainPinCode => _mainPinCode;
  bool get biometricEnabled => _biometricEnabled;

  @override
  Future<void> initialize() async {
    _languageStatus = await _storage.getValue('settings_language', 'English') ?? 'English';
    _mainPinCode = await _storage.getValue('settings_pin_code', '') ?? '';
    _biometricEnabled = await _storage.getValue('settings_biometric_enabled', false) ?? false;
    markInitialized();
  }

  Future<void> updateLanguage(String language) async {
    if (language != _languageStatus) {
      _languageStatus = language;
      await _storage.setValue('settings_language', language);
      notifyListeners();
    }
  }

  Future<void> updatePinCode(String pinCode) async {
    if (pinCode != _mainPinCode) {
      _mainPinCode = pinCode;
      await _storage.setValue('settings_pin_code', pinCode);
      notifyListeners();
    }
  }

  Future<void> updateBiometric(bool enabled) async {
    if (enabled != _biometricEnabled) {
      _biometricEnabled = enabled;
      await _storage.setValue('settings_biometric_enabled', enabled);
      notifyListeners();
    }
  }

  @override
  Future<void> clear() async {
    _languageStatus = 'English';
    _mainPinCode = '';
    _biometricEnabled = false;
    notifyListeners();
  }
}