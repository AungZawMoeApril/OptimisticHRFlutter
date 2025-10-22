import 'package:flutter/material.dart';

/// Temporary shim for FlutterFlow localizations while migrating
class FFLocalizations {
  final BuildContext context;

  FFLocalizations(this.context);

  static FFLocalizations of(BuildContext context) {
    return FFLocalizations(context);
  }

  String getText(String key) {
    // Add translation lookup logic here
    // For now just return the key
    return key;
  }
  
  String get languageCode => Localizations.localeOf(context).languageCode;
}

/// Extension to handle dateTimeFormat calls
extension DateTimeFormatExt on dynamic {
  String dateTimeFormat(String format, dynamic dateTime, {String? locale}) {
    if (dateTime == null) return '';
    
    final dt = dateTime is DateTime ? dateTime : DateTime.now();
    final formatter = DateFormat(format, locale);
    return formatter.format(dt);
  }
}