import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.freezed.dart';
part 'announcement.g.dart';

@freezed
class Announcement with _$Announcement {
  const factory Announcement({
    required String id,
    required String title,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? imageUrl,
    @Default(false) bool isRead,
  }) = _Announcement;

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      createdAt: DateTime.tryParse(map['createdAt']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updatedAt']?.toString() ?? '') ?? DateTime.now(),
      imageUrl: map['imageUrl']?.toString(),
      isRead: map['isRead'] == true,
    );
  }
}
