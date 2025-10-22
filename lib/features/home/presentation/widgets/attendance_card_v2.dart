import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/core/theme/app_theme.dart';
import '../providers/home_provider.dart';

class AttendanceCardV2 extends StatelessWidget {
  const AttendanceCardV2({Key? key}) : super(key: key);

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
                      "Today's Attendance",
                      style: Theme.of(context).textTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (provider.error != null)
                      IconButton(
                        icon: const Icon(Icons.error_outline, color: Colors.red),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(provider.error!),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                  ],
                ),
                if (attendance.timeType.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Shift: ${attendance.shiftStartTime} - ${attendance.shiftEndTime}',
                        style: context.textTheme.bodySmall.copyWith(
                              color: Theme.of(context).colorScheme.secondaryText,
                            ),
                      ),
                    ],
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
                        _buildTimeColumn(
                          context,
                          'Check In',
                          attendance.clockInTime,
                          isCheckIn: true,
                        ),
                        _buildTimeColumn(
                          context,
                          'Check Out',
                          attendance.clockOutTime,
                          isCheckIn: false,
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
                      onPressed: provider.isCheckingInOut 
                          ? null 
                          : () => provider.checkInOrOut(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: provider.isCheckingInOut
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  attendance.clockInTime == '-'
                                      ? Icons.login
                                      : Icons.logout,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  attendance.clockInTime == '-'
                                      ? 'Check In'
                                      : 'Check Out',
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeColumn(
    BuildContext context,
    String label,
    String time, {
    required bool isCheckIn,
  }) {
    final color = time == '-'
        ? Theme.of(context).colorScheme.secondaryText
        : isCheckIn
            ? Colors.green
            : Colors.red;

    return Column(
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              time == '-'
                  ? Icons.schedule
                  : isCheckIn
                      ? Icons.login
                      : Icons.logout,
              size: 16,
              color: color,
            ),
            const SizedBox(width: 4),
            Text(
              time,
              style: FlutterFlowTheme.of(context)
                  .titleMedium
                  .copyWith(color: color),
            ),
          ],
        ),
      ],
    );
  }
}