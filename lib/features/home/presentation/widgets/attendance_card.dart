import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/core/theme/app_theme.dart';
import '../providers/home_provider.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        final attendance = provider.attendanceStatus;

        if (attendance == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
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
                      'Today's Attendance',
                      style: Theme.of(context).textTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (provider.error != null)
                      IconButton(
                        icon: const Icon(Icons.error_outline, color: Colors.red),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(provider.error!)),
                          );
                        },
                      ),
                  ],
                ),
                if (attendance.timeType.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Shift: ${attendance.shiftStartTime} - ${attendance.shiftEndTime}',
                    style: context.textTheme.bodySmall.copyWith(
                          color: Theme.of(context).colorScheme.secondaryText,
                        ),
                  ),
                ],
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primaryBackground,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Check In',
                          style: context.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          attendance.clockInTime,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Check Out',
                          style: context.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          attendance.clockOutTime,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (attendance.canCheckIn)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: provider.isLoading ? null : provider.checkInOut,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: provider.isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        attendance.clockInTime == '-' ? 'Check In' : 'Check Out',
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .copyWith(color: Colors.white),
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}