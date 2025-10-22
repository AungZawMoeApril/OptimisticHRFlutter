import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/time_attendance_record.dart';
import '../usecases/get_time_attendance_list.dart';

abstract class TimeAttendanceRepository {
  Future<Either<Failure, List<TimeAttendanceRecord>>> getTimeAttendanceList(TimeAttendanceParams params);
}