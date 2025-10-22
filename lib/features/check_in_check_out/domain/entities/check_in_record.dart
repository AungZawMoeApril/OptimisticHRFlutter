import 'package:equatable/equatable.dart';

class CheckInRecord extends Equatable {
  final String id;
  final String employeeId;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final String location;
  final double latitude;
  final double longitude;
  final String status;
  final String? notes;

  const CheckInRecord({
    required this.id,
    required this.employeeId,
    required this.checkInTime,
    this.checkOutTime,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.status,
    this.notes,
  });

  bool get isCheckedOut => checkOutTime != null;

  @override
  List<Object?> get props => [
        id,
        employeeId,
        checkInTime,
        checkOutTime,
        location,
        latitude,
        longitude,
        status,
        notes,
      ];
}

enum AttendanceStatus {
  present,
  late,
  earlyCheckOut,
  absent,
  onLeave,
  holiday,
}

class AttendanceStats {
  final int totalDays;
  final int presentDays;
  final int lateDays;
  final int earlyCheckouts;
  final int absentDays;
  final int leaveDays;
  final int holidays;

  const AttendanceStats({
    required this.totalDays,
    required this.presentDays,
    required this.lateDays,
    required this.earlyCheckouts,
    required this.absentDays,
    required this.leaveDays,
    required this.holidays,
  });
}