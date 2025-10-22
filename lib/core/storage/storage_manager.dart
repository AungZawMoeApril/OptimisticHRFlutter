import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'storage_migration_manager.dart';

/// Storage manager using Hive for efficient persistence
class StorageManager {
  static const String _authBox = 'authBox';
  static const String _profileBox = 'profileBox';
  static const String _settingsBox = 'settingsBox';
  static const String _timeTrackingBox = 'timeTrackingBox';
  static const String _leaveBox = 'leaveBox';
  static const String _overtimeBox = 'overtimeBox';

  /// Initialize Hive and register adapters
  static Future<void> initialize() async {
    final appDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDir.path);

    // Open boxes
    await Future.wait([
      Hive.openBox(_authBox),
      Hive.openBox(_profileBox),
      Hive.openBox(_settingsBox),
      Hive.openBox(_timeTrackingBox),
      Hive.openBox(_leaveBox),
      Hive.openBox(_overtimeBox),
    ]);

    // Run data migration
    final migrationManager = StorageMigrationManager();
    await migrationManager.migrateAllData();
  }

  /// Get value from storage with type safety
  static Future<T?> getValue<T>(String boxName, String key, [T? defaultValue]) async {
    final box = Hive.box(boxName);
    final value = box.get(key);

    if (value == null) return defaultValue;

    // Handle primitive types directly
    if (T == String || T == int || T == double || T == bool) {
      return value as T;
    }

    // Handle DateTime
    if (T == DateTime && value is String) {
      return DateTime.tryParse(value) as T?;
    }

    // Handle Map and List
    if ((T == Map || T == List) && value is String) {
      try {
        return json.decode(value) as T;
      } catch (e) {
        print('Error decoding JSON: $e');
        return defaultValue;
      }
    }

    return defaultValue;
  }

  /// Save value to storage with type safety
  static Future<void> setValue<T>(String boxName, String key, T? value) async {
    final box = Hive.box(boxName);

    if (value == null) {
      await box.delete(key);
      return;
    }

    // Handle primitive types directly
    if (value is String || value is int || value is double || value is bool) {
      await box.put(key, value);
      return;
    }

    // Handle DateTime
    if (value is DateTime) {
      await box.put(key, value.toIso8601String());
      return;
    }

    // Handle Map and List
    if (value is Map || value is List) {
      try {
        await box.put(key, json.encode(value));
      } catch (e) {
        print('Error encoding JSON: $e');
      }
      return;
    }

    throw UnsupportedError('Type ${T.toString()} is not supported for storage');
  }

  /// Clear all data from a specific box
  static Future<void> clearBox(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  /// Clear all boxes
  static Future<void> clearAll() async {
    await Future.wait([
      clearBox(_authBox),
      clearBox(_profileBox),
      clearBox(_settingsBox),
      clearBox(_timeTrackingBox),
      clearBox(_leaveBox),
      clearBox(_overtimeBox),
    ]);
  }

  // Convenience methods for different state types
  static String get authBox => _authBox;
  static String get profileBox => _profileBox;
  static String get settingsBox => _settingsBox;
  static String get timeTrackingBox => _timeTrackingBox;
  static String get leaveBox => _leaveBox;
  static String get overtimeBox => _overtimeBox;
}