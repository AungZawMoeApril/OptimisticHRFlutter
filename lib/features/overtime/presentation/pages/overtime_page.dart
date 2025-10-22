import 'package:flutter/material.dart';
import 'package:h_r_optimistic_mobile/core/presentation/base/base_view.dart';
import 'package:h_r_optimistic_mobile/core/presentation/widgets/loading_overlay.dart';
import '../viewmodels/overtime_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class OvertimePage extends StatelessWidget {
  const OvertimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OvertimeViewModel>(
      viewModelBuilder: () => GetIt.I<OvertimeViewModel>(),
      onModelReady: (model) => model.loadOvertimeRequests('currentUserId'), // TODO: Get from auth
      builder: (context, model, child) {
        return LoadingOverlay(
          isLoading: model.isBusy,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Overtime Requests'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () => _showFilterDialog(context, model),
                ),
              ],
            ),
            body: model.errorMessage != null
                ? Center(
                    child: Text(
                      model.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : _buildBody(context, model),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showCreateDialog(context, model),
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, OvertimeViewModel model) {
    if (model.overtimeRequests.isEmpty) {
      return const Center(
        child: Text('No overtime requests found'),
      );
    }

    return ListView.builder(
      itemCount: model.overtimeRequests.length,
      itemBuilder: (context, index) {
        final request = model.overtimeRequests[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(DateFormat('MMM dd, yyyy').format(request.requestDate)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${DateFormat('HH:mm').format(request.startTime)} - '
                    '${DateFormat('HH:mm').format(request.endTime)}'),
                Text(request.reason),
                Text(
                  request.status,
                  style: TextStyle(
                    color: _getStatusColor(request.status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: request.status == 'PENDING'
                ? PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showEditDialog(context, model, request);
                      } else if (value == 'delete') {
                        _showDeleteConfirmation(context, model, request.id);
                      }
                    },
                  )
                : null,
            onTap: () => _showDetailsDialog(context, request),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return Colors.green;
      case 'REJECTED':
        return Colors.red;
      case 'PENDING':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Future<void> _showFilterDialog(BuildContext context, OvertimeViewModel model) async {
    final DateTime? startDate = await showDatePicker(
      context: context,
      initialDate: model.selectedStartDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (startDate != null) {
      final DateTime? endDate = await showDatePicker(
        context: context,
        initialDate: startDate.add(const Duration(days: 30)),
        firstDate: startDate,
        lastDate: DateTime(2030),
      );

      if (endDate != null) {
        model.updateDateRange(startDate, endDate);
        model.loadOvertimeRequests('currentUserId'); // TODO: Get from auth
      }
    }
  }

  Future<void> _showCreateDialog(BuildContext context, OvertimeViewModel model) async {
    final formKey = GlobalKey<FormState>();
    DateTime? startTime;
    DateTime? endTime;
    String reason = '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Overtime Request'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    startTime = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      time.hour,
                      time.minute,
                    );
                  }
                },
                child: const Text('Select Start Time'),
              ),
              TextButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    endTime = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      time.hour,
                      time.minute,
                    );
                  }
                },
                child: const Text('Select End Time'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Reason'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a reason' : null,
                onSaved: (value) => reason = value ?? '',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                if (startTime != null && endTime != null) {
                  model.createOvertimeRequest(
                    userId: 'currentUserId', // TODO: Get from auth
                    startTime: startTime!,
                    endTime: endTime!,
                    reason: reason,
                  );
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, OvertimeViewModel model, dynamic request) {
    // Similar to create dialog but pre-filled with request data
  }

  void _showDeleteConfirmation(
      BuildContext context, OvertimeViewModel model, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Request'),
        content: const Text('Are you sure you want to delete this request?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              model.deleteOvertimeRequest(id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, dynamic request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Overtime Request Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${DateFormat('MMM dd, yyyy').format(request.requestDate)}'),
            Text('Time: ${DateFormat('HH:mm').format(request.startTime)} - '
                '${DateFormat('HH:mm').format(request.endTime)}'),
            Text('Reason: ${request.reason}'),
            Text('Status: ${request.status}'),
            if (request.approverNote != null)
              Text('Approver Note: ${request.approverNote}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}