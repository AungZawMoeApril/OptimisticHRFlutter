import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/onsite_provider.dart';
import '../../domain/entities/onsite_entities.dart';
import '../widgets/onsite_list_item.dart';
import '../widgets/stats_card.dart';
import 'onsite_request_form.dart';

class OnsiteScreen extends StatefulWidget {
  const OnsiteScreen({Key? key}) : super(key: key);

  @override
  State<OnsiteScreen> createState() => _OnsiteScreenState();
}

class _OnsiteScreenState extends State<OnsiteScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  final DateTime _endDate = DateTime.now().add(const Duration(days: 30));

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
    final provider = context.read<OnsiteProvider>();
    // TODO: Get employeeId from auth provider
    const String employeeId = 'current_employee_id';

    await Future.wait([
      provider.loadOnsiteRequests(employeeId),
      provider.loadPendingRequests(employeeId: employeeId),
      provider.loadStats(
        employeeId: employeeId,
        startDate: _startDate,
        endDate: _endDate,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On-site Requests'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'My Requests'),
            Tab(text: 'Pending'),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Consumer<OnsiteProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${provider.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadData,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                if (provider.stats != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StatsCard(stats: provider.stats!),
                  ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildRequestsList(provider.onsiteRequests),
                      _buildRequestsList(provider.pendingRequests),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const OnsiteRequestForm(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRequestsList(List<OnsiteRequest> requests) {
    if (requests.isEmpty) {
      return const Center(
        child: Text('No requests found'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: OnsiteListItem(request: requests[index]),
        );
      },
    );
  }
}