import 'package:flutter/material.dart';

class AnnouncementWebViewWidget extends StatefulWidget {
  final String? announcementMobileViewURL;
  
  const AnnouncementWebViewWidget({
    Key? key,
    this.announcementMobileViewURL,
  }) : super(key: key);

  @override
  State<AnnouncementWebViewWidget> createState() => _AnnouncementWebViewWidgetState();
}

class _AnnouncementWebViewWidgetState extends State<AnnouncementWebViewWidget> {
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
