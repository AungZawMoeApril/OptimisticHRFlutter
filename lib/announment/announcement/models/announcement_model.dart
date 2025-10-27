import 'package:h_r_optimistic_mobile/features/announcement/domain/entities/announcement.dart';

class AnnouncementModel extends Announcement {
  const AnnouncementModel({
    required String id,
    required String title,
    required String detail,
    required String image,
    required String name,
    required DateTime date,
    required bool isRead,
  }) : super(
          id: id,
          title: title,
          detail: detail,
          image: image,
          name: name,
          date: date,
          isRead: isRead,
        );

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['announcement_ID'].toString(),
      title: json['announcement_Title'] ?? '',
      detail: json['announcement_Detail'] ?? '',
      image: json['announcement_Image'] ?? '',
      name: json['name'] ?? '',
      date: DateTime.tryParse(json['create_Date'] ?? '') ?? DateTime.now(),
      isRead: json['is_Read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'announcement_ID': id,
      'announcement_Title': title,
      'announcement_Detail': detail,
      'announcement_Image': image,
      'name': name,
      'create_Date': date.toIso8601String(),
      'is_Read': isRead,
    };
  }

  AnnouncementModel copyWith({
    String? id,
    String? title,
    String? detail,
    String? image,
    String? name,
    DateTime? date,
    bool? isRead,
  }) {
    return AnnouncementModel(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      image: image ?? this.image,
      name: name ?? this.name,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
    );
  }
}