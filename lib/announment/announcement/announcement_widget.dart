import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:h_r_optimistic_mobile/core/widgets/app_icon_button.dart';
import 'package:h_r_optimistic_mobile/features/announcement/domain/entities/announcement.dart';
import 'package:intl/intl.dart';

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({
    super.key,
    required this.announcement,
  });

  final Announcement announcement;

  static const String routeName = 'Announcement';
  static const String routePath = '/announcement';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: AppIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: FaIcon(
            FontAwesomeIcons.angleLeft,
            color: colorScheme.onSurface,
            size: 30.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Announcement',
          style: GoogleFonts.outfit(
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 1.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (announcement.imageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        announcement.imageUrl!,
                        width: double.infinity,
                        height: 239.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 12.0),
                  child: Text(
                    announcement.title,
                    style: GoogleFonts.readexPro(
                      fontSize: 16.0,
                      color: const Color(0xFF07B7C9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 15.0),
                  child: Text(
                    announcement.description,
                    style: GoogleFonts.readexPro(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 15.0,
                        backgroundImage: AssetImage('assets/images/default_avatar.png'),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Admin',
                              style: GoogleFonts.readexPro(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              DateFormat('dd/MM/yy').format(announcement.createdAt),
                              style: GoogleFonts.readexPro(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}