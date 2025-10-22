import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/check_in_record.dart';

class AttendanceHistoryList extends StatelessWidget {
  final List<CheckInRecord> records;

  const AttendanceHistoryList({
    super.key,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const Center(
        child: Text('No attendance records found'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: _getStatusIcon(record.status),
            title: Text(
              DateFormat.yMMMd().format(record.checkInTime),
            ),
            subtitle: Text(
              record.isCheckedOut
                  ? 'Check In: ${DateFormat.jm().format(record.checkInTime)}\n'
                      'Check Out: ${DateFormat.jm().format(record.checkOutTime!)}'
                  : 'Check In: ${DateFormat.jm().format(record.checkInTime)}',
            ),
            isThreeLine: record.isCheckedOut,
            trailing: _getStatusChip(context, record.status),
          ),
        );
      },
    );
  }

  Widget _getStatusIcon(String status) {
    IconData icon;
    Color color;

    switch (status.toLowerCase()) {
      case 'present':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'late':
        icon = Icons.warning;
        color = Colors.orange;
        break;
      case 'absent':
        icon = Icons.cancel;
        color = Colors.red;
        break;
      case 'leave':
        icon = Icons.event_busy;
        color = Colors.blue;
        break;
      case 'holiday':
        icon = Icons.celebration;
        color = Colors.purple;
        break;
      default:
        icon = Icons.info;
        color = Colors.grey;
    }

    return Icon(icon, color: color);
  }

  Widget _getStatusChip(BuildContext context, String status) {
    return Chip(
      label: Text(
        status,
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
    );
  }
}