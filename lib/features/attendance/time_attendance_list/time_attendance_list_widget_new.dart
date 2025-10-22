import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class TimeAttendanceListWidgetViewModel extends BaseViewModel {
  
}

class TimeAttendanceListWidget extends StatelessWidget {
  const TimeAttendanceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TimeAttendanceListWidgetViewModel>(
      viewModelBuilder: () => TimeAttendanceListWidgetViewModel(),
      builder: (context, model, child) {
        return final theme = Theme.of(context);
    
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
    );;
      },
    );
  }
}
