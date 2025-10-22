import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'storage_service.dart';
import 'boxes.dart';

/// Keys used for storage across the app
class StorageKeys {
  // Auth
  static const String token = 'token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String companyId = 'company_id';
  static const String employeeId = 'employee_id';
  static const String canApprove = 'can_approve';

  // Profile
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String position = 'position';
  static const String department = 'department';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String profileImage = 'profile_image';

  // Settings
  static const String language = 'language';
  static const String theme = 'theme';
  static const String notifications = 'notifications_enabled';
  static const String biometric = 'biometric_enabled';
  static const String pinCode = 'pin_code';

  // Time tracking
  static const String clockInTime = 'clock_in_time';
  static const String clockInLocation = 'clock_in_location';
  static const String clockInLatitude = 'clock_in_latitude';
  static const String clockInLongitude = 'clock_in_longitude';
}

/// Manager for handling data migration from old storage systems to Hive
class StorageMigrationManager {
  static const String _migrationCompleteKey = 'storage_migration_v2_complete';
  final FlutterSecureStorage _secureStorage;
  final IStorageService _storage;

  StorageMigrationManager(this._storage, [FlutterSecureStorage? secureStorage])
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  /// Check if migration is needed
  Future<bool> needsMigration() async {
    try {
      final completed = await _secureStorage.read(key: _migrationCompleteKey);
      return completed != 'true';
    } catch (e) {
      print('Error checking migration status: $e');
      return true;
    }
  }

  /// Run all migrations
  Future<void> migrateAllData() async {
    if (!await needsMigration()) return;

    try {
      await Future.wait([
        _migrateAuthData(),
        _migrateProfileData(),
        _migrateSettingsData(),
        _migrateTimeTrackingData(),
      ]);

      await _secureStorage.write(key: _migrationCompleteKey, value: 'true');
    } catch (e) {
      print('Error during migration: $e');
    }
  }

  Future<void> _migrateAuthData() async {
    try {
      final data = await Future.wait([
        _secureStorage.read(key: 'auth_token'),
        _secureStorage.read(key: 'auth_refresh_token'),
        _secureStorage.read(key: 'auth_user_id'),
        _secureStorage.read(key: 'auth_company_id'),
        _secureStorage.read(key: 'auth_employee_id'),
        _secureStorage.read(key: 'auth_can_approve'),
      ]);

      await Future.wait([
        _storage.setValue(Boxes.auth, StorageKeys.token, data[0]),
        _storage.setValue(Boxes.auth, StorageKeys.refreshToken, data[1]),
        _storage.setValue(Boxes.auth, StorageKeys.userId, data[2]),
        _storage.setValue(Boxes.auth, StorageKeys.companyId, data[3]),
        _storage.setValue(Boxes.auth, StorageKeys.employeeId, data[4]),
        _storage.setValue(Boxes.auth, StorageKeys.canApprove, data[5] == 'true'),
      ]);

      await Future.wait([
        _secureStorage.delete(key: 'auth_token'),
        _secureStorage.delete(key: 'auth_refresh_token'),
        _secureStorage.delete(key: 'auth_user_id'),
        _secureStorage.delete(key: 'auth_company_id'),
        _secureStorage.delete(key: 'auth_employee_id'),
        _secureStorage.delete(key: 'auth_can_approve'),
      ]);
    } catch (e) {
      print('Error migrating auth data: $e');
    }
  }

  Future<void> _migrateProfileData() async {
    try {
      final data = await Future.wait([
        _secureStorage.read(key: 'profile_first_name'),
        _secureStorage.read(key: 'profile_last_name'),
        _secureStorage.read(key: 'profile_position'),
        _secureStorage.read(key: 'profile_department'),
        _secureStorage.read(key: 'profile_email'),
        _secureStorage.read(key: 'profile_phone'),
        _secureStorage.read(key: 'profile_image'),
      ]);

      await Future.wait([
        _storage.setValue(Boxes.profile, StorageKeys.firstName, data[0]),
        _storage.setValue(Boxes.profile, StorageKeys.lastName, data[1]),
        _storage.setValue(Boxes.profile, StorageKeys.position, data[2]),
        _storage.setValue(Boxes.profile, StorageKeys.department, data[3]),
        _storage.setValue(Boxes.profile, StorageKeys.email, data[4]),
        _storage.setValue(Boxes.profile, StorageKeys.phone, data[5]),
        _storage.setValue(Boxes.profile, StorageKeys.profileImage, data[6]),
      ]);

      await Future.wait([
        _secureStorage.delete(key: 'profile_first_name'),
        _secureStorage.delete(key: 'profile_last_name'),
        _secureStorage.delete(key: 'profile_position'),
        _secureStorage.delete(key: 'profile_department'),
        _secureStorage.delete(key: 'profile_email'),
        _secureStorage.delete(key: 'profile_phone'),
        _secureStorage.delete(key: 'profile_image'),
      ]);
    } catch (e) {
      print('Error migrating profile data: $e');
    }
  }

  Future<void> _migrateSettingsData() async {
    try {
      final data = await Future.wait([
        _secureStorage.read(key: 'settings_language'),
        _secureStorage.read(key: 'settings_theme'),
        _secureStorage.read(key: 'settings_notifications'),
        _secureStorage.read(key: 'settings_biometric'),
        _secureStorage.read(key: 'settings_pin_code'),
      ]);

      await Future.wait([
        _storage.setValue(Boxes.settings, StorageKeys.language, data[0] ?? 'en'),
        _storage.setValue(Boxes.settings, StorageKeys.theme, data[1] ?? 'light'),
        _storage.setValue(Boxes.settings, StorageKeys.notifications, data[2] == 'true'),
        _storage.setValue(Boxes.settings, StorageKeys.biometric, data[3] == 'true'),
        _storage.setValue(Boxes.settings, StorageKeys.pinCode, data[4]),
      ]);

      await Future.wait([
        _secureStorage.delete(key: 'settings_language'),
        _secureStorage.delete(key: 'settings_theme'),
        _secureStorage.delete(key: 'settings_notifications'),
        _secureStorage.delete(key: 'settings_biometric'),
        _secureStorage.delete(key: 'settings_pin_code'),
      ]);
    } catch (e) {
      print('Error migrating settings data: $e');
    }
  }

  Future<void> _migrateTimeTrackingData() async {
    try {
      final data = await Future.wait([
        _secureStorage.read(key: 'time_clock_in_time'),
        _secureStorage.read(key: 'time_clock_in_location'),
        _secureStorage.read(key: 'time_clock_in_latitude'),
        _secureStorage.read(key: 'time_clock_in_longitude'),
      ]);

      await Future.wait([
        _storage.setValue(Boxes.timeTracking, StorageKeys.clockInTime, data[0]),
        _storage.setValue(Boxes.timeTracking, StorageKeys.clockInLocation, data[1]),
        _storage.setValue(Boxes.timeTracking, StorageKeys.clockInLatitude, double.tryParse(data[2] ?? '')),
        _storage.setValue(Boxes.timeTracking, StorageKeys.clockInLongitude, double.tryParse(data[3] ?? '')),
      ]);

      await Future.wait([
        _secureStorage.delete(key: 'time_clock_in_time'),
        _secureStorage.delete(key: 'time_clock_in_location'),
        _secureStorage.delete(key: 'time_clock_in_latitude'),
        _secureStorage.delete(key: 'time_clock_in_longitude'),
      ]);
    } catch (e) {
      print('Error migrating time tracking data: $e');
    }
  }
}