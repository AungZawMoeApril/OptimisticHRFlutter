import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/personal_info.dart';
import '../entities/announcement.dart';
import '../entities/attendance_status.dart';

abstract class HomeRepository {
  Future<Either<Failure, PersonalInfo>> getPersonalInfo(
    String companyId,
    String employeeId,
    String token,
  );

  Future<Either<Failure, AttendanceStatus>> getAttendanceStatus(
    String companyId,
    String employeeId,
    String token,
    String todayDate,
  );

  Future<Either<Failure, int>> getNotificationCount(
    String companyId,
    String employeeId,
    String token,
  );

  Future<Either<Failure, List<Announcement>>> getAnnouncements(
    String companyId,
    String employeeId,
    String token,
  );

  Future<Either<Failure, bool>> updateAttendanceStatus(
    String companyId,
    String employeeId,
    String token,
    String timeType,
    bool isCheckIn,
  );
}