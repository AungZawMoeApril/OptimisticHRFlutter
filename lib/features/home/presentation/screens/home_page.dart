import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../widgets/personal_info_section.dart';
import '../widgets/attendance_status_section.dart';
import '../widgets/announcement_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.error != null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.error!),
                  ElevatedButton(
                    onPressed: () => provider.loadHomeData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    height: 100.0,
                    color: Theme.of(context).primaryColor,
                    child: const Center(
                      child: Text(
                        'HR Optimistic',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Personal Info Section
                  if (provider.personalInfo != null)
                    PersonalInfoSection(
                      personalInfo: provider.personalInfo!,
                    ),

                  // Attendance Status Section
                  if (provider.attendanceStatus != null)
                    AttendanceStatusSection(
                      status: provider.attendanceStatus!,
                      onCheckInOut: () => provider.checkInOrOut(),
                      isLoading: provider.isCheckingInOut,
                    ),

                  // Announcements Section
                  AnnouncementSection(
                    announcements: provider.announcements,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}