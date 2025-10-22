import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:synchronized/synchronized.dart';

import 'backend/schema/structs/index.dart';

/// Application state management class that handles all global state.
class AppState with ChangeNotifier {
  // Singleton instance and storage
  static final AppState _instance = AppState._internal();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final _initCompleter = Completer<void>();

  // App theme and locale
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en');

  // Authentication state
  String _token = '';
  int _companyID = 0;
  int _employeeID = 0;
  int _userID = 0;
  bool _approve = false;
  
  // User profile state
  String _firstName = '';
  String _lastName = '';
  String _positionName = '';
  String _imagesFile = '';
  String _logoImage = '';
  String _colorCode = '';
  
  // Overtime state
  List<RejectPendingApprovalStruct> _onloadGetOTandTimeOff = [];
  List<RejectPendingApprovalStruct> _onloadGetOTandTimeOffHistory = [];
  String _taskType = 'Time Off';
  
  // Calendar state
  List<dynamic> _calendarList = [];
  List<dynamic> _selectedEventsJSon = [];



  factory AppState() {
    return _instance;
  }

  AppState._internal() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _loadThemeAndLocale();
      await _loadAuthState();
      await _loadUserProfile();
      _initCompleter.complete();
    } catch (e) {
      _initCompleter.completeError(e);
    }
  }

  Future<void> _loadThemeAndLocale() async {
    final themeModeString = await secureStorage.read(key: 'theme_mode');
    if (themeModeString != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == themeModeString,
        orElse: () => ThemeMode.system,
      );
    }

    final localeString = await secureStorage.read(key: 'locale');
    if (localeString != null) {
      final parts = localeString.split('_');
      _locale = parts.length > 1
          ? Locale(parts[0], parts[1])
          : Locale(parts[0]);
    }
  }

  Future<void> _loadAuthState() async {
    _token = await secureStorage.read(key: 'app_token') ?? '';
    _companyID = int.tryParse(await secureStorage.read(key: 'app_company_id') ?? '0') ?? 0;
    _employeeID = int.tryParse(await secureStorage.read(key: 'app_employee_id') ?? '0') ?? 0;
    _userID = int.tryParse(await secureStorage.read(key: 'app_user_id') ?? '0') ?? 0;
    _approve = (await secureStorage.read(key: 'app_approve') ?? 'false') == 'true';
  }

  Future<void> _loadUserProfile() async {
    _firstName = await secureStorage.read(key: 'app_first_name') ?? '';
    _lastName = await secureStorage.read(key: 'app_last_name') ?? '';
    _positionName = await secureStorage.read(key: 'app_position_name') ?? '';
    _imagesFile = await secureStorage.read(key: 'app_images_file') ?? '';
    _logoImage = await secureStorage.read(key: 'app_logo_image') ?? '';
    _colorCode = await secureStorage.read(key: 'app_color_code') ?? '';
  }

  Future<void> ensureInitialized() => _initCompleter.future;

  // Getters
  String get token => _token;
  int get companyID => _companyID;
  int get employeeID => _employeeID;
  int get userID => _userID;
  bool get approve => _approve;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get positionName => _positionName;
  String get imagesFile => _imagesFile;
  String get logoImage => _logoImage;
  String get colorCode => _colorCode;

  // Update Methods
  Future<void> updateToken(String value) async {
    if (_token != value) {
      _token = value;
      await secureStorage.write(key: 'app_token', value: value);
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? positionName,
    String? imagesFile,
    String? logoImage,
    String? colorCode,
  }) async {
    bool changed = false;

    if (firstName != null && _firstName != firstName) {
      _firstName = firstName;
      await secureStorage.write(key: 'app_first_name', value: firstName);
      changed = true;
    }

    if (lastName != null && _lastName != lastName) {
      _lastName = lastName;
      await secureStorage.write(key: 'app_last_name', value: lastName);
      changed = true;
    }

    if (positionName != null && _positionName != positionName) {
      _positionName = positionName;
      await secureStorage.write(key: 'app_position_name', value: positionName);
      changed = true;
    }

    if (imagesFile != null && _imagesFile != imagesFile) {
      _imagesFile = imagesFile;
      await secureStorage.write(key: 'app_images_file', value: imagesFile);
      changed = true;
    }

    if (logoImage != null && _logoImage != logoImage) {
      _logoImage = logoImage;
      await secureStorage.write(key: 'app_logo_image', value: logoImage);
      changed = true;
    }

    if (colorCode != null && _colorCode != colorCode) {
      _colorCode = colorCode;
      await secureStorage.write(key: 'app_color_code', value: colorCode);
      changed = true;
    }

    if (changed) {
      notifyListeners();
    }
  }

  Future<void> resetState() async {
    await secureStorage.deleteAll();

    _token = '';
    _companyID = 0;
    _employeeID = 0;
    _userID = 0;
    _approve = false;

    _firstName = '';
    _lastName = '';
    _positionName = '';
    _imagesFile = '';
    _logoImage = '';
    _colorCode = '';

    notifyListeners();
  }

  static void reset() {
    // Do nothing since _instance is final
  }

  // Theme and Locale
  ThemeMode get themeMode => _themeMode;
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    await secureStorage.write(key: 'theme_mode', value: mode.toString());
    notifyListeners();
  }

  Locale get locale => _locale;
  Future<void> setLocale(Locale value) async {
    if (_locale == value) return;
    _locale = value;
    await secureStorage.write(key: 'locale', value: value.toString());
    notifyListeners();
  }

  // Helper functions
  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  // List getters/setters
  List<RejectPendingApprovalStruct> get onloadGetOTandTimeOff => _onloadGetOTandTimeOff;
  set onloadGetOTandTimeOff(List<RejectPendingApprovalStruct> value) {
    _onloadGetOTandTimeOff = value;
    notifyListeners();
  }

  List<RejectPendingApprovalStruct> get onloadGetOTandTimeOffHistory => _onloadGetOTandTimeOffHistory;
  set onloadGetOTandTimeOffHistory(List<RejectPendingApprovalStruct> value) {
    _onloadGetOTandTimeOffHistory = value;
    notifyListeners();
  }

  String get taskType => _taskType;
  set taskType(String value) {
    _taskType = value;
    notifyListeners();
  }

  List<dynamic> get calendarList => _calendarList;
  set calendarList(List<dynamic> value) {
    _calendarList = value;
    notifyListeners();
  }

  List<dynamic> get selectedEventsJSon => _selectedEventsJSon;
  set selectedEventsJSon(List<dynamic> value) {
    _selectedEventsJSon = value;
    notifyListeners();
  }


}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        try {
          return List<dynamic>.from(jsonDecode(result))
              .map((e) => e.toString())
              .toList();
        } catch (_) {
          return null;
        }
      });

  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: jsonEncode(value));
}
