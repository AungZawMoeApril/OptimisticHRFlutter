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

// Get current year for leave requests
int leaveforYearCustomFunction() {
  return DateTime.now().year;
}

// Calculate days left for leave
String getDaysLeftFunction(dynamic leaveData, [dynamic leaveType]) {
  try {
    final balance = leaveBalanceDayFunction(leaveData, leaveType);
    return balance.toStringAsFixed(1);
  } catch (e) {
    return '0.0';
  }
}

// Get current timestamp
DateTime getCurrentTimestamp() {
  return DateTime.now();
}

// Leave status color functions
Color leaveStatusBackgroundColor(String? status) {
  if (status == null) return Colors.grey.shade200;
  
  switch (status.toLowerCase()) {
    case 'approved':
      return Colors.green.shade100;
    case 'pending':
      return Colors.orange.shade100;
    case 'rejected':
    case 'cancelled':
      return Colors.red.shade100;
    default:
      return Colors.grey.shade200;
  }
}

Color leaveStatusTextColor(String? status) {
  if (status == null) return Colors.grey.shade700;
  
  switch (status.toLowerCase()) {
    case 'approved':
      return Colors.green.shade700;
    case 'pending':
      return Colors.orange.shade700;
    case 'rejected':
    case 'cancelled':
      return Colors.red.shade700;
    default:
      return Colors.grey.shade700;
  }
}

// Change leave status text
String changeLeaveStatusPendingFunction(String? status) {
  if (status == null) return 'Unknown';
  
  switch (status.toLowerCase()) {
    case 'approved':
      return 'Approved';
    case 'pending':
      return 'Pending';
    case 'rejected':
      return 'Rejected';
    case 'cancelled':
      return 'Cancelled';
    default:
      return status;
  }
}

// Calculate leave day amount
String leaveDayAmountFunction(String startDate, String endDate, String startTime, String endTime) {
  try {
    if (startDate.isEmpty || endDate.isEmpty) return '0.0 Days';
    
    DateTime? start;
    DateTime? end;
    
    try {
      start = DateTime.parse(startDate);
      end = DateTime.parse(endDate);
    } catch (e) {
      try {
        start = DateFormat('dd/MM/yyyy').parse(startDate);
        end = DateFormat('dd/MM/yyyy').parse(endDate);
      } catch (e2) {
        return '0.0 Days';
      }
    }
    
    // Calculate full days difference
    int daysDiff = end.difference(start).inDays + 1;
    
    // Handle half-day cases with start/end times
    if (startTime.isNotEmpty && endTime.isNotEmpty) {
      if (startTime == '12:00:00' || endTime == '12:00:00') {
        return '${(daysDiff - 0.5).toStringAsFixed(1)} Days';
      }
    }
    
    return '$daysDiff.0 Days';
  } catch (e) {
    return '0.0 Days';
  }
}

// Change date format
String changeDateFormat(String dateStr) {
  try {
    if (dateStr.isEmpty) return '';
    
    // Try parsing common date formats
    DateTime? date;
    try {
      date = DateTime.parse(dateStr);
    } catch (e) {
      // Try other formats
      try {
        date = DateFormat('dd/MM/yyyy').parse(dateStr);
      } catch (e2) {
        return dateStr;
      }
    }
    
    return DateFormat('MMM dd, yyyy').format(date);
  } catch (e) {
    return dateStr;
  }
}

// Change requested date format
String changeRequestedDateFormat(String dateStr) {
  try {
    if (dateStr.isEmpty) return '';
    
    DateTime? date;
    try {
      date = DateTime.parse(dateStr);
    } catch (e) {
      try {
        date = DateFormat('yyyy-MM-dd').parse(dateStr);
      } catch (e2) {
        return dateStr;
      }
    }
    
    return DateFormat('dd MMM yyyy').format(date);
  } catch (e) {
    return dateStr;
  }
}

// Change leave status rejected function
String changeLeaveStatusRejectedFunction(String status) {
  if (status.toLowerCase() == 'rejected' || status.toLowerCase() == 'reject') {
    return 'Rejected';
  } else if (status.toLowerCase() == 'approved' || status.toLowerCase() == 'approve') {
    return 'Approved';
  } else if (status.toLowerCase() == 'pending') {
    return 'Pending';
  } else if (status.toLowerCase() == 'cancelled' || status.toLowerCase() == 'cancel') {
    return 'Cancelled';
  }
  return status;
}

// Attachment count function - accepts up to 3 parameters for FlutterFlow compatibility
int attachmentCountFunction(dynamic attachmentData, [dynamic unused1, dynamic unused2]) {
  try {
    if (attachmentData == null) return 0;
    
    if (attachmentData is List) {
      return attachmentData.length;
    } else if (attachmentData is Map) {
      final attachments = attachmentData['attachments'] ?? attachmentData['files'] ?? [];
      if (attachments is List) {
        return attachments.length;
      }
    }
    
    return 0;
  } catch (e) {
    return 0;
  }
}