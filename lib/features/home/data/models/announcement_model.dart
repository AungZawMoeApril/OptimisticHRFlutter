import '../../domain/entities/announcement.dart';

class AnnouncementModel extends Announcement {
  AnnouncementModel({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required DateTime date,
    required String url,
  }) : super(
          id: id,
          title: title,
          description: description,
          imageUrl: imageUrl,
          date: date,
          url: url,
        );

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'date': date.toIso8601String(),
      'url': url,
    };
  }
}