import '../entities/check_in_record.dart';

abstract class CheckInOutRepository {
  Future<CheckInRecord> checkIn({
    required String employeeId,
    required String location,
    required double latitude,
    required double longitude,
    String? notes,
  });

  Future<CheckInRecord> checkOut({
    required String recordId,
    required String location,
    required double latitude,
    required double longitude,
    String? notes,
  });

  Future<List<CheckInRecord>> getAttendanceHistory({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<CheckInRecord?> getCurrentDayRecord(String employeeId);

  Future<AttendanceStats> getAttendanceStats({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  });
}