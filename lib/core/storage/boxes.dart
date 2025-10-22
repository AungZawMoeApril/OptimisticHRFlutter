import 'package:hive_flutter/hive_flutter.dart';

/// Storage box names
class Boxes {
  static const String auth = 'authBox';
  static const String profile = 'profileBox';
  static const String settings = 'settingsBox';
  static const String timeTracking = 'timeTrackingBox';
  static const String leave = 'leaveBox';
  static const String overtime = 'overtimeBox';
  static const String onsite = 'onsiteBox';

  static Future<void> initialize() async {
    await Future.wait([
      Hive.openBox(auth),
      Hive.openBox(profile),
      Hive.openBox(settings),
      Hive.openBox(timeTracking),
      Hive.openBox(leave),
      Hive.openBox(overtime),
      Hive.openBox(onsite),
    ]);
  }
}