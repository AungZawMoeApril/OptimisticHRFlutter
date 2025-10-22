import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class PerformanceMetrics {
  static const int targetFps = 60;
  static const double targetFrameTime = 1000 / targetFps; // ms

  static Future<Map<String, dynamic>> measureMemoryUsage() async {
    final memoryInfo = await developer.serviceInfo.vm.getMemoryUsage();
    return {
      'heapSize': memoryInfo.heapSize,
      'heapUsed': memoryInfo.heapUsed,
      'externalSize': memoryInfo.external,
    };
  }

  static Future<void> logMemoryMetrics(String tag) async {
    final metrics = await measureMemoryUsage();
    debugPrint('Memory Metrics [$tag]');
    debugPrint('Heap Size: ${(metrics['heapSize'] / (1024 * 1024)).toStringAsFixed(2)} MB');
    debugPrint('Heap Used: ${(metrics['heapUsed'] / (1024 * 1024)).toStringAsFixed(2)} MB');
    debugPrint('External: ${(metrics['externalSize'] / (1024 * 1024)).toStringAsFixed(2)} MB');
  }

  static bool isPerformanceMet(int elapsedMs, {int? frames}) {
    if (frames != null) {
      final avgFrameTime = elapsedMs / frames;
      return avgFrameTime <= targetFrameTime;
    }
    return true;
  }

  static String getPerformanceGrade(int elapsedMs, {int? frames}) {
    if (frames != null) {
      final avgFrameTime = elapsedMs / frames;
      if (avgFrameTime <= targetFrameTime * 0.5) return 'Excellent';
      if (avgFrameTime <= targetFrameTime) return 'Good';
      if (avgFrameTime <= targetFrameTime * 1.5) return 'Fair';
      return 'Poor';
    }
    return 'Unknown';
  }
}