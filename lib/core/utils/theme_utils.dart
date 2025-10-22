import 'package:flutter/material.dart';

class StateUtils {
  static void safeSetState(State state, VoidCallback fn) {
    if (state.mounted) {
      state.setState(fn);
    }
  }
}

dynamic getJsonField(
  dynamic response,
  String jsonPath, [
  bool isForList = false,
]) {
  try {
    if (response == null || jsonPath.isEmpty) {
      return null;
    }

    // Split the jsonPath into individual keys
    final keys = jsonPath.split('.');
    dynamic value = response;

    for (final key in keys) {
      if (key.startsWith(r'$')) {
        continue; // Skip root indicator
      }

      if (value == null) {
        return null;
      }

      if (value is List && int.tryParse(key) != null) {
        final index = int.parse(key);
        if (index >= 0 && index < value.length) {
          value = value[index];
        } else {
          return null;
        }
      } else if (value is Map) {
        value = value[key];
      } else {
        return null;
      }
    }

    if (isForList && value is! List) {
      return null;
    }

    return value;
  } catch (e) {
    print('Error getting JSON field: $e');
    return null;
  }
}

ThemeData wrapInMaterialDatePickerTheme(BuildContext context, Widget child,
    {required Color headerBackgroundColor,
    required Color headerForegroundColor,
    required TextStyle headerTextStyle,
    required Color pickerBackgroundColor,
    required Color pickerForegroundColor,
    required Color selectedDateTimeBackgroundColor,
    required Color selectedDateTimeForegroundColor,
    required Color actionButtonForegroundColor,
    required double iconSize}) {
  return Theme(
    data: Theme.of(context).copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: selectedDateTimeBackgroundColor,
            onPrimary: selectedDateTimeForegroundColor,
            surface: pickerBackgroundColor,
            onSurface: pickerForegroundColor,
          ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: actionButtonForegroundColor,
        ),
      ),
    ),
    child: child,
  );
}

ThemeData wrapInMaterialTimePickerTheme(BuildContext context, Widget child,
    {required Color headerBackgroundColor,
    required Color headerForegroundColor,
    required TextStyle headerTextStyle,
    required Color pickerBackgroundColor,
    required Color pickerForegroundColor,
    required Color selectedDateTimeBackgroundColor,
    required Color selectedDateTimeForegroundColor,
    required Color actionButtonForegroundColor,
    required double iconSize}) {
  return Theme(
    data: Theme.of(context).copyWith(
      timePickerTheme: TimePickerThemeData(
        backgroundColor: pickerBackgroundColor,
        dayPeriodTextColor: pickerForegroundColor,
        dayPeriodColor: selectedDateTimeBackgroundColor,
        hourMinuteTextColor: pickerForegroundColor,
        hourMinuteColor: selectedDateTimeBackgroundColor,
        dialHandColor: selectedDateTimeBackgroundColor,
        dialBackgroundColor: pickerBackgroundColor,
        dialTextColor: pickerForegroundColor,
        entryModeIconColor: iconSize > 0 ? headerForegroundColor : null,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: actionButtonForegroundColor,
        ),
      ),
    ),
    child: child,
  );
}