import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color themeColor;
  final Color primary;
  final Color secondary;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color background;
  final Color surface;
  final Color accent1;
  final Color accent2;
  final Color accent3;
  final Color accent4;

  const AppThemeExtension({
    required this.themeColor,
    required this.primary,
    required this.secondary,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.background,
    required this.surface,
    required this.accent1,
    required this.accent2,
    required this.accent3,
    required this.accent4,
  });

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? themeColor,
    Color? primary,
    Color? secondary,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? background,
    Color? surface,
    Color? accent1,
    Color? accent2,
    Color? accent3,
    Color? accent4,
  }) {
    return AppThemeExtension(
      themeColor: themeColor ?? this.themeColor,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      accent1: accent1 ?? this.accent1,
      accent2: accent2 ?? this.accent2,
      accent3: accent3 ?? this.accent3,
      accent4: accent4 ?? this.accent4,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      themeColor: Color.lerp(themeColor, other.themeColor, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      accent1: Color.lerp(accent1, other.accent1, t)!,
      accent2: Color.lerp(accent2, other.accent2, t)!,
      accent3: Color.lerp(accent3, other.accent3, t)!,
      accent4: Color.lerp(accent4, other.accent4, t)!,
    );
  }

  static const light = AppThemeExtension(
    themeColor: Color(0xFFF89D27),
    primary: Color(0xFFF89D27),
    secondary: Color(0xFF1A1F24),
    success: Color(0xFF04A24C),
    warning: Color(0xFFFCDC0C),
    error: Color(0xFFFF3B30),
    info: Color(0xFF1AD1DB),
    background: Color(0xFFF6F6F6),
    surface: Color(0xFFFFFFFF),
    accent1: Color(0xFFFF7E42),
    accent2: Color(0xFF3B93FF),
    accent3: Color(0xFFFFB302),
    accent4: Color(0xFF4B39EF),
  );

  static const dark = AppThemeExtension(
    themeColor: Color(0xFFF89D27),
    primary: Color(0xFFF89D27),
    secondary: Color(0xFF1A1F24),
    success: Color(0xFF04A24C),
    warning: Color(0xFFFCDC0C),
    error: Color(0xFFFF3B30),
    info: Color(0xFF1AD1DB),
    background: Color(0xFF1A1F24),
    surface: Color(0xFF111417),
    accent1: Color(0xFFFF7E42),
    accent2: Color(0xFF3B93FF),
    accent3: Color(0xFFFFB302),
    accent4: Color(0xFF4B39EF),
  );
}
