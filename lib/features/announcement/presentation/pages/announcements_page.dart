import 'package:flutter/material.dart';

/// Stub page for Announcements - flutter_bloc not available
class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
      ),
      body: const Center(
        child: Text('Announcements feature requires flutter_bloc package'),
      ),
    );
  }
}
