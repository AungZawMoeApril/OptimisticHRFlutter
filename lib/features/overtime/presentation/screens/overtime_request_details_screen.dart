import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/overtime_provider.dart';
import '../../domain/entities/overtime_entities.dart';
import '../widgets/overtime_type_chip.dart';
import '../../../../core/widgets/loading_overlay.dart';

class OvertimeRequestDetailsScreen extends StatelessWidget {
  final OvertimeRequest request;
  final bool isApprover;

  const OvertimeRequestDetailsScreen({
    Key? key,
    required this.request,
    this.isApprover = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OvertimeProvider>(
      builder: (context, provider, child) {
        return LoadingOverlay(
          isLoading: provider.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: Text('OT-${request.id}'),
              actions: _buildActions(context, provider),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusSection(context),
                  const Divider(height: 32),
                  _buildDetailsSection(context),
                  const Divider(height: 32),
                  _buildReasonSection(context),
                  if (request.approverNote != null) ...[
                    const Divider(height: 32),
                    _buildApproverNoteSection(context),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildActions(BuildContext context, OvertimeProvider provider) {
    if (!isApprover && request.status == OvertimeStatus.pending) {
      return [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'cancel') {
              _showCancelDialog(context);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'cancel',
              child: Text('Cancel Request'),
            ),
          ],
        ),
      ];
    }
    return [];
  }

  Widget _buildStatusSection(BuildContext context) {
    Color color;
    IconData icon;
    String status;

    switch (request.status) {
      case OvertimeStatus.pending:
        color = Colors.orange;
        icon = Icons.pending_outlined;
        status = 'Pending Approval';
        break;
      case OvertimeStatus.approved:
        color = Colors.green;
        icon = Icons.check_circle_outline;
        status = 'Approved';
        break;
      case OvertimeStatus.rejected:
        color = Colors.red;
        icon = Icons.cancel_outlined;
        status = 'Rejected';
        break;
      case OvertimeStatus.cancelled:
        color = Colors.grey;
        icon = Icons.block_outlined;
        status = 'Cancelled';
        break;
    }

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Text(
                status,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Spacer(),
        OvertimeTypeChip(type: request.type),
      ],
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _buildDetailRow(
          context,
          icon: Icons.calendar_today,
          label: 'Date',
          value: _formatDate(request.date),
        ),
        const SizedBox(height: 12),
        _buildDetailRow(
          context,
          icon: Icons.access_time,
          label: 'Time',
          value:
              '${_formatTime(request.startTime)} - ${_formatTime(request.endTime)}',
        ),
        const SizedBox(height: 12),
        _buildDetailRow(
          context,
          icon: Icons.timer,
          label: 'Hours',
          value: '${request.hours} hours',
        ),
      ],
    );
  }

  Widget _buildReasonSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reason',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          request.reason,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildApproverNoteSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          request.status == OvertimeStatus.rejected
              ? 'Rejection Reason'
              : 'Approver Note',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          request.approverNote!,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.grey),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Future<void> _showCancelDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Request'),
        content: const Text('Are you sure you want to cancel this request?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('NO'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('YES'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final provider = context.read<OvertimeProvider>();
      try {
        await provider.cancelRequest(request.id);
        if (context.mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}