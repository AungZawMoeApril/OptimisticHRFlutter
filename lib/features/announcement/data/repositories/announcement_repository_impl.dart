import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:h_r_optimistic_mobile/core/error/failures.dart';
import 'package:h_r_optimistic_mobile/core/network/network_info.dart';
import 'package:h_r_optimistic_mobile/features/announcement/data/datasources/announcement_remote_data_source.dart';
import 'package:h_r_optimistic_mobile/features/announcement/data/models/announcement_model.dart';
import 'package:h_r_optimistic_mobile/features/announcement/domain/entities/announcement.dart';
import 'package:h_r_optimistic_mobile/features/announcement/domain/repositories/announcement_repository.dart';

const String announcementBoxName = 'announcements';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final AnnouncementRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final Box<AnnouncementModel> _announcementsBox;

  AnnouncementRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required Box<AnnouncementModel> announcementsBox,
  }) : _announcementsBox = announcementsBox;

  @override
  Future<Either<Failure, List<Announcement>>> getAnnouncements() async {
    if (await networkInfo.isConnected) {
      try {
        final models = await remoteDataSource.getAnnouncements();
        await _cacheAnnouncements(models);
        final entities = models.map((model) => model.toEntity()).toList();
        return Right(entities);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final cachedAnnouncements = _getCachedAnnouncements();
        return Right(cachedAnnouncements.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> markAnnouncementAsRead(String announcementId) async {
    try {
      // Update local cache
      final announcement = _announcementsBox.values
          .firstWhere((a) => a.id == announcementId);
      
      await _announcementsBox.put(
        announcementId,
        announcement.copyWith(isRead: true),
      );

      // Update remote if online
      if (await networkInfo.isConnected) {
        try {
          await remoteDataSource.markAnnouncementAsRead(announcementId);
        } catch (e) {
          // Log error but don't fail - we can sync later
          print('Failed to mark announcement as read on server: $e');
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<void> _cacheAnnouncements(List<AnnouncementModel> announcements) async {
    // Clear existing cache
    await _announcementsBox.clear();

    // Cache new announcements
    for (var announcement in announcements) {
      await _announcementsBox.put(announcement.id, announcement);
    }
  }

  List<AnnouncementModel> _getCachedAnnouncements() {
    return _announcementsBox.values.toList();
  }
}