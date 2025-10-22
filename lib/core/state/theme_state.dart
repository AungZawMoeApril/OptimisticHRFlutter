import 'base_state.dart';
import '../storage/secure_storage.dart';

/// Theme state model
class ThemeState extends BaseState {
  final SecureStorageProvider _storage;
  
  bool _isDarkMode = false;
  String _primaryColor = '0xFF2196F3'; // Default blue
  double _textScaleFactor = 1.0;

  ThemeState(this._storage);

  bool get isDarkMode => _isDarkMode;
  String get primaryColor => _primaryColor;
  double get textScaleFactor => _textScaleFactor;

  @override
  Future<void> initialize() async {
    _isDarkMode = await _storage.getValue('theme_dark_mode', false) ?? false;
    _primaryColor = await _storage.getValue('theme_primary_color', '0xFF2196F3') ?? '0xFF2196F3';
    _textScaleFactor = await _storage.getValue('theme_text_scale', 1.0) ?? 1.0;
    markInitialized();
  }

  Future<void> updateDarkMode(bool isDark) async {
    if (isDark != _isDarkMode) {
      _isDarkMode = isDark;
      await _storage.setValue('theme_dark_mode', isDark);
      notifyListeners();
    }
  }

  Future<void> updatePrimaryColor(String color) async {
    if (color != _primaryColor) {
      _primaryColor = color;
      await _storage.setValue('theme_primary_color', color);
      notifyListeners();
    }
  }

  Future<void> updateTextScale(double scale) async {
    if (scale != _textScaleFactor) {
      _textScaleFactor = scale;
      await _storage.setValue('theme_text_scale', scale);
      notifyListeners();
    }
  }

  @override
  Future<void> clear() async {
    _isDarkMode = false;
    _primaryColor = '0xFF2196F3';
    _textScaleFactor = 1.0;
    notifyListeners();
  }
}