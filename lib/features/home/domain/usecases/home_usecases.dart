import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/home_repository.dart';
import '../entities/personal_info.dart';
import '../entities/announcement.dart';
import '../entities/attendance_status.dart';

class GetPersonalInfo {
  final HomeRepository repository;

  GetPersonalInfo(this.repository);

  Future<Either<Failure, PersonalInfo>> call({
    required String companyId,
    required String employeeId,
    required String token,
  }) async {
    return await repository.getPersonalInfo(companyId, employeeId, token);
  }
}

class GetAttendanceStatus {
  final HomeRepository repository;

  GetAttendanceStatus(this.repository);

  Future<Either<Failure, AttendanceStatus>> call({
    required String companyId,
    required String employeeId,
    required String token,
    required String todayDate,
  }) async {
    return await repository.getAttendanceStatus(companyId, employeeId, token, todayDate);
  }
}

class GetNotificationCount {
  final HomeRepository repository;

  GetNotificationCount(this.repository);

  Future<Either<Failure, int>> call({
    required String companyId,
    required String employeeId,
    required String token,
  }) async {
    return await repository.getNotificationCount(companyId, employeeId, token);
  }
}

class GetAnnouncements {
  final HomeRepository repository;

  GetAnnouncements(this.repository);

  Future<Either<Failure, List<Announcement>>> call({
    required String companyId,
    required String employeeId,
    required String token,
  }) async {
    return await repository.getAnnouncements(companyId, employeeId, token);
  }
}