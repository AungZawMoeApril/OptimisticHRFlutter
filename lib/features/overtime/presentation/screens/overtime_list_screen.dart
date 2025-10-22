import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/overtime_provider.dart';
import '../../domain/entities/overtime_entities.dart';
import 'overtime_request_form_screen.dart';
import 'overtime_request_details_screen.dart';
import 'overtime_stats_screen.dart';
import '../../../../core/widgets/loading_overlay.dart';
import '../../../../core/widgets/error_view.dart';
import '../widgets/overtime_request_card.dart';

class OvertimeListScreen extends StatefulWidget {
  final String employeeId;
  final bool isApprover;

  const OvertimeListScreen({
    Key? key,
    required this.employeeId,
    this.isApprover = false,
  }) : super(key: key);

  @override
  State<OvertimeListScreen> createState() => _OvertimeListScreenState();
}

class _OvertimeListScreenState extends State<OvertimeListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final provider = context.read<OvertimeProvider>();
    await Future.wait([
      provider.loadOvertimeRequests(widget.employeeId),
      provider.loadPendingRequests(
        employeeId: widget.employeeId,
        isApprover: widget.isApprover,
      ),
      provider.loadStats(
        employeeId: widget.employeeId,
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OvertimeProvider>(
      builder: (context, provider, child) {
        return LoadingOverlay(
          isLoading: provider.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Overtime'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.analytics_outlined),
                  onPressed: () => _navigateToStats(context),
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'All Requests'),
                  Tab(text: 'Pending'),
                ],
              ),
            ),
            body: provider.error != null
                ? ErrorView(
                    error: provider.error!,
                    onRetry: _loadData,
                  )
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildRequestList(
                        provider.overtimeRequests,
                        showApproveReject: widget.isApprover,
                      ),
                      _buildRequestList(
                        provider.pendingRequests,
                        showApproveReject: widget.isApprover,
                      ),
                    ],
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _navigateToCreateRequest(context),
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRequestList(List<OvertimeRequest> requests, {bool showApproveReject = false}) {
    if (requests.isEmpty) {
      return const Center(
        child: Text('No overtime requests found'),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        itemCount: requests.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final request = requests[index];
          return OvertimeRequestCard(
            request: request,
            showApproveReject: showApproveReject,
            onTap: () => _navigateToDetails(context, request),
            onApprove: showApproveReject ? () => _handleApprove(request) : null,
            onReject: showApproveReject ? () => _handleReject(request) : null,
            onCancel: !showApproveReject && request.status == OvertimeStatus.pending
                ? () => _handleCancel(request)
                : null,
          );
        },
      ),
    );
  }

  void _navigateToCreateRequest(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OvertimeRequestFormScreen(
          employeeId: widget.employeeId,
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, OvertimeRequest request) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OvertimeRequestDetailsScreen(
          request: request,
          isApprover: widget.isApprover,
        ),
      ),
    );
  }

  void _navigateToStats(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OvertimeStatsScreen(
          employeeId: widget.employeeId,
        ),
      ),
    );
  }

  Future<void> _handleApprove(OvertimeRequest request) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Approve Request'),
        content: const Text('Are you sure you want to approve this overtime request?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('APPROVE'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await context.read<OvertimeProvider>().updateRequest(
        requestId: request.id,
        status: OvertimeStatus.approved,
      );
    }
  }

  Future<void> _handleReject(OvertimeRequest request) async {
    final note = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Request'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to reject this overtime request?'),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Rejection Reason',
                hintText: 'Enter reason for rejection',
              ),
              maxLines: 3,
              onChanged: (value) => Navigator.pop(context, value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('REJECT'),
          ),
        ],
      ),
    );

    if (note != null) {
      await context.read<OvertimeProvider>().updateRequest(
        requestId: request.id,
        status: OvertimeStatus.rejected,
        approverNote: note,
      );
    }
  }

  Future<void> _handleCancel(OvertimeRequest request) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Request'),
        content: const Text('Are you sure you want to cancel this overtime request?'),
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

    if (confirmed == true) {
      await context.read<OvertimeProvider>().cancelRequest(request.id);
    }
  }
}