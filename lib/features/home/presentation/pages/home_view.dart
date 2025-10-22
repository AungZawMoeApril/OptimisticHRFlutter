import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';;
import '../providers/home_provider.dart';
import '../widgets/personal_info_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the HomeProvider
    final provider = Provider.of<HomeProvider>(context, listen: false);
    
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryBackground,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Header with Personal Info
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: PersonalInfoSection(),
                ),
                // TODO: Add other sections (Attendance, Announcements, etc)
              ],
            ),
          ),
        ),
      ),
    );
  }
}