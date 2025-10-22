import 'package:flutter/material.dart';
import '../../domain/entities/announcement.dart';

class AnnouncementSection extends StatelessWidget {
  final List<Announcement> announcements;

  const AnnouncementSection({
    Key? key,
    required this.announcements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Announcements',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${announcements.length} items',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final announcement = announcements[index];
                return ListTile(
                  title: Text(announcement.title),
                  subtitle: Text(announcement.description),
                  onTap: () {
                    // Handle announcement tap
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}