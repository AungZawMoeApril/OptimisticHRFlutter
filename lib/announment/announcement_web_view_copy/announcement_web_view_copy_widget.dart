import 'package:flutter/material.dart';

class AnnouncementWebViewCopyWidget extends StatefulWidget {
  final String? announcementMobileViewURL;

  const AnnouncementWebViewCopyWidget({
    Key? key,
    this.announcementMobileViewURL,
  }) : super(key: key);

  @override
  State<AnnouncementWebViewCopyWidget> createState() => _AnnouncementWebViewCopyWidgetState();
}

class _AnnouncementWebViewCopyWidgetState extends State<AnnouncementWebViewCopyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement'),
      ),
      body: const Center(
        child: Text('Web View (Implementation pending)'),
      ),
    );
  }
}
