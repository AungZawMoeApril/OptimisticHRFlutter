import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:h_r_optimistic_mobile/features/announcement/domain/entities/announcement.dart';

class AnnouncementList extends StatelessWidget {
  final List<Announcement> announcements;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRefresh;
  final Function(String)? onAnnouncementTap;

  const AnnouncementList({
    Key? key,
    required this.announcements,
    this.isLoading = false,
    this.error,
    this.onRefresh,
    this.onAnnouncementTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error!,
              style: GoogleFonts.outfit(color: theme.colorScheme.error),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (onRefresh != null)
              ElevatedButton(
                onPressed: onRefresh,
                child: const Text('Retry'),
              ),
          ],
        ),
      );
    }

    Widget content = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Announcements',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/announcements'),
                  child: Text(
                    'View All',
                    style: GoogleFonts.outfit(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (announcements.isEmpty)
              Center(
                child: Text(
                  'No announcements',
                  style: GoogleFonts.outfit(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  final announcement = announcements[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onTap: () {
                        if (onAnnouncementTap != null) {
                          onAnnouncementTap!(announcement.id);
                        } else {
                          Navigator.pushNamed(
                            context,
                            '/announcement',
                            arguments: announcement,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (announcement.imageUrl != null && announcement.imageUrl!.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: announcement.imageUrl!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: theme.colorScheme.surfaceVariant,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    color: theme.colorScheme.surfaceVariant,
                                    child: Icon(
                                      Icons.error_outline,
                                      color: theme.colorScheme.error,
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    announcement.title,
                                    style: GoogleFonts.outfit(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: !announcement.isRead
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurface,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    announcement.description,
                                    style: GoogleFonts.outfit(
                                      color: theme.colorScheme.onSurfaceVariant,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    DateFormat('MMM d, yyyy').format(announcement.createdAt),
                                    style: GoogleFonts.outfit(
                                      fontSize: 12,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );

    if (onRefresh != null) {
      content = RefreshIndicator(
        onRefresh: () async => onRefresh!(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: content,
        ),
      );
    }

    return content;
  }
}