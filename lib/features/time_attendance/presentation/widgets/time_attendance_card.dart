import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/time_attendance_record.dart';

class TimeAttendanceCard extends StatelessWidget {
  final TimeAttendanceRecord record;
  final VoidCallback? onTap;

  const TimeAttendanceCard({
    Key? key,
    required this.record,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${record.date.day}/${record.date.month}/${record.date.year}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  _buildStatusChip(context),
                ],
              ),
              const SizedBox(height: 8),
              if (record.checkInTime != null) ...[
                _buildTimeRow(context, 'Check In', record.checkInTime!),
                const SizedBox(height: 4),
              ],
              if (record.checkOutTime != null) ...[
                _buildTimeRow(context, 'Check Out', record.checkOutTime!),
                const SizedBox(height: 4),
              ],
              if (record.totalHours != null) ...[
                Text(
                  'Total Hours: ${record.totalHours}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              if (record.note?.isNotEmpty == true) ...[
                const SizedBox(height: 8),
                Text(
                  record.note!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        record.status,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }

  Widget _buildTimeRow(BuildContext context, String label, DateTime time) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Color _getStatusColor(BuildContext context) {
    switch (record.status.toLowerCase()) {
      case 'present':
        return AppColors.success;
      case 'absent':
        return AppColors.error;
      case 'late':
        return AppColors.warning;
      default:
        return Colors.grey;
    }
  }
}