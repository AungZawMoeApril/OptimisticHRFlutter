import 'package:flutter/foundation.dart';
import '../storage/secure_storage.dart';
import 'notifiers/auth_state_notifier.dart';
import 'notifiers/profile_state_notifier.dart';
import 'notifiers/settings_state_notifier.dart';
import 'notifiers/time_tracking_state_notifier.dart';
import 'notifiers/leave_state_notifier.dart';
import 'notifiers/overtime_state_notifier.dart';

/// Main application state class that coordinates all state notifiers
class AppState with ChangeNotifier {
  final SecureStorageProvider _storage;
  
  late final AuthStateNotifier auth;
  late final ProfileStateNotifier profile;
  late final SettingsStateNotifier settings;
  late final TimeTrackingStateNotifier timeTracking;
  late final LeaveStateNotifier leave;
  late final OvertimeStateNotifier overtime;
  
  bool _initialized = false;

  AppState([SecureStorageProvider? storage]) 
    : _storage = storage ?? SecureStorageProvider() {
    _initializeNotifiers();
  }

  bool get isInitialized => _initialized;

  void _initializeNotifiers() {
    auth = AuthStateNotifier(_storage);
    profile = ProfileStateNotifier(_storage);
    settings = SettingsStateNotifier(_storage);
    timeTracking = TimeTrackingStateNotifier(_storage);
    leave = LeaveStateNotifier(_storage);
    overtime = OvertimeStateNotifier(_storage);
  }

  /// Initialize all state notifiers
  Future<void> initialize() async {
    if (_initialized) return;

    await Future.wait([
      auth.initialize(),
      profile.initialize(),
      settings.initialize(),
      timeTracking.initialize(),
      leave.initialize(),
      overtime.initialize(),
    ]);

    _initialized = true;
    notifyListeners();
  }

  /// Clear all state and storage
  Future<void> clear() async {
    await Future.wait([
      auth.clear(),
      profile.clear(),
      settings.clear(),
      timeTracking.clear(),
      leave.clear(),
      overtime.clear(),
    ]);

    _initialized = false;
    notifyListeners();
  }

  @override
  void dispose() {
    auth.dispose();
    profile.dispose();
    settings.dispose();
    timeTracking.dispose();
    leave.dispose();
    overtime.dispose();
    super.dispose();
  }
}