import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/onsite_entities.dart';
import '../providers/onsite_provider.dart';

class OnsiteListItem extends StatelessWidget {
  final OnsiteRequest request;

  const OnsiteListItem({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request.type.name.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                _buildStatusChip(request.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${request.location}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Date: ${_formatDateRange(request.startDate, request.endDate)}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Time: ${_formatTimeRange(request.startTime, request.endTime)}',
              style: const TextStyle(fontSize: 14),
            ),
            if (request.reason.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Reason: ${request.reason}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
            if (request.approverNote?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Text(
                'Approver Note: ${request.approverNote}',
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            const SizedBox(height: 16),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(OnsiteStatus status) {
    Color color;
    IconData icon;

    switch (status) {
      case OnsiteStatus.approved:
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case OnsiteStatus.rejected:
        color = Colors.red;
        icon = Icons.cancel;
        break;
      case OnsiteStatus.cancelled:
        color = Colors.grey;
        icon = Icons.block;
        break;
      case OnsiteStatus.pending:
        color = Colors.orange;
        icon = Icons.pending;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            status.name.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    if (request.status != OnsiteStatus.pending) {
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            _showConfirmationDialog(
              context,
              'Cancel Request',
              'Are you sure you want to cancel this on-site request?',
              () => _cancelRequest(context),
            );
          },
          child: const Text('Cancel Request'),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {
            _showConfirmationDialog(
              context,
              'Delete Request',
              'Are you sure you want to delete this on-site request?',
              () => _deleteRequest(context),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Future<void> _cancelRequest(BuildContext context) async {
    final provider = context.read<OnsiteProvider>();
    await provider.cancelRequest(request.id);
  }

  Future<void> _deleteRequest(BuildContext context) async {
    final provider = context.read<OnsiteProvider>();
    await provider.deleteRequest(request.id);
  }

  String _formatDateRange(DateTime start, DateTime end) {
    return start == end
        ? _formatDate(start)
        : '${_formatDate(start)} - ${_formatDate(end)}';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTimeRange(TimeOfDay start, TimeOfDay end) {
    return '${_formatTime(start)} - ${_formatTime(end)}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}