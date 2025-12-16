import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// FlutterFlow model base class
abstract class FlutterFlowModel<T extends Widget> {
  void initState(BuildContext context) {}
  void dispose() {}
}

// Helper function to create models (compatible with BaseViewModel)
T createModel<T>(BuildContext context, T Function() builder) {
  final model = builder();
  return model;
}

// Extension to add safeSetState to State
extension StateExtensions on State {
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(fn);
    }
  }
}

class AppUtils {
  static void safeSetState(VoidCallback fn) {
    // Only call setState if the widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fn();
    });
  }

  static String dateTimeFormat(String format, DateTime? dateTime, {String locale = 'en_US'}) {
    if (dateTime == null) return '';
    if (format == 'relative') {
      return _getRelativeTime(dateTime);
    }
    return DateFormat(format, locale).format(dateTime);
  }

  static String _getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  static void showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
    int durationSeconds = 4,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationSeconds),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  static String formatTimeEntriesDate(String date) {
    try {
      final parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      return DateFormat('E, MMM d, y').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}

// Helper function for providing default values
T valueOrDefault<T>(T? value, T defaultValue) {
  return value ?? defaultValue;
}

// Extension method for validators
extension ValidatorExtension on String? Function(BuildContext, String?) {
  String? Function(String?) asValidator(BuildContext context) {
    return (value) => this(context, value);
  }
}

// List divide extension for adding separators
extension ListDivideExtension<T extends Widget> on List<T> {
  List<T> divide(T separator) {
    if (isEmpty) return [];

    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}
