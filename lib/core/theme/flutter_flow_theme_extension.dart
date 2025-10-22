import 'package:flutter/material.dart';

// This extension provides backward compatibility for FlutterFlow theme access
// while maintaining proper Material theming
extension FlutterFlowThemeContextExtension on BuildContext {
  ThemeData get flutterFlowTheme => Theme.of(this);
}

// Temporary compatibility layer for FlutterFlow theme access
// This will help during migration while maintaining proper Material theming
class FlutterFlowTheme {
  static ThemeData of(BuildContext context) => Theme.of(context);
  
  // Text styles mapped to Material 3 text theme
  static TextTheme get bodyMedium => Typography.material2021().black;
  static TextStyle get titleMedium => Typography.material2021().black.titleMedium!;
  
  // Color schemes mapped to Material theme
  static ColorScheme get timeCheckin => const ColorScheme.light(
    primary: Color(0xFF4CAF50),
    secondary: Color(0xFF81C784),
  );
  
  static ColorScheme get themeColor => const ColorScheme.light(
    primary: Color(0xFF2196F3),
    secondary: Color(0xFF64B5F6),
    surface: Color(0xFFF5F5F5),
    background: Colors.white,
    error: Color(0xFFD32F2F),
  );
  
  // Legacy color properties mapped to Material 3 colors
  static Color get secondaryBackground => Colors.white;
  static Color get secondaryText => Colors.black54;
  static Color get surface => const Color(0xFFF5F5F5);
  static Color get alternate => const Color(0xFFEEEEEE);
  static Color get timeCheckIn => const Color(0xFF4CAF50);
  
  // Add getMaterialColorScheme helper for proper theme integration
  static ColorScheme getMaterialColorScheme(Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: const Color(0xFF2196F3),
      onPrimary: Colors.white,
      secondary: const Color(0xFF64B5F6),
      onSecondary: Colors.white,
      error: const Color(0xFFD32F2F),
      onError: Colors.white,
      background: brightness == Brightness.light ? Colors.white : const Color(0xFF121212),
      onBackground: brightness == Brightness.light ? Colors.black87 : Colors.white,
      surface: brightness == Brightness.light ? const Color(0xFFF5F5F5) : const Color(0xFF1E1E1E),
      onSurface: brightness == Brightness.light ? Colors.black87 : Colors.white,
    );
  }
}