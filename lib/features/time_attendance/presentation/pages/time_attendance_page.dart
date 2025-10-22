import 'package:flutter/material.dart';
import 'package:h_r_optimistic_mobile/core/presentation/base/base_view.dart';
import 'package:h_r_optimistic_mobile/core/presentation/widgets/loading_overlay.dart';
import 'package:h_r_optimistic_mobile/features/time_attendance/presentation/viewmodels/time_attendance_viewmodel.dart';
import 'package:get_it/get_it.dart';

class TimeAttendancePage extends StatelessWidget {
  const TimeAttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<TimeAttendanceViewModel>(
      viewModelBuilder: () => GetIt.I<TimeAttendanceViewModel>(),
      onModelReady: (model) async {
        await model.getCurrentLocation();
        await model.loadTodayAttendance('currentUserId'); // TODO: Get from auth
      },
      builder: (context, model, child) {
        return LoadingOverlay(
          isLoading: model.isBusy,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Time Attendance'),
              centerTitle: true,
            ),
            body: model.errorMessage != null
                ? Center(
                    child: Text(
                      model.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildAttendanceCard(context, model),
                        const SizedBox(height: 16),
                        _buildActionButtons(context, model),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildAttendanceCard(BuildContext context, TimeAttendanceViewModel model) {
    final attendance = model.todayAttendance;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Attendance',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (attendance != null) ...[
              _buildAttendanceInfo('Check In', attendance.checkIn),
              if (attendance.checkOut != null)
                _buildAttendanceInfo('Check Out', attendance.checkOut!),
              _buildAttendanceInfo('Status', attendance.status),
            ] else
              const Text('No attendance record for today'),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceInfo(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value is DateTime
                ? '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}'
                : value.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, TimeAttendanceViewModel model) {
    final attendance = model.todayAttendance;
    final bool canCheckIn = attendance == null;
    final bool canCheckOut = attendance != null && attendance.checkOut == null;

    return Column(
      children: [
        if (canCheckIn)
          ElevatedButton(
            onPressed: () async {
              await model.pickImage(true);
              if (model.checkInImage != null) {
                await model.checkIn('currentUserId'); // TODO: Get from auth
              }
            },
            child: const Text('Check In'),
          ),
        if (canCheckOut) ...[
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              await model.pickImage(false);
              if (model.checkOutImage != null) {
                await model.checkOut('currentUserId'); // TODO: Get from auth
              }
            },
            child: const Text('Check Out'),
          ),
        ],
      ],
    );
  }
}