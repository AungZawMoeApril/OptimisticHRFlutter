import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app_state.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactStaffWidget extends StatefulWidget {
  const ContactStaffWidget({super.key});

  static String routeName = 'ContactStaff';
  static String routePath = '/contactStaff';

  @override
  State<ContactStaffWidget> createState() => _ContactStaffWidgetState();
}

class _ContactStaffWidgetState extends State<ContactStaffWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<dynamic> staffList = [];

  @override
  void initState() {
    super.initState();
    _loadStaffList();
  }

  Future<void> _loadStaffList() async {
    if (isLoading || !mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      // TODO: Implement staff list loading logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      
      if (!mounted) return;
      
      setState(() {
        // TODO: Update staffList with actual data
        staffList = [];
      });
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading staff list: ${e.toString()}'),
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
    final appState = context.watch<AppState>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: true,
          title: Text(
            'Contact Staff',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: GoogleFonts.outfit().fontFamily,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22.0,
                ),
          ),
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _loadStaffList,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : staffList.isEmpty
                    ? Center(
                        child: Text(
                          'No staff members found',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: staffList.length,
                        itemBuilder: (context, index) {
                          final staff = staffList[index];
                          // TODO: Implement staff list item widget
                          return const Card(
                            child: ListTile(
                              title: Text('Staff Member'),
                              subtitle: Text('Department'),
                              trailing: Icon(Icons.phone),
                            ),
                          );
                        },
                      ),
          ),
        ),
      ),
    );
  }
}