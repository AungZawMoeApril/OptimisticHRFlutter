import 'package:flutter/material.dart';

/// Stub dialog for announcement search
class SearchAnnouncementsDialog extends StatelessWidget {
  const SearchAnnouncementsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search Announcements'),
      content: const Text('Search feature requires flutter_bloc package'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
  
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const SearchAnnouncementsDialog(),
    );
  }
}
