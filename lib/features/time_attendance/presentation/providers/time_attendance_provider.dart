import 'package:flutter/foundation.dart';
import '../../domain/entities/time_attendance_record.dart';
import '../../domain/usecases/get_time_attendance_list.dart';

class TimeAttendanceProvider extends ChangeNotifier {
  final GetTimeAttendanceList _getTimeAttendanceList;

  TimeAttendanceProvider(this._getTimeAttendanceList);

  // State
  List<TimeAttendanceRecord> dayRecords = [];
  List<TimeAttendanceRecord> weekRecords = [];
  List<TimeAttendanceRecord> monthRecords = [];
  TimeAttendanceRecord? selectedRecord;
  bool isLoading = false;
  String? error;

  // Selected date range
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String view = 'day'; // 'day', 'week', 'month'

  Future<void> fetchRecords() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _getTimeAttendanceList(
      TimeAttendanceParams(
        employeeId: '123', // TODO: Get from auth provider
        startDate: startDate,
        endDate: endDate,
        view: view,
      ),
    );

    result.fold(
      (failure) {
        error = 'Failed to load records';
        isLoading = false;
        notifyListeners();
      },
      (records) {
        switch (view) {
          case 'day':
            dayRecords = records;
            break;
          case 'week':
            weekRecords = records;
            break;
          case 'month':
            monthRecords = records;
            break;
        }
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void selectRecord(TimeAttendanceRecord record) {
    selectedRecord = record;
    notifyListeners();
  }

  void changeView(String newView) {
    view = newView;
    notifyListeners();
    fetchRecords();
  }

  void setDateRange(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    notifyListeners();
    fetchRecords();
  }

  List<TimeAttendanceRecord> filterWeekRecords(List<TimeAttendanceRecord> records) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return records.where((record) {
      return record.date.isAfter(startOfWeek) && record.date.isBefore(endOfWeek.add(const Duration(days: 1)));
    }).toList();
  }

  List<TimeAttendanceRecord> filterDayRecords(List<TimeAttendanceRecord> records) {
    final now = DateTime.now();
    return records.where((record) {
      return record.date.year == now.year && 
             record.date.month == now.month && 
             record.date.day == now.day;
    }).toList();
  }

  String formatTime(DateTime? time) {
    if (time == null) return '-';
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}