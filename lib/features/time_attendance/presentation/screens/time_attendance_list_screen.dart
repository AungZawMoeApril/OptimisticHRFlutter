import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/custom_button_tabbar.dart';
import '../providers/time_attendance_provider.dart';
import '../widgets/time_attendance_views.dart';

class TimeAttendanceListScreen extends StatefulWidget {
  const TimeAttendanceListScreen({super.key});

  static const String routeName = '/time-attendance-list';

  @override
  State<TimeAttendanceListScreen> createState() => _TimeAttendanceListScreenState();
}

class _TimeAttendanceListScreenState extends State<TimeAttendanceListScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
    
    // Load data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TimeAttendanceProvider>().fetchRecords();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        leading: CustomIconButton(
          icon: const Icon(Icons.date_range),
          onPressed: () => Navigator.pop(context),
          iconSize: 30,
          showBorder: false,
        ),
        title: Text(
          'Time Attendance',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: 22,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: Icon(
              Icons.article_outlined,
              color: Color(0xFFF9B052),
              size: 30,
            ),
          ),
        ],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomButtonTabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Month View'),
                Tab(text: 'Week View'),
                Tab(text: 'Day View'),
              ],
              labelColor: theme.primaryColor,
              unselectedLabelColor: theme.textTheme.bodyMedium?.color,
            ),
            Expanded(
              child: Consumer<TimeAttendanceProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.primaryColor,
                        ),
                      ),
                    );
                  }

                  if (provider.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            provider.error!,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => provider.fetchRecords(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  return TabBarView(
                    controller: _tabController,
                    children: const [
                      TimeAttendanceMonthView(),
                      TimeAttendanceWeekView(),
                      TimeAttendanceDayView(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}