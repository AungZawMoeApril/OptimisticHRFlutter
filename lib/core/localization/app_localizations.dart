import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('my'), // Myanmar
    Locale('th'), // Thai
    Locale('zh'), // Chinese
  ];

  String get appTitle => 'HR Optimistic';

  // Auth
  String get login => 'Login';
  String get username => 'Username';
  String get password => 'Password';
  String get forgotPassword => 'Forgot Password?';
  String get loginError => 'Invalid username or password';

  // Check In/Out
  String get checkIn => 'Check In';
  String get checkOut => 'Check Out';
  String get location => 'Location';
  String get workLocation => 'Work Location';
  String get forgotCheckIn => 'Forgot Check-in';
  String get offSite => 'Off-site';
  String get details => 'Details';
  String get takePhoto => 'Take a photo*';
  String get locationOutOfRange => 'You are not within the specified range';

  // General
  String get loading => 'Loading...';
  String get error => 'Error';
  String get success => 'Success';
  String get retry => 'Retry';
  String get cancel => 'Cancel';
  String get save => 'Save';
  String get ok => 'OK';

  // Dates and Times
  String formatDate(DateTime date) {
    return DateFormat.yMMMd(locale.languageCode).format(date);
  }

  String formatTime(DateTime time) {
    return DateFormat.Hm(locale.languageCode).format(time);
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'my', 'th', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}