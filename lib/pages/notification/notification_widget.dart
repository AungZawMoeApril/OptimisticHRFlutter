import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app_state.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  static String routeName = 'Notification';
  static String routePath = '/notification';

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<dynamic> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    if (isLoading || !mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      // TODO: Implement notification loading logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      
      if (!mounted) return;
      
      setState(() {
        // TODO: Update notifications with actual data
        notifications = [];
      });
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading notifications: ${e.toString()}'),
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
          'Notifications',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontFamily: GoogleFonts.outfit().fontFamily,
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22.0,
              ),
        ),
        actions: [
          if (notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () {
                // TODO: Implement clear all notifications
              },
              tooltip: 'Clear all notifications',
            ),
        ],
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadNotifications,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : notifications.isEmpty
                  ? Center(
                      child: Text(
                        'No notifications',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        // TODO: Implement notification item widget
                        return Card(
                          child: ListTile(
                            title: Text('Notification Title'),
                            subtitle: Text('Notification Message'),
                            trailing: Text('Time'),
                            onTap: () {
                              // TODO: Handle notification tap
                            },
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}