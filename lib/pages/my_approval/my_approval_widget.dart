import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app_state.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApprovalWidget extends StatefulWidget {
  const MyApprovalWidget({super.key});

  static String routeName = 'MyApproval';
  static String routePath = '/myApproval';

  @override
  State<MyApprovalWidget> createState() => _MyApprovalWidgetState();
}

class _MyApprovalWidgetState extends State<MyApprovalWidget> with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<dynamic> approvalRequests = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadApprovalRequests();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadApprovalRequests() async {
    if (isLoading || !mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      final appState = Provider.of<AppState>(context, listen: false);
      
      // TODO: Implement approval requests loading logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      
      if (!mounted) return;
      
      setState(() {
        // TODO: Update approvalRequests with actual data
        approvalRequests = [];
      });
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading approval requests: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: true,
        title: Text(
          'My Approvals',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontFamily: GoogleFonts.outfit().fontFamily,
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22.0,
              ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'History'),
          ],
        ),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            // Pending Approvals Tab
            RefreshIndicator(
              onRefresh: _loadApprovalRequests,
              child: _buildApprovalList(isPending: true),
            ),
            // History Tab
            RefreshIndicator(
              onRefresh: _loadApprovalRequests,
              child: _buildApprovalList(isPending: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApprovalList({required bool isPending}) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final filteredRequests = approvalRequests.where(
      (request) => isPending ? request['status'] == 'pending' : request['status'] != 'pending'
    ).toList();

    if (filteredRequests.isEmpty) {
      return Center(
        child: Text(
          isPending ? 'No pending approvals' : 'No approval history',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredRequests.length,
      itemBuilder: (context, index) {
        final request = filteredRequests[index];
        return Card(
          child: ListTile(
            title: Text(request['title'] ?? 'Unknown Request'),
            subtitle: Text(request['description'] ?? ''),
            trailing: Text(request['status'] ?? 'Unknown'),
            onTap: () {
              // TODO: Handle approval request tap
            },
          ),
        );
      },
    );
  }
}