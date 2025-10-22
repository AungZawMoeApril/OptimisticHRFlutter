import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/app_icon_button.dart';
import '../../../core/widgets/app_button_tabbar.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/api/api_client.dart';
import '../../components/card_time_attendance/card_time_attendance_widget.dart';
import 'time_attendance_list_model.dart';

export 'time_attendance_list_model.dart';

class TimeAttendanceListWidget extends StatefulWidget {
  const TimeAttendanceListWidget({super.key});

  static String routeName = 'TimeAttendanceList';
  static String routePath = '/timeAttendanceList';

  @override
  State<TimeAttendanceListWidget> createState() => _TimeAttendanceListWidgetState();
}

class _TimeAttendanceListWidgetState extends State<TimeAttendanceListWidget>
    with TickerProviderStateMixin {
  late TimeAttendanceListModel _model;
  late TabController _tabController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = TimeAttendanceListModel();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    _model.tabBarController = _tabController;

    _loadTimeAttendanceData();
  }

  Future<void> _loadTimeAttendanceData() async {
    final appState = context.read<AppStateProvider>();
    try {
      final response = await ApiClient().getTimeAttendanceList(
        employeeId: appState.employeeId ?? '',
        companyId: appState.companyId ?? '',
        token: appState.authToken ?? '',
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        setState(() {
          _model.monthViewTimeAttendance = data
              .map((item) => TimeAttendanceList.fromJson(item))
              .toList();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading attendance data: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        automaticallyImplyLeading: false,
        leading: AppIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.date_range,
            color: theme.colorScheme.onSurface,
            size: 30.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Time Attendance',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontSize: 22.0,
            letterSpacing: 0.0,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14.0),
            child: Icon(
              Icons.article_outlined,
              color: Color(0xFFF9B052),
              size: 30.0,
            ),
          ),
        ],
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 1.0),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: const Alignment(0.0, 0),
                        child: AppButtonTabBar(
                          controller: _model.tabBarController!,
                          labelStyle: Theme.of(context).textTheme.titleMedium,
                          labelColor: Colors.white,
                          unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          indicatorColor: Theme.of(context).colorScheme.secondary,
                          tabs: const [
                            Tab(text: 'Last Week'),
                            Tab(text: 'This Week'),
                            Tab(text: 'This Month'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            _buildLastWeekList(),
                            _buildThisWeekList(),
                            _buildMonthList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastWeekList() {
    final now = DateTime.now();
    final lastWeek = now.subtract(const Duration(days: 7));
    final lastWeekAttendance = _model.monthViewTimeAttendance
        .where((e) => e.remark != 'Holiday')
        .where((e) {
          final date = DateFormat('yyyy-MM-dd').parse(e.timeEntryDate);
          return date.isAfter(lastWeek) && date.isBefore(now);
        })
        .toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: lastWeekAttendance.length,
      itemBuilder: (context, index) {
        final item = lastWeekAttendance[index];
        return _buildAttendanceItem(item, index, lastWeekAttendance.length);
      },
    );
  }

  Widget _buildThisWeekList() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final thisWeekAttendance = _model.monthViewTimeAttendance
        .where((e) {
          final date = DateFormat('yyyy-MM-dd').parse(e.timeEntryDate);
          return date.isAfter(weekStart) && date.isBefore(now.add(const Duration(days: 1)));
        })
        .toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: thisWeekAttendance.length,
      itemBuilder: (context, index) {
        final item = thisWeekAttendance[index];
        return _buildAttendanceItem(item, index, thisWeekAttendance.length);
      },
    );
  }

  Widget _buildMonthList() {
    final monthAttendance = _model.monthViewTimeAttendance
      .where((e) => e.remark != 'Holiday')
      .toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: monthAttendance.length,
      itemBuilder: (context, index) {
        final item = monthAttendance[index];
        return _buildAttendanceItem(item, index, monthAttendance.length);
      },
    );
  }

  Widget _buildAttendanceItem(TimeAttendanceList item, int index, int total) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1.0, -1.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
            child: Text(
              AppUtils.formatTimeEntriesDate(item.timeEntryDate),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFF9B052),
              ),
            ),
          ),
        ),
        CardTimeAttendanceWidget(
          key: Key('Key_${index}_of_$total'),
          location: item.clockInLocation,
          checkIn: item.clockInTime,
          checkOut: item.clockOutTime,
          checkInAndOuttype: item.remark,
          checkInStatus: int.tryParse(item.checkInStatus) ?? 0,
        ),
      ],
    );
  }
}
