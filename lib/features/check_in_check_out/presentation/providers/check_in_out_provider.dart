import 'package:flutter/foundation.dart';
import '../../domain/entities/check_in_record.dart';
import '../../domain/usecases/check_in_out_usecases.dart';

enum CheckInOutStatus {
  initial,
  loading,
  success,
  error,
}

class CheckInOutProvider with ChangeNotifier {
  final CheckInUseCase _checkInUseCase;
  final CheckOutUseCase _checkOutUseCase;
  final GetCurrentDayRecordUseCase _getCurrentDayRecordUseCase;
  final GetAttendanceHistoryUseCase _getAttendanceHistoryUseCase;
  final GetAttendanceStatsUseCase _getAttendanceStatsUseCase;

  CheckInOutStatus _status = CheckInOutStatus.initial;
  String? _error;
  CheckInRecord? _currentDayRecord;
  List<CheckInRecord> _attendanceHistory = [];
  AttendanceStats? _stats;

  CheckInOutProvider({
    required CheckInUseCase checkInUseCase,
    required CheckOutUseCase checkOutUseCase,
    required GetCurrentDayRecordUseCase getCurrentDayRecordUseCase,
    required GetAttendanceHistoryUseCase getAttendanceHistoryUseCase,
    required GetAttendanceStatsUseCase getAttendanceStatsUseCase,
  })  : _checkInUseCase = checkInUseCase,
        _checkOutUseCase = checkOutUseCase,
        _getCurrentDayRecordUseCase = getCurrentDayRecordUseCase,
        _getAttendanceHistoryUseCase = getAttendanceHistoryUseCase,
        _getAttendanceStatsUseCase = getAttendanceStatsUseCase;

  CheckInOutStatus get status => _status;
  String? get error => _error;
  CheckInRecord? get currentDayRecord => _currentDayRecord;
  List<CheckInRecord> get attendanceHistory => _attendanceHistory;
  AttendanceStats? get stats => _stats;
  bool get isCheckedIn => _currentDayRecord != null;
  bool get canCheckOut => isCheckedIn && !_currentDayRecord!.isCheckedOut;

  Future<void> checkIn({
    required String employeeId,
    required String location,
    required double latitude,
    required double longitude,
    String? notes,
  }) async {
    try {
      _status = CheckInOutStatus.loading;
      _error = null;
      notifyListeners();

      _currentDayRecord = await _checkInUseCase.execute(
        employeeId: employeeId,
        location: location,
        latitude: latitude,
        longitude: longitude,
        notes: notes,
      );

      _status = CheckInOutStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = CheckInOutStatus.error;
    }
    notifyListeners();
  }

  Future<void> checkOut({
    required String recordId,
    required String location,
    required double latitude,
    required double longitude,
    String? notes,
  }) async {
    try {
      _status = CheckInOutStatus.loading;
      _error = null;
      notifyListeners();

      _currentDayRecord = await _checkOutUseCase.execute(
        recordId: recordId,
        location: location,
        latitude: latitude,
        longitude: longitude,
        notes: notes,
      );

      _status = CheckInOutStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = CheckInOutStatus.error;
    }
    notifyListeners();
  }

  Future<void> getCurrentDayRecord(String employeeId) async {
    try {
      _status = CheckInOutStatus.loading;
      _error = null;
      notifyListeners();

      _currentDayRecord = await _getCurrentDayRecordUseCase.execute(employeeId);
      _status = CheckInOutStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = CheckInOutStatus.error;
    }
    notifyListeners();
  }

  Future<void> getAttendanceHistory({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      _status = CheckInOutStatus.loading;
      _error = null;
      notifyListeners();

      _attendanceHistory = await _getAttendanceHistoryUseCase.execute(
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
      );

      _status = CheckInOutStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = CheckInOutStatus.error;
    }
    notifyListeners();
  }

  Future<void> getAttendanceStats({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      _status = CheckInOutStatus.loading;
      _error = null;
      notifyListeners();

      _stats = await _getAttendanceStatsUseCase.execute(
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
      );

      _status = CheckInOutStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = CheckInOutStatus.error;
    }
    notifyListeners();
  }
}