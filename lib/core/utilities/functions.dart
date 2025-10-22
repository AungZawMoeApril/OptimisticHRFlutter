import 'package:intl/intl.dart';

String dateFormatToDay() {
  final now = DateTime.now();
  return DateFormat('yyyy-MM-dd').format(now);
}

String? changeCheckInOutTimeFormatFunction(String? time) {
  if (time == null || time.isEmpty || time == '-') return null;
  
  try {
    final inputFormat = DateFormat('HH:mm:ss');
    final outputFormat = DateFormat('HH:mm');
    final dateTime = inputFormat.parse(time);
    return outputFormat.format(dateTime);
  } catch (e) {
    return time;
  }
}