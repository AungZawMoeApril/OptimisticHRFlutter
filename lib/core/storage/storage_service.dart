import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

/// Abstract interface for storage operations
abstract class IStorageService {
  Future<T?> getValue<T>(String box, String key, [T? defaultValue]);
  Future<void> setValue<T>(String box, String key, T? value);
  Future<void> removeValue(String box, String key);
  Future<void> clearBox(String box);
  Future<bool> hasKey(String box, String key);
}

/// Implementation of storage service using Hive
class StorageService implements IStorageService {
  @override
  Future<T?> getValue<T>(String box, String key, [T? defaultValue]) async {
    final hiveBox = Hive.box(box);
    final value = hiveBox.get(key);

    if (value == null) return defaultValue;

    // Handle primitive types
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
        print('Error decoding JSON for $key: $e');
        return defaultValue;
      }
    }

    return defaultValue;
  }

  @override
  Future<void> setValue<T>(String box, String key, T? value) async {
    final hiveBox = Hive.box(box);

    if (value == null) {
      await hiveBox.delete(key);
      return;
    }

    // Handle primitive types
    if (value is String || value is int || value is double || value is bool) {
      await hiveBox.put(key, value);
      return;
    }

    // Handle DateTime
    if (value is DateTime) {
      await hiveBox.put(key, value.toIso8601String());
      return;
    }

    // Handle Map and List
    if (value is Map || value is List) {
      try {
        await hiveBox.put(key, json.encode(value));
      } catch (e) {
        print('Error encoding JSON for $key: $e');
      }
      return;
    }

    throw UnsupportedError('Type ${T.toString()} is not supported for storage');
  }

  @override
  Future<void> removeValue(String box, String key) async {
    final hiveBox = Hive.box(box);
    await hiveBox.delete(key);
  }

  @override
  Future<void> clearBox(String box) async {
    final hiveBox = Hive.box(box);
    await hiveBox.clear();
  }

  @override
  Future<bool> hasKey(String box, String key) async {
    final hiveBox = Hive.box(box);
    return hiveBox.containsKey(key);
  }

  /// Initialize storage service
  static Future<void> initialize() async {
    final appDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDir.path);
  }
}