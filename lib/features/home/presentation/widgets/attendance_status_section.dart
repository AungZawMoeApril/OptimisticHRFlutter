import 'package:flutter/material.dart';
import '../../domain/entities/attendance_status.dart';

class AttendanceStatusSection extends StatelessWidget {
  final AttendanceStatus status;
  final VoidCallback onCheckInOut;
  final bool isLoading;

  const AttendanceStatusSection({
    Key? key,
    required this.status,
    required this.onCheckInOut,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance Status',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            _buildInfoRow('Clock In', status.clockInTime),
            _buildInfoRow('Clock Out', status.clockOutTime),
            _buildInfoRow('Shift Start', status.shiftStartTime),
            _buildInfoRow('Shift End', status.shiftEndTime),
            _buildInfoRow('Time Type', status.timeType),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: status.canCheckIn ? onCheckInOut : null,
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        status.clockInTime == '-' ? 'Clock In' : 'Clock Out',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}