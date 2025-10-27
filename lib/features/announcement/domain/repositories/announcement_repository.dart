import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/announcement.dart';

abstract class AnnouncementRepository {
  /// Gets the list of announcements from the server.
  Future<Either<Failure, List<Announcement>>> getAnnouncements();

  /// Marks an announcement as read.
  Future<Either<Failure, void>> markAnnouncementAsRead(String announcementId);
}