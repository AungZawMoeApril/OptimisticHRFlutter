import 'package:flutter/material.dart';
import '../../domain/entities/check_in_record.dart';

class AttendanceStatsCard extends StatelessWidget {
  final AttendanceStats stats;

  const AttendanceStatsCard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Statistics',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: 'Present',
                    value: stats.presentDays,
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Late',
                    value: stats.lateDays,
                    color: Colors.orange,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Absent',
                    value: stats.absentDays,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: 'Leave',
                    value: stats.leaveDays,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Early Out',
                    value: stats.earlyCheckouts,
                    color: Colors.amber,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Holiday',
                    value: stats.holidays,
                    color: Colors.purple,
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

class _StatItem extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              value.toString(),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}