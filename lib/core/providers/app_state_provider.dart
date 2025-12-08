import 'package:flutter/material.dart';
import '../storage/boxes.dart';
import '../storage/storage_service.dart';

class AppStateProvider extends ChangeNotifier {
  final IStorageService _storage;

  AppStateProvider(this._storage) {
    _loadPersistedState();
  }

  // Theme
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  // Locale
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  // Auth State
  String? _token;
  String? get token => _token;
  String? get authToken => _token; // Alias for compatibility

  String? _userId;
  String? get userId => _userId;

  String? _companyId;
  String? get companyId => _companyId;

  String? _employeeId;
  String? get employeeId => _employeeId;

  bool get isAuthenticated => _token != null;
  String get matchedLocation => _currentRoute;
  String _currentRoute = '/';

  // PIN Code State
  String? _pinCode;
  String? get pinCode => _pinCode;

  bool _isPinVerified = false;
  bool get isPinVerified => _isPinVerified;

  Future<void> setPinCode(String pin) async {
    await _storage.setValue<String>(Boxes.settings, 'pinCode', pin);
    _pinCode = pin;
    notifyListeners();
  }

  Future<void> verifyPinCode(bool verified) async {
    _isPinVerified = verified;
    notifyListeners();
  }

  // Location State
  String? _clockInTime;
  String? get clockInTime => _clockInTime;

  String? _clockInLocation;
  String? get clockInLocation => _clockInLocation;

  double? _clockInLatitude;
  double? get clockInLatitude => _clockInLatitude;

  double? _clockInLongitude;
  double? get clockInLongitude => _clockInLongitude;

  Future<void> _loadPersistedState() async {
    // Load theme
    final savedTheme = await _storage.getValue<String>(Boxes.settings, 'themeMode');
    if (savedTheme != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == savedTheme,
        orElse: () => ThemeMode.system,
      );
    }

    // Load PIN code
    _pinCode = await _storage.getValue<String>(Boxes.settings, 'pinCode');

    // Load locale
    final savedLocale = await _storage.getValue<String>(Boxes.settings, 'locale');
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
    }

    // Load auth state
    _token = await _storage.getValue<String>(Boxes.auth, 'token');
    _userId = await _storage.getValue<String>(Boxes.auth, 'userId');
    _companyId = await _storage.getValue<String>(Boxes.auth, 'companyId');
    _employeeId = await _storage.getValue<String>(Boxes.auth, 'employeeId');

    // Load location state
    _clockInTime = await _storage.getValue<String>(Boxes.timeTracking, 'clockInTime');
    _clockInLocation = await _storage.getValue<String>(Boxes.timeTracking, 'clockInLocation');
    _clockInLatitude = await _storage.getValue<double>(Boxes.timeTracking, 'clockInLatitude');
    _clockInLongitude = await _storage.getValue<double>(Boxes.timeTracking, 'clockInLongitude');

    notifyListeners();
  }

  // Theme Methods
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _storage.setValue<String>(Boxes.settings, 'themeMode', mode.toString());
    notifyListeners();
  }

  // Locale Methods
  Future<void> setLocale(String languageCode) async {
    _locale = Locale(languageCode);
    await _storage.setValue<String>(Boxes.settings, 'locale', languageCode);
    notifyListeners();
  }

  // Auth Methods
  Future<void> setAuthState({
    required String token,
    required String userId,
    required String companyId,
    required String employeeId,
  }) async {
    _token = token;
    _userId = userId;
    _companyId = companyId;
    _employeeId = employeeId;

    await _storage.setValue<String>(Boxes.auth, 'token', token);
    await _storage.setValue<String>(Boxes.auth, 'userId', userId);
    await _storage.setValue<String>(Boxes.auth, 'companyId', companyId);
    await _storage.setValue<String>(Boxes.auth, 'employeeId', employeeId);

    notifyListeners();
  }

  Future<void> clearAuthState() async {
    _token = null;
    _userId = null;
    _companyId = null;
    _employeeId = null;

    await _storage.removeValue(Boxes.auth, 'token');
    await _storage.removeValue(Boxes.auth, 'userId');
    await _storage.removeValue(Boxes.auth, 'companyId');
    await _storage.removeValue(Boxes.auth, 'employeeId');

    notifyListeners();
  }

  // Location Methods
  Future<void> setCheckInInfo({
    required String time,
    required String location,
    required double latitude,
    required double longitude,
  }) async {
    _clockInTime = time;
    _clockInLocation = location;
    _clockInLatitude = latitude;
    _clockInLongitude = longitude;

    await _storage.setValue<String>(Boxes.timeTracking, 'clockInTime', time);
    await _storage.setValue<String>(Boxes.timeTracking, 'clockInLocation', location);
    await _storage.setValue<double>(Boxes.timeTracking, 'clockInLatitude', latitude);
    await _storage.setValue<double>(Boxes.timeTracking, 'clockInLongitude', longitude);

    notifyListeners();
  }

  Future<void> clearCheckInInfo() async {
    _clockInTime = null;
    _clockInLocation = null;
    _clockInLatitude = null;
    _clockInLongitude = null;

    await _storage.removeValue(Boxes.timeTracking, 'clockInTime');
    await _storage.removeValue(Boxes.timeTracking, 'clockInLocation');
    await _storage.removeValue(Boxes.timeTracking, 'clockInLatitude');
    await _storage.removeValue(Boxes.timeTracking, 'clockInLongitude');

    notifyListeners();
  }
}
