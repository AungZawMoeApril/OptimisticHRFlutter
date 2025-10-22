import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'storage_manager.dart';
import 'migration_progress.dart';

/// Manager for handling data migration from old storage systems to new Hive storage
class StorageMigrationManager {
  static const String _migrationCompleteKey = 'storage_migration_v1_complete';
  final FlutterSecureStorage _secureStorage;

  StorageMigrationManager([FlutterSecureStorage? secureStorage])
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  /// Check if migration has been completed
  Future<bool> isMigrationComplete() async {
    try {
      final value = await _secureStorage.read(key: _migrationCompleteKey);
      return value == 'true';
    } catch (e) {
      print('Error checking migration status: $e');
      return false;
    }
  }

  /// Mark migration as complete
  Future<void> markMigrationComplete() async {
    try {
      await _secureStorage.write(key: _migrationCompleteKey, value: 'true');
    } catch (e) {
      print('Error marking migration complete: $e');
    }
  }

  /// Migrate auth data from secure storage to Hive
  Future<void> migrateAuthData() async {
    try {
      // Read old auth data
      final token = await _secureStorage.read(key: 'auth_token');
      final companyId = await _secureStorage.read(key: 'auth_company_id');
      final employeeId = await _secureStorage.read(key: 'auth_employee_id');
      final userId = await _secureStorage.read(key: 'auth_user_id');
      final canApprove = await _secureStorage.read(key: 'auth_can_approve');

      // Write to new storage
      await StorageManager.setValue(StorageManager.authBox, 'token', token);
      await StorageManager.setValue(StorageManager.authBox, 'company_id', companyId);
      await StorageManager.setValue(StorageManager.authBox, 'employee_id', employeeId);
      await StorageManager.setValue(StorageManager.authBox, 'user_id', userId);
      await StorageManager.setValue(StorageManager.authBox, 'can_approve', canApprove == 'true');

      // Clean up old data
      await _secureStorage.delete(key: 'auth_token');
      await _secureStorage.delete(key: 'auth_company_id');
      await _secureStorage.delete(key: 'auth_employee_id');
      await _secureStorage.delete(key: 'auth_user_id');
      await _secureStorage.delete(key: 'auth_can_approve');
    } catch (e) {
      print('Error migrating auth data: $e');
    }
  }

  /// Migrate profile data from secure storage to Hive
  Future<void> migrateProfileData() async {
    try {
      // Read old profile data
      final firstName = await _secureStorage.read(key: 'profile_first_name');
      final lastName = await _secureStorage.read(key: 'profile_last_name');
      final position = await _secureStorage.read(key: 'profile_position');
      final department = await _secureStorage.read(key: 'profile_department');
      final email = await _secureStorage.read(key: 'profile_email');
      final phone = await _secureStorage.read(key: 'profile_phone');
      final image = await _secureStorage.read(key: 'profile_image');

      // Write to new storage
      await StorageManager.setValue(StorageManager.profileBox, 'first_name', firstName);
      await StorageManager.setValue(StorageManager.profileBox, 'last_name', lastName);
      await StorageManager.setValue(StorageManager.profileBox, 'position', position);
      await StorageManager.setValue(StorageManager.profileBox, 'department', department);
      await StorageManager.setValue(StorageManager.profileBox, 'email', email);
      await StorageManager.setValue(StorageManager.profileBox, 'phone', phone);
      await StorageManager.setValue(StorageManager.profileBox, 'image', image);

      // Clean up old data
      await _secureStorage.delete(key: 'profile_first_name');
      await _secureStorage.delete(key: 'profile_last_name');
      await _secureStorage.delete(key: 'profile_position');
      await _secureStorage.delete(key: 'profile_department');
      await _secureStorage.delete(key: 'profile_email');
      await _secureStorage.delete(key: 'profile_phone');
      await _secureStorage.delete(key: 'profile_image');
    } catch (e) {
      print('Error migrating profile data: $e');
    }
  }

  /// Migrate settings from secure storage to Hive
  Future<void> migrateSettingsData() async {
    try {
      // Read old settings data
      final language = await _secureStorage.read(key: 'settings_language');
      final theme = await _secureStorage.read(key: 'settings_theme');
      final notifications = await _secureStorage.read(key: 'settings_notifications');
      final biometric = await _secureStorage.read(key: 'settings_biometric');

      // Write to new storage
      await StorageManager.setValue(StorageManager.settingsBox, 'language', language ?? 'en');
      await StorageManager.setValue(StorageManager.settingsBox, 'theme', theme ?? 'light');
      await StorageManager.setValue(StorageManager.settingsBox, 'notifications_enabled', notifications == 'true');
      await StorageManager.setValue(StorageManager.settingsBox, 'biometric_enabled', biometric == 'true');

      // Clean up old data
      await _secureStorage.delete(key: 'settings_language');
      await _secureStorage.delete(key: 'settings_theme');
      await _secureStorage.delete(key: 'settings_notifications');
      await _secureStorage.delete(key: 'settings_biometric');
    } catch (e) {
      print('Error migrating settings data: $e');
    }
  }

  /// Run complete migration process
  Future<void> migrateAllData({MigrationProgress? progress}) async {
    try {
      if (await isMigrationComplete()) {
        progress?.completeMigration();
        return;
      }

      progress?.startMigration();
      
      // Migrate all data types
      progress?.updateProgress('Migrating authentication data...', 0.25);
      await migrateAuthData();

      progress?.updateProgress('Migrating profile data...', 0.50);
      await migrateProfileData();

      progress?.updateProgress('Migrating settings...', 0.75);
      await migrateSettingsData();

      // Mark migration as complete
      await markMigrationComplete();
      progress?.completeMigration();
    } catch (e) {
      progress?.setError('Migration failed: $e');
      rethrow;
    }
  }
}