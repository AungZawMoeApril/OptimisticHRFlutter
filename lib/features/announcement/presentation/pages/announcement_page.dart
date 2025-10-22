import 'package:flutter/material.dart';
import 'package:h_r_optimistic_mobile/core/presentation/base/base_view.dart';
import 'package:h_r_optimistic_mobile/core/presentation/widgets/loading_overlay.dart';
import '../viewmodels/announcement_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AnnouncementViewModel>(
      viewModelBuilder: () => GetIt.I<AnnouncementViewModel>(),
      onModelReady: (model) => model.loadAnnouncements(),
      builder: (context, model, child) {
        return LoadingOverlay(
          isLoading: model.isBusy,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Announcements'),
            ),
            body: model.errorMessage != null
                ? Center(
                    child: Text(
                      model.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : _buildAnnouncementsList(context, model),
          ),
        );
      },
    );
  }

  Widget _buildAnnouncementsList(BuildContext context, AnnouncementViewModel model) {
    if (model.announcements.isEmpty) {
      return const Center(
        child: Text('No announcements available'),
      );
    }

    return ListView.builder(
      itemCount: model.announcements.length,
      itemBuilder: (context, index) {
        final announcement = model.announcements[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: announcement.isRead
                ? null
                : const CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.blue,
                  ),
            title: Text(
              announcement.title,
              style: TextStyle(
                fontWeight: announcement.isRead ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  announcement.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('MMM dd, yyyy HH:mm').format(announcement.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            onTap: () {
              if (!announcement.isRead) {
                model.markAsRead(announcement.id);
              }
              _showAnnouncementDetails(context, announcement);
            },
          ),
        );
      },
    );
  }

  void _showAnnouncementDetails(BuildContext context, dynamic announcement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(announcement.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (announcement.imageUrl != null)
                Image.network(
                  announcement.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              Text(announcement.description),
              const SizedBox(height: 16),
              Text(
                'Posted on: ${DateFormat('MMM dd, yyyy HH:mm').format(announcement.createdAt)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}