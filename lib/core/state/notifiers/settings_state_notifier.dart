import 'base_state_notifier.dart';

import '../../storage/storage_manager.dart' show StorageManager;

class SettingsStateNotifier extends BaseStateNotifier {
  String _language = 'en';
  bool _notificationsEnabled = true;
  String _theme = 'light';
  bool _biometricEnabled = false;

  SettingsStateNotifier() : super(StorageManager.settingsBox);

  String get language => _language;
  bool get notificationsEnabled => _notificationsEnabled;
  String get theme => _theme;
  bool get biometricEnabled => _biometricEnabled;

  @override
  Future<void> loadState() async {
    _language = await getValue<String>('settings_language', 'en') ?? 'en';
    _notificationsEnabled = await getValue<bool>('settings_notifications', true) ?? true;
    _theme = await getValue<String>('settings_theme', 'light') ?? 'light';
    _biometricEnabled = await getValue<bool>('settings_biometric', false) ?? false;
  }

  @override
  Future<void> saveState() async {
    await setValue<String>('settings_language', _language);
    await setValue<bool>('settings_notifications', _notificationsEnabled);
    await setValue<String>('settings_theme', _theme);
    await setValue('settings_biometric', _biometricEnabled);
  }

  Future<void> updateLanguage(String language) async {
    if (language != _language) {
      _language = language;
      await saveState();
      notifyListeners();
    }
  }

  Future<void> updateNotifications(bool enabled) async {
    if (enabled != _notificationsEnabled) {
      _notificationsEnabled = enabled;
      await saveState();
      notifyListeners();
    }
  }

  Future<void> updateTheme(String theme) async {
    if (theme != _theme) {
      _theme = theme;
      await saveState();
      notifyListeners();
    }
  }

  Future<void> updateBiometric(bool enabled) async {
    if (enabled != _biometricEnabled) {
      _biometricEnabled = enabled;
      await saveState();
      notifyListeners();
    }
  }

  @override
  Future<void> clear() async {
    _language = 'en';
    _notificationsEnabled = true;
    _theme = 'light';
    _biometricEnabled = false;
    await saveState();
    await super.clear();
  }
}