import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static final LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const supportedLocales = [
    Locale('en', ''), // English
    Locale('my', ''), // Myanmar
    Locale('th', ''), // Thai
    Locale('zh', ''), // Chinese
    Locale('vi', ''), // Vietnamese
  ];

  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  String get appName => Intl.message(
        'HR Optimistic',
        name: 'appName',
        desc: 'The application name',
      );

  String get leaveRequest => Intl.message(
        'Leave Request',
        name: 'leaveRequest',
        desc: 'Leave request title',
      );

  String get editLeaveRequest => Intl.message(
        'Edit Leave Request',
        name: 'editLeaveRequest',
        desc: 'Edit leave request title',
      );

  String get leaveType => Intl.message(
        'Leave Type',
        name: 'leaveType',
        desc: 'Leave type label',
      );

  String get onSiteDetail => Intl.message(
        'On Site Detail',
        name: 'onSiteDetail',
        desc: 'On site detail page title',
      );

  String get createOnSite => Intl.message(
        'Create On Site',
        name: 'createOnSite',
        desc: 'Create on site button',
      );

  String get location => Intl.message(
        'Location',
        name: 'location',
        desc: 'Location label',
      );

  String get checkIn => Intl.message(
        'Check In',
        name: 'checkIn',
        desc: 'Check in button label',
      );
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}