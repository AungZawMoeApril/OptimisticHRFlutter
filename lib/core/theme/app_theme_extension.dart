import 'package:flutter/material.dart';

// Extensions for FlutterFlow theme compatibility
extension ColorSchemeExtension on ColorScheme {
  Color get primaryText => onSurface;
  Color get secondaryText => onSurfaceVariant;
  Color get primaryBackground => surface;
  Color get secondaryBackground => surfaceContainerHighest;
  Color get alternate => surfaceContainerHigh;
}

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;
}

// FlutterFlow localization stub
class FFLocalizations {
  final Locale locale;

  FFLocalizations(this.locale);

  static FFLocalizations of(BuildContext context) {
    return FFLocalizations(Localizations.localeOf(context));
  }

  String get languageCode => locale.languageCode;

  String getText(String key, [String? fallback]) {
    // Return fallback text from comments or empty string
    // In a real app, this would look up translations
    return fallback ?? '';
  }
}

// FlutterFlow dateTimeFormat helper
String dateTimeFormat(
  String format,
  DateTime? dateTime, {
  String? locale,
}) {
  if (dateTime == null) return '';
  // Simple year format for now
  if (format == 'y') {
    return dateTime.year.toString();
  }
  return dateTime.toString();
}

// FlutterFlow getCurrentTimestamp helper
DateTime get getCurrentTimestamp => DateTime.now();

// Extension to add withoutNulls for Iterable
extension IterableExtension<T> on Iterable<T?> {
  Iterable<T> get withoutNulls => where((e) => e != null).cast<T>();
}

// Extension to add withoutNulls for Map
extension MapExtension<K, V> on Map<K, V?> {
  Map<K, V> get withoutNulls {
    final result = <K, V>{};
    forEach((key, value) {
      if (value != null) {
        result[key] = value;
      }
    });
    return result;
  }
}

// FlutterFlow navigation helpers
enum ParamType {
  int,
  double,
  String,
  bool,
  DateTime,
  JSON,
}

dynamic serializeParam(
  dynamic value,
  ParamType paramType,
) {
  return value;
}

extension NavigationExtension on BuildContext {
  Future<T?> pushNamed<T>(String routeName,
      {Map<String, dynamic>? queryParameters, Object? extra}) {
    // Use Navigator.pushNamed or go_router
    return Navigator.of(this).pushNamed<T>(routeName, arguments: queryParameters);
  }
}

// FlutterFlow TextStyle override extension
extension TextStyleExtension on TextStyle {
  TextStyle override({
    TextStyle? font, // FlutterFlow uses 'font' to pass a complete TextStyle
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? height,
    String? fontFamily,
  }) {
    // If font is provided, merge it first, then apply individual overrides
    final baseStyle = font ?? this;
    return baseStyle.copyWith(
      fontWeight: fontWeight ?? (font != null ? font.fontWeight : this.fontWeight),
      fontStyle: fontStyle ?? (font != null ? font.fontStyle : this.fontStyle),
      color: color,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: fontFamily ?? (font != null ? font.fontFamily : this.fontFamily),
    );
  }

  // Add copyWith that also accepts 'font' parameter for FlutterFlow compatibility
  TextStyle copyWithFont({
    TextStyle? font,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? height,
    String? fontFamily,
  }) {
    return override(
      font: font,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: fontFamily,
    );
  }
}
