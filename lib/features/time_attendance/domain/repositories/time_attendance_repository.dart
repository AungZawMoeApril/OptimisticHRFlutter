import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_record.dart';
import '../entities/time_attendance_record.dart';
import '../usecases/get_time_attendance_list.dart';

abstract class TimeAttendanceRepository {
  Future<Either<Failure, List<TimeAttendanceRecord>>> getTimeAttendanceList(TimeAttendanceParams params);
  
  Future<Either<Failure, AttendanceRecord>> getTodayAttendance(String userId);
  
  Future<Either<Failure, AttendanceRecord>> checkIn({
    required String userId,
    required String location,
    required double latitude,
    required double longitude,
    String? checkInImage,
  });
  
  Future<Either<Failure, AttendanceRecord>> checkOut({
    required String userId,
    required String location,
    required double latitude,
    required double longitude,
    String? checkOutImage,
  });
}