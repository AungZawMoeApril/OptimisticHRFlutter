import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../entities/time_attendance_record.dart';
import '../repositories/time_attendance_repository.dart';

class GetTimeAttendanceList {
  final TimeAttendanceRepository repository;

  GetTimeAttendanceList(this.repository);

  Future<Either<Failure, List<TimeAttendanceRecord>>> call(TimeAttendanceParams params) {
    return repository.getTimeAttendanceList(params);
  }
}

class TimeAttendanceParams extends Equatable {
  final String employeeId;
  final DateTime startDate;
  final DateTime endDate;
  final String view; // 'day', 'week', 'month'

  const TimeAttendanceParams({
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.view,
  });

  @override
  List<Object> get props => [employeeId, startDate, endDate, view];
}