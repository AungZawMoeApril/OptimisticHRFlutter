import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



/// A base class that provides secure storage functionality
class SecureStorageProvider {
  final _storage = const FlutterSecureStorage();

  Future<T?> getValue<T>(String key, T? defaultValue) async {
    final value = await _storage.read(key: key);
    if (value == null) return defaultValue;

    try {
      if (T == bool) {
        return (value.toLowerCase() == 'true') as T;
      } else if (T == int) {
        return int.tryParse(value) as T?;
      } else if (T == String) {
        return value as T;
      } else {
        return jsonDecode(value) as T;
      }
    } catch (e) {
      debugPrint('Error loading value for key $key: $e');
      return defaultValue;
    }
  }

  Future<void> setValue<T>(String key, T value) async {
    if (value == null) {
      await _storage.delete(key: key);
    } else {
      String serializedValue;
      if (value is bool || value is int) {
        serializedValue = value.toString();
      } else if (value is String) {
        serializedValue = value;
      } else {
        serializedValue = jsonEncode(value);
      }
      await _storage.write(key: key, value: serializedValue);
    }
  }

  Future<void> clearStorage() => _storage.deleteAll();
}