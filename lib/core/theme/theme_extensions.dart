import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get secondaryBackground => background;
  Color get secondaryText => onSurfaceVariant;
  Color get primaryText => onSurface;
}

extension ThemeExtension on ThemeData {
  Color get themeColor => colorScheme.primary;
  Color get info => colorScheme.background;
  Color get alternate => colorScheme.surfaceVariant;

  TextStyle get headlineMedium => textTheme.headlineMedium?.copyWith(
        fontFamily: GoogleFonts.outfit().fontFamily,
        fontWeight: FontWeight.w500,
      ) ?? const TextStyle();

  TextStyle get bodyMedium => textTheme.bodyMedium?.copyWith(
        fontFamily: GoogleFonts.readexPro().fontFamily,
        fontWeight: FontWeight.w400,
      ) ?? const TextStyle();

  TextStyle get titleSmall => textTheme.titleSmall?.copyWith(
        fontFamily: GoogleFonts.readexPro().fontFamily,
        fontWeight: FontWeight.w500,
      ) ?? const TextStyle();
}

extension CustomTextStyle on TextStyle {
  TextStyle get overrideWithPrimaryColor => copyWith(color: const Color(0xFFF89D27));
  FontWeight get fontWeight => FontWeight.w400;
  FontStyle get fontStyle => FontStyle.normal;
}