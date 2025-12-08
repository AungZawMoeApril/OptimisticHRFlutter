import 'package:flutter/material.dart';

/// Stub for AppLocalizations - flutter_gen not available
class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return AppLocalizations();
  }

  String translate(String key) => key;
}

// Create an extension on BuildContext to make it easier to access translations
extension FFLocalizationsContextExtension on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);

  String translate(String key) => key;
}

class FFLocalizations {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  static String getText(BuildContext context, String key) {
    return key;
  }
}
