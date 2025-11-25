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
  late final AuthStateNotifier auth;
  late final ProfileStateNotifier profile;
  late final SettingsStateNotifier settings;
  late final TimeTrackingStateNotifier timeTracking;
  late final LeaveStateNotifier leave;
  late final OvertimeStateNotifier overtime;
  
  bool _initialized = false;
  
  // Personal info fields for compatibility
  String? _prefix;
  String? _email;
  String? _departmentName;
  String? _phone;
  String? _hiredDate;
  String? _nickName;
  String? _token;
  int? _companyID;
  int? _employeeID;
  
  // Getters and setters
  String? get prefix => _prefix;
  set prefix(String? value) {
    _prefix = value;
    notifyListeners();
  }
  
  String? get email => _email;
  set email(String? value) {
    _email = value;
    notifyListeners();
  }
  
  String? get departmentName => _departmentName;
  set departmentName(String? value) {
    _departmentName = value;
    notifyListeners();
  }
  
  String? get phone => _phone;
  set phone(String? value) {
    _phone = value;
    notifyListeners();
  }
  
  String? get hiredDate => _hiredDate;
  set hiredDate(String? value) {
    _hiredDate = value;
    notifyListeners();
  }
  
  String? get nickName => _nickName;
  set nickName(String? value) {
    _nickName = value;
    notifyListeners();
  }
  
  String? get token => _token;
  set token(String? value) {
    _token = value;
    notifyListeners();
  }
  
  int? get companyID => _companyID;
  set companyID(int? value) {
    _companyID = value;
    notifyListeners();
  }
  
  int? get employeeID => _employeeID;
  set employeeID(int? value) {
    _employeeID = value;
    notifyListeners();
  }
  
  // Additional compatibility fields
  String? _timeType;
  String? get timeType => _timeType;
  set timeType(String? value) {
    _timeType = value;
    notifyListeners();
  }
  
  String? _timezoneOffset;
  String? get timezoneOffset => _timezoneOffset;
  set timezoneOffset(String? value) {
    _timezoneOffset = value;
    notifyListeners();
  }

  AppState([SecureStorageProvider? storage]) {
    _initializeNotifiers();
  }

  bool get isInitialized => _initialized;

  void _initializeNotifiers() {
    auth = AuthStateNotifier();
    profile = ProfileStateNotifier();
    settings = SettingsStateNotifier();
    timeTracking = TimeTrackingStateNotifier();
    leave = LeaveStateNotifier();
    overtime = OvertimeStateNotifier();
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