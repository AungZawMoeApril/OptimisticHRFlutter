import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Compatibility shim for legacy FlutterFlow theme code
/// This wraps Theme to maintain backward compatibility during migration
class FlutterFlowTheme {
  final ThemeData _theme;
  final ColorScheme _colorScheme;

  FlutterFlowTheme._(this._theme, this._colorScheme);

  static FlutterFlowTheme of(BuildContext context) {
    final theme = Theme.of(context);
    return FlutterFlowTheme._(theme, theme.colorScheme);
  }

  // Color properties
  Color get primary => _colorScheme.primary;
  Color get secondary => _colorScheme.secondary;
  Color get tertiary => _colorScheme.tertiary;
  Color get alternate => _colorScheme.surfaceContainerHighest;
  Color get primaryText => _colorScheme.onSurface;
  Color get secondaryText => _colorScheme.onSurfaceVariant;
  Color get primaryBackground => _colorScheme.surface;
  Color get secondaryBackground => _colorScheme.surface;
  Color get accent1 => _colorScheme.primaryContainer;
  Color get accent2 => _colorScheme.secondaryContainer;
  Color get accent3 => _colorScheme.tertiaryContainer;
  Color get accent4 => _colorScheme.errorContainer;
  Color get success => const Color(0xFF249689);
  Color get warning => const Color(0xFFF9CF58);
  Color get error => _colorScheme.error;
  Color get info => _colorScheme.surface;
  Color get themeColor => _colorScheme.primary;

  // Text styles
  TextStyle get displayLarge => _theme.textTheme.displayLarge ?? _defaultTextStyle;
  TextStyle get displayMedium => _theme.textTheme.displayMedium ?? _defaultTextStyle;
  TextStyle get displaySmall => _theme.textTheme.displaySmall ?? _defaultTextStyle;
  TextStyle get headlineLarge => _theme.textTheme.headlineLarge ?? _defaultTextStyle;
  TextStyle get headlineMedium =>
      _theme.textTheme.headlineMedium?.copyWith(
        fontFamily: GoogleFonts.outfit().fontFamily,
        fontWeight: FontWeight.w500,
      ) ??
      _defaultTextStyle;
  TextStyle get headlineSmall => _theme.textTheme.headlineSmall ?? _defaultTextStyle;
  TextStyle get titleLarge => _theme.textTheme.titleLarge ?? _defaultTextStyle;
  TextStyle get titleMedium => _theme.textTheme.titleMedium ?? _defaultTextStyle;
  TextStyle get titleSmall =>
      _theme.textTheme.titleSmall?.copyWith(
        fontFamily: GoogleFonts.readexPro().fontFamily,
        fontWeight: FontWeight.w500,
      ) ??
      _defaultTextStyle;
  TextStyle get bodyLarge => _theme.textTheme.bodyLarge ?? _defaultTextStyle;
  TextStyle get bodyMedium =>
      _theme.textTheme.bodyMedium?.copyWith(
        fontFamily: GoogleFonts.readexPro().fontFamily,
        fontWeight: FontWeight.w400,
      ) ??
      _defaultTextStyle;
  TextStyle get bodySmall => _theme.textTheme.bodySmall ?? _defaultTextStyle;
  TextStyle get labelLarge => _theme.textTheme.labelLarge ?? _defaultTextStyle;
  TextStyle get labelMedium => _theme.textTheme.labelMedium ?? _defaultTextStyle;
  TextStyle get labelSmall => _theme.textTheme.labelSmall ?? _defaultTextStyle;

  static const TextStyle _defaultTextStyle = TextStyle();

  // Font weight and style getters for compatibility
  FontWeight get fontWeight => FontWeight.w400;
  FontStyle get fontStyle => FontStyle.normal;
}

/// Extension for TextStyle override method
extension FlutterFlowTextStyleExtension on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? letterSpacing,
    double? lineHeight,
  }) {
    return copyWith(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      letterSpacing: letterSpacing,
      height: lineHeight,
    );
  }
}
