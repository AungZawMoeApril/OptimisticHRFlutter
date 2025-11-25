import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/personal_info.dart';
import '../providers/home_provider.dart';
import '/core/theme/app_colors.dart';

class PersonalInfoSection extends StatelessWidget {
  const PersonalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        final personalInfo = provider.personalInfo;

        if (personalInfo == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Name Section  
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                child: Text(
                  _buildDisplayName(personalInfo),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontFamily: GoogleFonts.readexPro().fontFamily,
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                  ),
                ),
              ),

              // Department Section
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                child: Text(
                  personalInfo.departmentName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontFamily: GoogleFonts.readexPro().fontFamily,
                    color: AppColors.greyTitle,
                    fontSize: 12.0,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _buildDisplayName(PersonalInfo info) {
    return '${info.prefix} ${info.nickname}'.trim();
  }
}
