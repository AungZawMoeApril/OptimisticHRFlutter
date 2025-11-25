import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/entities/personal_info.dart';
import '../../domain/entities/announcement.dart';
import '../../domain/entities/attendance_status.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PersonalInfo>> getPersonalInfo(
    String companyId,
    String employeeId,
    String token,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final personalInfo = await remoteDataSource.getPersonalInfo(
          companyId,
          employeeId,
          token,
        );
        return Right(personalInfo);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AttendanceStatus>> getAttendanceStatus(
    String companyId,
    String employeeId,
    String token,
    String todayDate,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final status = await remoteDataSource.getAttendanceStatus(
          companyId,
          employeeId,
          token,
          todayDate,
        );
        return Right(status);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getNotificationCount(
    String companyId,
    String employeeId,
    String token,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final count = await remoteDataSource.getNotificationCount(
          companyId,
          employeeId,
          token,
        );
        return Right(count);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Announcement>>> getAnnouncements(
    String companyId,
    String employeeId,
    String token,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final announcements = await remoteDataSource.getAnnouncements(
          companyId,
          employeeId,
          token,
        );
        return Right(announcements);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateAttendanceStatus(
    String companyId,
    String employeeId,
    String token,
    String timeType,
    bool isCheckIn,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateAttendanceStatus(
          companyId,
          employeeId,
          token,
          timeType,
          isCheckIn,
        );
        return const Right(true);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}