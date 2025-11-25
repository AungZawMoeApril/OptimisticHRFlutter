import 'package:flutter/material.dart';
import 'card_time_attendance_model.dart';

export 'card_time_attendance_model.dart';

/// Stub widget for CardTimeAttendance
class CardTimeAttendanceWidget extends StatefulWidget {
  const CardTimeAttendanceWidget({
    super.key,
    this.clockInDate,
    this.clockInStatus,
    this.checkInStatus,
    this.checkOutStatus,
  });

  final String? clockInDate;
  final String? clockInStatus;
  final bool? checkInStatus;
  final bool? checkOutStatus;

  @override
  State<CardTimeAttendanceWidget> createState() =>
      _CardTimeAttendanceWidgetState();
}

class _CardTimeAttendanceWidgetState extends State<CardTimeAttendanceWidget> {
  late CardTimeAttendanceModel _model;

  @override
  void initState() {
    super.initState();
    _model = CardTimeAttendanceModel();
    _model.initState(context);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Time Attendance: ${widget.clockInDate ?? "N/A"}'),
      ),
    );
  }
}
