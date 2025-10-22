import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Create an extension on BuildContext to make it easier to access translations
extension FFLocalizationsContextExtension on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);

  String translate(String key) {
    // Add your translation logic here
    // You may want to use a proper localization system
    return key;
  }
}

class FFLocalizations {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  static String getText(BuildContext context, String key) {
    return key;
  }
}