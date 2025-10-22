import 'package:flutter/material.dart';
import '../../domain/entities/onsite_entities.dart';

class StatsCard extends StatelessWidget {
  final OnsiteStats stats;

  const StatsCard({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'On-site Statistics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  label: 'Total Requests',
                  value: stats.totalRequests.toString(),
                  icon: Icons.list_alt,
                ),
                _buildStatItem(
                  label: 'Approved',
                  value: stats.approvedRequests.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                _buildStatItem(
                  label: 'Rejected',
                  value: stats.rejectedRequests.toString(),
                  icon: Icons.cancel,
                  color: Colors.red,
                ),
                _buildStatItem(
                  label: 'Pending',
                  value: stats.pendingRequests.toString(),
                  icon: Icons.pending,
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    Color? color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color ?? Colors.blue,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}