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

// Leave management functions
double leaveBalanceDayFunction(dynamic leaveData, [dynamic leaveType]) {
  try {
    if (leaveData == null) return 0.0;
    
    // If leaveData is a list, find the item matching the leaveType
    if (leaveData is List) {
      if (leaveType == null) return 0.0;
      final leaveTypeStr = leaveType.toString();
      final item = leaveData.firstWhere(
        (element) => element is Map && 
            (element['leaveTypeId']?.toString() == leaveTypeStr ||
             element['timeOffID']?.toString() == leaveTypeStr ||
             element['id']?.toString() == leaveTypeStr),
        orElse: () => null,
      );
      if (item != null && item is Map) {
        return (item['balanceDays'] as num?)?.toDouble() ?? 0.0;
      }
      return 0.0;
    }
    
    // If leaveData is a map, just return the balance
    if (leaveData is Map) {
      return (leaveData['balanceDays'] as num?)?.toDouble() ?? 0.0;
    }
    return 0.0;
  } catch (e) {
    return 0.0;
  }
}

double leaveAvailableDayFunction(dynamic leaveData, [dynamic leaveType]) {
  try {
    if (leaveData == null) return 0.0;
    
    // If leaveData is a list, find the item matching the leaveType
    if (leaveData is List) {
      if (leaveType == null) return 0.0;
      final leaveTypeStr = leaveType.toString();
      final item = leaveData.firstWhere(
        (element) => element is Map && 
            (element['leaveTypeId']?.toString() == leaveTypeStr ||
             element['timeOffID']?.toString() == leaveTypeStr ||
             element['id']?.toString() == leaveTypeStr),
        orElse: () => null,
      );
      if (item != null && item is Map) {
        return (item['availableDays'] as num?)?.toDouble() ?? 0.0;
      }
      return 0.0;
    }
    
    // If leaveData is a map, just return the available days
    if (leaveData is Map) {
      return (leaveData['availableDays'] as num?)?.toDouble() ?? 0.0;
    }
    return 0.0;
  } catch (e) {
    return 0.0;
  }
}

List<String> leaveAttachmentKHAMethod(List<dynamic>? uploadedFileUrls) {
  if (uploadedFileUrls == null || uploadedFileUrls.isEmpty) {
    return [];
  }
  return uploadedFileUrls
      .map((e) => e.toString())
      .where((url) => url.isNotEmpty)
      .toList();
}

String changeDateFormatYearMonthDay(DateTime? date) {
  if (date == null) return '';
  return DateFormat('yyyy-MM-dd').format(date);
}