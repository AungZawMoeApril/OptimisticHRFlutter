import 'package:flutter/material.dart';
import '../storage/boxes.dart';
import '../storage/storage_service.dart';
import '../storage/storage_migration.dart';

class AppStateProvider extends ChangeNotifier {
  final IStorageService _storage;
  
  AppStateProvider(this._storage);

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
    await _storage.write('pinCode', pin);
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

  AppStateProvider() {
    _loadPersistedState();
  }

  Future<void> _loadPersistedState() async {
    // Load theme
    final savedTheme = _storage.read('themeMode');
    if (savedTheme != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == savedTheme,
      );
    }

    // Load PIN code
    _pinCode = await _storage.read('pinCode');
        orElse: () => ThemeMode.system,
      );
    }

    // Load locale
    final savedLocale = _storage.read('locale');
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
    }

    // Load auth state
    _token = _storage.read('token');
    _userId = _storage.read('userId');
    _companyId = _storage.read('companyId');
    _employeeId = _storage.read('employeeId');

    // Load location state
    _clockInTime = _storage.read('clockInTime');
    _clockInLocation = _storage.read('clockInLocation');
    _clockInLatitude = _storage.read('clockInLatitude');
    _clockInLongitude = _storage.read('clockInLongitude');

    notifyListeners();
  }

  // Theme Methods
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _storage.write('themeMode', mode.toString());
    notifyListeners();
  }

  // Locale Methods
  void setLocale(String languageCode) {
    _locale = Locale(languageCode);
    _storage.write('locale', languageCode);
    notifyListeners();
  }

  // Auth Methods
  void setAuthState({
    required String token,
    required String userId,
    required String companyId,
    required String employeeId,
  }) {
    _token = token;
    _userId = userId;
    _companyId = companyId;
    _employeeId = employeeId;

    _storage.write('token', token);
    _storage.write('userId', userId);
    _storage.write('companyId', companyId);
    _storage.write('employeeId', employeeId);

    notifyListeners();
  }

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

    await _storage.write('token', token);
    await _storage.write('userId', userId);
    await _storage.write('companyId', companyId);
    await _storage.write('employeeId', employeeId);

    notifyListeners();
  }

  void clearAuthState() {
    _token = null;
    _userId = null;
    _companyId = null;
    _employeeId = null;

    _storage.remove('token');
    _storage.remove('userId');
    _storage.remove('companyId');
    _storage.remove('employeeId');

    notifyListeners();
  }

  // Location Methods
  void setCheckInInfo({
    required String time,
    required String location,
    required double latitude,
    required double longitude,
  }) {
    _clockInTime = time;
    _clockInLocation = location;
    _clockInLatitude = latitude;
    _clockInLongitude = longitude;

    _storage.write('clockInTime', time);
    _storage.write('clockInLocation', location);
    _storage.write('clockInLatitude', latitude);
    _storage.write('clockInLongitude', longitude);

    notifyListeners();
  }

  void clearCheckInInfo() {
    _clockInTime = null;
    _clockInLocation = null;
    _clockInLatitude = null;
    _clockInLongitude = null;

    _storage.remove('clockInTime');
    _storage.remove('clockInLocation');
    _storage.remove('clockInLatitude');
    _storage.remove('clockInLongitude');

    notifyListeners();
  }
}