import 'package:equatable/equatable.dart';

class TimeAttendanceRecord extends Equatable {
  final String id;
  final String employeeId;
  final DateTime date;
  final String status;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final int? totalHours;
  final String? note;

  const TimeAttendanceRecord({
    required this.id,
    required this.employeeId,
    required this.date,
    required this.status,
    this.checkInTime,
    this.checkOutTime,
    this.totalHours,
    this.note,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        date,
        status,
        checkInTime,
        checkOutTime,
        totalHours,
        note,
      ];
}