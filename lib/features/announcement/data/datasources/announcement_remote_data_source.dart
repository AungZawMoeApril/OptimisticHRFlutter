import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../backend/api_requests/api_calls.dart';
import '../models/announcement_model.dart';

abstract class AnnouncementRemoteDataSource {
  /// Gets the list of announcements from the server.
  Future<List<AnnouncementModel>> getAnnouncements();

  /// Marks an announcement as read.
  Future<void> markAnnouncementAsRead(String announcementId);
}

class AnnouncementRemoteDataSourceImpl implements AnnouncementRemoteDataSource {
  final FlutterSecureStorage storage;

  AnnouncementRemoteDataSourceImpl({
    required this.storage,
  });

  @override
  Future<List<AnnouncementModel>> getAnnouncements() async {
    try {
      final companyId = await storage.read(key: 'company_id');
      final token = await storage.read(key: 'token');

      if (companyId == null || token == null) {
        throw Exception('Authentication required');
      }

      final result = await MainGroup.getCustomerWebCall.call(
        companyID: int.parse(companyId),
        token: token,
      );

      final titles = MainGroup.getCustomerWebCall.announcementTitle(result.jsonBody) ?? [];
      final details = MainGroup.getCustomerWebCall.announcementDetail(result.jsonBody) ?? [];
      final images = MainGroup.getCustomerWebCall.announcementImage(result.jsonBody) ?? [];
      final dates = MainGroup.getCustomerWebCall.announcementCreatedDate(result.jsonBody) ?? [];
      
      if (titles.isEmpty) {
        throw Exception('Failed to load announcements');
      }

      return List.generate(
        titles.length,
        (i) => AnnouncementModel(
          id: '$i',
          title: titles[i],
          detail: details[i],
          image: images[i],
          name: 'Admin', 
          date: DateTime.tryParse(dates[i]) ?? DateTime.now(),
          isRead: false,
        ),
      );
    } catch (e) {
      throw Exception('Failed to load announcements: $e');
    }
  }

  @override
  Future<void> markAnnouncementAsRead(String announcementId) async {
    try {
      final companyId = await storage.read(key: 'company_id');
      final token = await storage.read(key: 'token');

      if (companyId == null || token == null) {
        throw Exception('Authentication required');
      }

      // TODO: Implement mark as read API call when available
      // For now, we'll just mark it as read locally
    } catch (e) {
      throw Exception('Failed to mark announcement as read: $e');
    }
  }
}