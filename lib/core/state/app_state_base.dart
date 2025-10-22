import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class BaseAppState extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  Future<void> saveValue(String key, dynamic value) async {
    if (value == null) {
      await _storage.delete(key: key);
    } else {
      String serializedValue;
      if (value is bool) {
        serializedValue = value.toString();
      } else if (value is int) {
        serializedValue = value.toString();
      } else if (value is String) {
        serializedValue = value;
      } else if (value is List) {
        serializedValue = jsonEncode(value);
      } else {
        serializedValue = jsonEncode(value);
      }
      await _storage.write(key: key, value: serializedValue);
    }
    notifyListeners();
  }

  Future<T?> loadValue<T>(String key, T? defaultValue) async {
    final value = await _storage.read(key: key);
    if (value == null) return defaultValue;

    try {
      if (T == bool) {
        return (value.toLowerCase() == 'true') as T;
      } else if (T == int) {
        return int.tryParse(value) as T?;
      } else if (T == String) {
        return value as T;
      } else if (T == List) {
        return jsonDecode(value) as T;
      } else {
        return jsonDecode(value) as T;
      }
    } catch (e) {
      debugPrint('Error loading value for key $key: $e');
      return defaultValue;
    }
  }

  Future<void> clear() async {
    await _storage.deleteAll();
    notifyListeners();
  }
}