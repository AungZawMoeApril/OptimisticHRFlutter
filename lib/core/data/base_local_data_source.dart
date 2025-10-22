import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../storage/boxes.dart';
import '../storage/storage_service.dart';

/// Base class for local data sources
abstract class BaseLocalDataSource {
  final IStorageService storage;
  final String box;

  BaseLocalDataSource(this.storage, this.box);

  /// Cache an item
  Future<void> cacheItem<T>(String key, T item) async {
    try {
      await storage.setValue(box, key, item);
    } catch (e) {
      debugPrint('Error caching item for key $key: $e');
      throw CacheException();
    }
  }

  /// Get a cached item
  Future<T?> getCachedItem<T>(String key, [T? defaultValue]) async {
    try {
      return await storage.getValue<T>(box, key, defaultValue);
    } catch (e) {
      debugPrint('Error getting cached item for key $key: $e');
      return defaultValue;
    }
  }

  /// Clear a cached item
  Future<void> clearCachedItem(String key) async {
    try {
      await storage.removeValue(box, key);
    } catch (e) {
      debugPrint('Error clearing cached item for key $key: $e');
    }
  }

  /// Clear all cached items in this box
  Future<void> clearAll() async {
    try {
      await storage.clearBox(box);
    } catch (e) {
      debugPrint('Error clearing box $box: $e');
    }
  }
}

/// Exception thrown when caching operations fail
class CacheException implements Exception {}