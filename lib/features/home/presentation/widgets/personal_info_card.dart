import 'package:flutter/material.dart';
import '../../domain/entities/personal_info.dart';
import 'package:hr_app/core/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PersonalInfoCard extends StatelessWidget {
  final PersonalInfo personalInfo;

  const PersonalInfoCard({
    Key? key,
    required this.personalInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: personalInfo.employeeImage.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: personalInfo.employeeImage,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryBackground,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Theme.of(context).colorScheme.secondaryText,
                          ),
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        personalInfo.employeeName,
                        style: Theme.of(context).textTheme.titleMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        personalInfo.department,
                        style: context.textTheme.bodyMedium,
                      ),
                      Text(
                        personalInfo.position,
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Leave Balance: ${personalInfo.totalLeaveRemain} days',
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}