import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Helper class to assist in migrating from FlutterFlow theme to proper Flutter theme
class ThemeMigrationHelper {
  static TextStyle getStyledTextTheme(
    BuildContext context,
    TextStyle? baseStyle, {
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return (baseStyle ?? Theme.of(context).textTheme.bodyMedium ?? const TextStyle()).copyWith(
      fontFamily: GoogleFonts.readexPro().fontFamily,
      color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing ?? 0.0,
    );
  }

  static Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color getSecondaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.background;
  }

  static Color getTextColor(BuildContext context, {bool secondary = false}) {
    return secondary
        ? Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black54
        : Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
  }
}