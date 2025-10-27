import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formatDate(DateTime? date, String format, {String locale = 'en'}) {
    if (date == null) return '';
    return DateFormat(format, locale).format(date);
  }

  static String formatTime(DateTime? time) {
    if (time == null) return '';
    return DateFormat.Hm().format(time);
  }

  static String formatDateTime(DateTime? dateTime, {String format = 'yyyy-MM-dd HH:mm', String locale = 'en'}) {
    if (dateTime == null) return '';
    return DateFormat(format, locale).format(dateTime);
  }

  static DateTime getCurrentTimestamp() {
    return DateTime.now();
  }

  static String calculateOTHour(String? startTime, String? endTime) {
    if (startTime == null || endTime == null) return '00 hr 00 min';
    
    try {
      final start = DateFormat('Hm').parse(startTime);
      final end = DateFormat('Hm').parse(endTime);
      
      final difference = end.difference(start);
      final hours = difference.inHours;
      final minutes = difference.inMinutes % 60;
      
      return '${hours.toString().padLeft(2, '0')} hr ${minutes.toString().padLeft(2, '0')} min';
    } catch (e) {
      return '00 hr 00 min';
    }
  }
}