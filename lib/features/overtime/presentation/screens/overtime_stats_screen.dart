import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/overtime_provider.dart';
import '../../../../core/widgets/loading_overlay.dart';
import '../../../../core/widgets/error_view.dart';

class OvertimeStatsScreen extends StatefulWidget {
  final String employeeId;

  const OvertimeStatsScreen({
    Key? key,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<OvertimeStatsScreen> createState() => _OvertimeStatsScreenState();
}

class _OvertimeStatsScreenState extends State<OvertimeStatsScreen> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final provider = context.read<OvertimeProvider>();
    await provider.loadStats(
      employeeId: widget.employeeId,
      startDate: _startDate,
      endDate: _endDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OvertimeProvider>(
      builder: (context, provider, child) {
        return LoadingOverlay(
          isLoading: provider.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Overtime Statistics'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildDateRangeButton(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: provider.error != null
                ? ErrorView(
                    error: provider.error!,
                    onRetry: _loadStats,
                  )
                : provider.stats == null
                    ? const Center(child: Text('No statistics available'))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildStatCards(),
                            const SizedBox(height: 24),
                            _buildRequestsBreakdown(),
                            const SizedBox(height: 24),
                            _buildHoursBreakdown(),
                          ],
                        ),
                      ),
          ),
        );
      },
    );
  }

  Widget _buildDateRangeButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _showDateRangePicker(context),
      icon: const Icon(Icons.date_range),
      label: Text(
        '${_formatDate(_startDate)} - ${_formatDate(_endDate)}',
      ),
    );
  }

  Widget _buildStatCards() {
    final stats = context.read<OvertimeProvider>().stats!;
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Total Hours',
            value: stats.totalHours.toString(),
            icon: Icons.timer,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            title: 'Approved Hours',
            value: stats.approvedHours.toString(),
            icon: Icons.check_circle_outline,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: color),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsBreakdown() {
    final stats = context.read<OvertimeProvider>().stats!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Requests Breakdown',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _buildBreakdownItem(
          label: 'Total Requests',
          value: stats.totalRequests,
          color: Colors.blue,
        ),
        const SizedBox(height: 8),
        _buildBreakdownItem(
          label: 'Approved',
          value: stats.approvedRequests,
          color: Colors.green,
        ),
        const SizedBox(height: 8),
        _buildBreakdownItem(
          label: 'Pending',
          value: stats.pendingRequests,
          color: Colors.orange,
        ),
        const SizedBox(height: 8),
        _buildBreakdownItem(
          label: 'Rejected',
          value: stats.rejectedRequests,
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildHoursBreakdown() {
    final stats = context.read<OvertimeProvider>().stats!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hours Breakdown',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _buildBreakdownItem(
          label: 'Total Hours',
          value: stats.totalHours,
          color: Colors.blue,
          isHours: true,
        ),
        const SizedBox(height: 8),
        _buildBreakdownItem(
          label: 'Approved Hours',
          value: stats.approvedHours,
          color: Colors.green,
          isHours: true,
        ),
        const SizedBox(height: 8),
        _buildBreakdownItem(
          label: 'Pending Hours',
          value: stats.pendingHours,
          color: Colors.orange,
          isHours: true,
        ),
      ],
    );
  }

  Widget _buildBreakdownItem({
    required String label,
    required num value,
    required Color color,
    bool isHours = false,
  }) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
        const Spacer(),
        Text(
          isHours ? '$value hours' : value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Future<void> _showDateRangePicker(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: _startDate,
        end: _endDate,
      ),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _loadStats();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}