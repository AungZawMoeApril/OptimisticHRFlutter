// Core utility functions migrated from FlutterFlow
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String dateTimeFormat(String format, DateTime? dateTime, {String? locale}) {
  if (dateTime == null) return '';
  
  if (format == 'relative') {
    return formatRelativeDate(dateTime);
  }

  return DateFormat(format, locale).format(dateTime);
}

String formatRelativeDate(DateTime dateTime) {
  final now = DateTime.now();
  final diff = now.difference(dateTime);

  if (diff.inDays > 365) {
    return '${(diff.inDays / 365).floor()} years ago';
  } else if (diff.inDays > 30) {
    return '${(diff.inDays / 30).floor()} months ago';
  } else if (diff.inDays > 0) {
    return '${diff.inDays} days ago';
  } else if (diff.inHours > 0) {
    return '${diff.inHours} hours ago';
  } else if (diff.inMinutes > 0) {
    return '${diff.inMinutes} minutes ago';
  } else {
    return 'Just now';
  }
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final dt = DateTime(
      now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  return DateFormat('HH:mm').format(dt);
}