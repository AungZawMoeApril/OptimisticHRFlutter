class Announcement {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;
  final String url;

  Announcement({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.url,
  });

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['image_url'] ?? '',
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      url: map['url'] ?? '',
    );
  }
}