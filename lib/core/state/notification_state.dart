import 'base_state.dart';
import '../storage/secure_storage.dart';

/// Notification state model
class NotificationState extends BaseState {
  final SecureStorageProvider _storage;
  
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  Map<String, bool> _notificationTypes = {
    'announcements': true,
    'leaveRequests': true,
    'timeTracking': true,
    'overtime': true,
  };

  NotificationState(this._storage);

  bool get notificationsEnabled => _notificationsEnabled;
  bool get soundEnabled => _soundEnabled;
  bool get vibrationEnabled => _vibrationEnabled;
  Map<String, bool> get notificationTypes => Map.unmodifiable(_notificationTypes);

  @override
  Future<void> initialize() async {
    _notificationsEnabled = await _storage.getValue('notifications_enabled', true) ?? true;
    _soundEnabled = await _storage.getValue('notifications_sound', true) ?? true;
    _vibrationEnabled = await _storage.getValue('notifications_vibration', true) ?? true;
    
    final savedTypes = await _storage.getValue('notification_types', _notificationTypes);
    if (savedTypes != null) {
      _notificationTypes = Map<String, bool>.from(savedTypes as Map);
    }
    
    markInitialized();
  }

  Future<void> updateNotificationsEnabled(bool enabled) async {
    if (enabled != _notificationsEnabled) {
      _notificationsEnabled = enabled;
      await _storage.setValue('notifications_enabled', enabled);
      notifyListeners();
    }
  }

  Future<void> updateSoundEnabled(bool enabled) async {
    if (enabled != _soundEnabled) {
      _soundEnabled = enabled;
      await _storage.setValue('notifications_sound', enabled);
      notifyListeners();
    }
  }

  Future<void> updateVibrationEnabled(bool enabled) async {
    if (enabled != _vibrationEnabled) {
      _vibrationEnabled = enabled;
      await _storage.setValue('notifications_vibration', enabled);
      notifyListeners();
    }
  }

  Future<void> updateNotificationType(String type, bool enabled) async {
    if (_notificationTypes.containsKey(type) && _notificationTypes[type] != enabled) {
      _notificationTypes[type] = enabled;
      await _storage.setValue('notification_types', _notificationTypes);
      notifyListeners();
    }
  }

  @override
  Future<void> clear() async {
    _notificationsEnabled = true;
    _soundEnabled = true;
    _vibrationEnabled = true;
    _notificationTypes = {
      'announcements': true,
      'leaveRequests': true,
      'timeTracking': true,
      'overtime': true,
    };
    notifyListeners();
  }
}