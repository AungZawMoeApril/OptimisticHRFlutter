import 'dart:convert';
import 'package:hr_optimistic/core/theme/app_theme_extension.dart';
import '../core/widgets/app_widgets.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/card_time_attendance/card_time_attendance_widget.dart';
import '../core/widgets/app_icon_button.dart';
import 'package:flutter/material.dart';
import '../core/utils/app_utils.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:hr_app/core/utils/custom_functions.dart' as functions;
import '/app_state.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TimeAttendanceWidget extends StatefulWidget {
  const TimeAttendanceWidget({super.key});

  static String routeName = 'TimeAttendance';
  static String routePath = '/timeAttendance';

  @override
  State<TimeAttendanceWidget> createState() => _TimeAttendanceWidgetState();
}

class _TimeAttendanceWidgetState extends State<TimeAttendanceWidget> {
  ApiCallResponse? apiResultCalendarList;
  List<dynamic> calendarList = [];
  List<dynamic> testijson = [];
  
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadTimeAttendance();
  }

  Future<void> _loadTimeAttendance() async {
    apiResultCalendarList = await MainGroup.getTimeAttendanceListMobileCall.call(
      employeeID: AppState().employeeID,
      companyID: AppState().companyID,
      token: AppState().token,
    );

    if ((apiResultCalendarList?.succeeded ?? true)) {
      setState(() {
        AppState().CalendarList = MainGroup.getTimeAttendanceListMobileCall
            .timeAttendanceList(
              (apiResultCalendarList?.jsonBody ?? ''),
            )!
            .toList()
            .cast<dynamic>();
        calendarList = AppState().CalendarList.toList().cast<dynamic>();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
          leading: AppIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.date_range,
              color: Color(0xFFF9B052),
              size: 30.0,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText('3g2t5o4h') /* Time Attendance */,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: GoogleFonts.outfit().fontFamily,
                  color: Theme.of(context).colorScheme.secondaryText,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 14, 0),
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed(TimeAttendanceListWidget.routeName),
                child: Icon(
                  Icons.article_outlined,
                  color: Theme.of(context).colorScheme.secondaryText,
                  size: 30.0,
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 400.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFF2E3),
                    ),
                    child: custom_widgets.CustomCalendarWidget(
                      width: double.infinity,
                      height: 400.0,
                      calendarList: AppState().CalendarList,
                      onSelectedDate: (selectedDateTime) {
                        if (selectedDateTime != null) {
                          setState(() {
                            testijson = selectedDateTime.toList().cast<dynamic>();
                          });
                        }
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, -1.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 15),
                    child: Text(
                      functions.changeTimeEntriesDateFormate(
                          AppState().selectedDate) ?? '18 Feb 2025',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: GoogleFonts.readexPro().fontFamily,
                            color: Color(0xFFF9B052),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    final selectedshow = testijson;
                    
                    return RefreshIndicator(
                      onRefresh: _loadTimeAttendance,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: selectedshow.length,
                        itemBuilder: (context, index) {
                          final item = selectedshow[index];
                          final data = jsonDecode(item);
                          return CardTimeAttendanceWidget(
                            key: Key('attendance_$index'),
                            location: data['clock_In_Location'],
                            checkIn: data['clock_In_Time'],
                            checkOut: data['clock_Out_Time'],
                            checkInAndOuttype: data['remark'],
                            checkInStatus: data['checkIn_Status'],
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}