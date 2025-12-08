import 'package:flutter/material.dart';
import 'app_localizations.dart';

/// Compatibility shim for legacy FlutterFlow localization code
/// This wraps AppLocalizations to maintain backward compatibility
class FFLocalizations {
  final AppLocalizations _appLocalizations;

  FFLocalizations._(this._appLocalizations);

  static FFLocalizations of(BuildContext context) {
    final appLoc = AppLocalizations.of(context);
    return FFLocalizations._(appLoc);
  }

  String get languageCode => _appLocalizations.locale.languageCode;

  String getText(String key, {String? fallback}) {
    // Map common text keys to AppLocalizations methods
    switch (key) {
      // Auth
      case 'login':
        return _appLocalizations.login;
      case 'username':
        return _appLocalizations.username;
      case 'password':
        return _appLocalizations.password;
      case 'forgotPassword':
        return _appLocalizations.forgotPassword;
      case 'loginError':
        return _appLocalizations.loginError;

      // Check In/Out
      case 'checkIn':
        return _appLocalizations.checkIn;
      case 'checkOut':
        return _appLocalizations.checkOut;
      case 'location':
        return _appLocalizations.location;
      case 'workLocation':
        return _appLocalizations.workLocation;
      case 'forgotCheckIn':
        return _appLocalizations.forgotCheckIn;
      case 'offSite':
        return _appLocalizations.offSite;
      case 'details':
        return _appLocalizations.details;
      case 'takePhoto':
        return _appLocalizations.takePhoto;
      case 'locationOutOfRange':
        return _appLocalizations.locationOutOfRange;

      // General
      case 'loading':
        return _appLocalizations.loading;
      case 'error':
        return _appLocalizations.error;
      case 'success':
        return _appLocalizations.success;
      case 'retry':
        return _appLocalizations.retry;
      case 'cancel':
        return _appLocalizations.cancel;
      case 'save':
        return _appLocalizations.save;
      case 'ok':
        return _appLocalizations.ok;

      default:
        return fallback ?? key;
    }
  }
}
