import '../entities/check_in_record.dart';
import '../repositories/check_in_out_repository.dart';

class CheckInUseCase {
  final CheckInOutRepository _repository;

  CheckInUseCase(this._repository);

  Future<CheckInRecord> execute({
    required String employeeId,
    required String location,
    required double latitude,
    required double longitude,
    String? notes,
  }) {
    return _repository.checkIn(
      employeeId: employeeId,
      location: location,
      latitude: latitude,
      longitude: longitude,
      notes: notes,
    );
  }
}

class CheckOutUseCase {
  final CheckInOutRepository _repository;

  CheckOutUseCase(this._repository);

  Future<CheckInRecord> execute({
    required String recordId,
    required String location,
    required double latitude,
    required double longitude,
    String? notes,
  }) {
    return _repository.checkOut(
      recordId: recordId,
      location: location,
      latitude: latitude,
      longitude: longitude,
      notes: notes,
    );
  }
}

class GetAttendanceHistoryUseCase {
  final CheckInOutRepository _repository;

  GetAttendanceHistoryUseCase(this._repository);

  Future<List<CheckInRecord>> execute({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _repository.getAttendanceHistory(
      employeeId: employeeId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

class GetCurrentDayRecordUseCase {
  final CheckInOutRepository _repository;

  GetCurrentDayRecordUseCase(this._repository);

  Future<CheckInRecord?> execute(String employeeId) {
    return _repository.getCurrentDayRecord(employeeId);
  }
}

class GetAttendanceStatsUseCase {
  final CheckInOutRepository _repository;

  GetAttendanceStatsUseCase(this._repository);

  Future<AttendanceStats> execute({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _repository.getAttendanceStats(
      employeeId: employeeId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}