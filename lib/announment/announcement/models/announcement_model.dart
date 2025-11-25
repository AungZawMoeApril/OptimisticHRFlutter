// Stub file - original moved to .broken
class AnnouncementModel {
  final String id;
  final String title;
  final String? detail;
  final String? image;
  final String name;
  final DateTime date;

  AnnouncementModel({
    required this.id,
    required this.title,
    this.detail,
    this.image,
    required this.name,
    required this.date,
  });
}
