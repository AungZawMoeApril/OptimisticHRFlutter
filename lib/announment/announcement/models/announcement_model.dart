import 'package:h_r_optimistic_mobile/features/announcement/domain/entities/announcement.dart';

class AnnouncementModel implements Announcement {
  @override
  final String id;
  @override
  final String title;
  @override
  final String detail;
  @override
  final String image;
  @override
  final String name;
  @override
  final DateTime date;
  @override
  final bool isRead;
  @override
  DateTime get createdAt => date;
  @override
  String get description => detail;
  @override
  String get imageUrl => image;
  @override
  DateTime get updatedAt => date;

  @override
  $AnnouncementCopyWith<Announcement> get copyWith => 
      $AnnouncementCopyWith<Announcement>(this, (object) => object as Announcement);

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.detail,
    required this.image,
    required this.name,
    required this.date,
    required this.isRead,
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

  AnnouncementModel copyWithCustom({
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