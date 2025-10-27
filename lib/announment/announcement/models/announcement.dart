import 'package:h_r_optimistic_mobile/features/announcement/domain/entities/announcement.dart';

class AnnouncementModel {
  final String id;
  final String title;
  final String detail;
  final String image;
  final String name;
  final DateTime date;
  final bool isRead;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.detail,
    required this.image,
    required this.name,
    required this.date,
    this.isRead = false,
  });

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

  Announcement toEntity() {
    return Announcement(
      id: id,
      title: title,
      description: detail,
      createdAt: date,
      updatedAt: date,
      imageUrl: image,
      isRead: isRead,
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