import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/time_attendance_provider.dart';
import '../widgets/time_attendance_card.dart';

class TimeAttendanceDayView extends StatelessWidget {
  const TimeAttendanceDayView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TimeAttendanceProvider>();
    final records = provider.dayRecords;

    if (records.isEmpty) {
      return Center(
        child: Text(
          'No records found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return TimeAttendanceCard(
          record: record,
          onTap: () => provider.selectRecord(record),
        );
      },
    );
  }
}

class TimeAttendanceWeekView extends StatelessWidget {
  const TimeAttendanceWeekView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TimeAttendanceProvider>();
    final records = provider.weekRecords;

    if (records.isEmpty) {
      return Center(
        child: Text(
          'No records found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return TimeAttendanceCard(
          record: record,
          onTap: () => provider.selectRecord(record),
        );
      },
    );
  }
}

class TimeAttendanceMonthView extends StatelessWidget {
  const TimeAttendanceMonthView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TimeAttendanceProvider>();
    final records = provider.monthRecords;

    if (records.isEmpty) {
      return Center(
        child: Text(
          'No records found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return TimeAttendanceCard(
          record: record,
          onTap: () => provider.selectRecord(record),
        );
      },
    );
  }
}