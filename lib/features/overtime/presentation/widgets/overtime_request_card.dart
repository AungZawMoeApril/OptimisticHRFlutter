import 'package:flutter/material.dart';
import '../../domain/entities/overtime_entities.dart';
import 'overtime_type_chip.dart';

class OvertimeRequestCard extends StatelessWidget {
  final OvertimeRequest request;
  final VoidCallback onTap;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final VoidCallback? onCancel;
  final bool showApproveReject;

  const OvertimeRequestCard({
    Key? key,
    required this.request,
    required this.onTap,
    this.onApprove,
    this.onReject,
    this.onCancel,
    this.showApproveReject = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'OT-${request.id}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  _buildStatusChip(context),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${_formatDate(request.date)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Time: ${_formatTime(request.startTime)} - ${_formatTime(request.endTime)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  OvertimeTypeChip(type: request.type),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                request.reason,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (_shouldShowActions) ...[
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: _buildActions(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color color;
    IconData icon;

    switch (request.status) {
      case OvertimeStatus.pending:
        color = Colors.orange;
        icon = Icons.pending_outlined;
        break;
      case OvertimeStatus.approved:
        color = Colors.green;
        icon = Icons.check_circle_outline;
        break;
      case OvertimeStatus.rejected:
        color = Colors.red;
        icon = Icons.cancel_outlined;
        break;
      case OvertimeStatus.cancelled:
        color = Colors.grey;
        icon = Icons.block_outlined;
        break;
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
            request.status.toString().split('.').last.toUpperCase(),
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }

  bool get _shouldShowActions =>
      (showApproveReject && request.status == OvertimeStatus.pending) ||
      (!showApproveReject && request.status == OvertimeStatus.pending && onCancel != null);

  List<Widget> _buildActions() {
    if (showApproveReject && request.status == OvertimeStatus.pending) {
      return [
        TextButton.icon(
          onPressed: onReject,
          icon: const Icon(Icons.close, color: Colors.red),
          label: const Text('REJECT', style: TextStyle(color: Colors.red)),
        ),
        const SizedBox(width: 8),
        TextButton.icon(
          onPressed: onApprove,
          icon: const Icon(Icons.check, color: Colors.green),
          label: const Text('APPROVE', style: TextStyle(color: Colors.green)),
        ),
      ];
    } else if (!showApproveReject && request.status == OvertimeStatus.pending && onCancel != null) {
      return [
        TextButton.icon(
          onPressed: onCancel,
          icon: const Icon(Icons.cancel_outlined),
          label: const Text('CANCEL'),
        ),
      ];
    }
    return [];
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}