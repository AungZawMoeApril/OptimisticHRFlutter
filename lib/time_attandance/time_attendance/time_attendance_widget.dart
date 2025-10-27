import 'dart:convert';
import '/backend/api_requests/api_calls.dart';
import '/components/card_time_attendance/card_time_attendance_widget.dart';
import 'package:flutter/material.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/app_state.dart';
import '/time_attandance/time_attendance_list/time_attendance_list_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
  List<dynamic> selectedDateEntries = [];
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadTimeAttendance();
  }

  Future<void> _loadTimeAttendance() async {
    if (isLoading || !mounted) return;
    
    setState(() {
      isLoading = true;
    });

    try {
      final appState = Provider.of<AppState>(context, listen: false);
      
      // Validate required parameters
      if (appState.employeeID <= 0 || appState.companyID <= 0 || appState.token.isEmpty) {
        throw Exception('Invalid authentication parameters');
      }

      apiResultCalendarList = await MainGroup.getTimeAttendanceListMobileCall.call(
        employeeID: appState.employeeID,
        companyID: appState.companyID,
        token: appState.token,
      );

      if (!mounted) return;

      if (apiResultCalendarList?.succeeded ?? false) {
        final timeAttendanceList = MainGroup.getTimeAttendanceListMobileCall
            .timeAttendanceList(
              (apiResultCalendarList?.jsonBody ?? ''),
            );
            
        if (timeAttendanceList != null) {
          if (!mounted) return;
          
          setState(() {
            appState.calendarList = timeAttendanceList.toList();
            calendarList = appState.calendarList;
            
            // Reset selected date entries if the date matches current selection
            if (selectedDateEntries.isNotEmpty) {
              try {
                final firstEntry = jsonDecode(selectedDateEntries.first);
                final dateStr = firstEntry['date'] ?? firstEntry['clock_In_Time'];
                if (dateStr != null) {
                  final entryDate = DateFormat("yyyy-MM-dd").parse(dateStr);
                  if (entryDate.isAtSameMomentAs(selectedDate)) {
                    // Refresh the entries for the selected date
                    final matchingEntries = timeAttendanceList
                        .where((entry) {
                          final entryData = jsonDecode(entry);
                          final entryDateStr = entryData['date'] ?? entryData['clock_In_Time'];
                          if (entryDateStr == null) return false;
                          try {
                            final date = DateFormat("yyyy-MM-dd").parse(entryDateStr);
                            return date.isAtSameMomentAs(selectedDate);
                          } catch (_) {
                            return false;
                          }
                        })
                        .toList();
                    selectedDateEntries = matchingEntries;
                  }
                }
              } catch (_) {
                // If there's any error parsing dates, ignore the refresh
              }
            }
          });
        }
      } else {
        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load attendance data. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
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
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.date_range,
              color: Color(0xFFF9B052),
              size: 30.0,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
          title: Text(
            'Time Attendance',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: GoogleFonts.outfit().fontFamily,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 14, 0),
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                  context, 
                  TimeAttendanceListWidget.routePath,
                ),
                child: Icon(
                  Icons.article_outlined,
                  color: Theme.of(context).colorScheme.onBackground,
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 400.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF2E3),
                    ),
                    child: custom_widgets.CustomCalendarWidget(
                      width: double.infinity,
                      height: 400.0,
                      calendarList: appState.calendarList,
                      onSelectedDate: (selectedDateTime) {
                        if (selectedDateTime != null) {
                          setState(() {
                            selectedDateEntries = selectedDateTime.toList().cast<dynamic>();
                            if (selectedDateEntries.isNotEmpty) {
                              // Parse the first entry to get the date
                              final firstEntry = jsonDecode(selectedDateEntries.first);
                              final dateStr = firstEntry['date'] ?? firstEntry['clock_In_Time'];
                              if (dateStr != null) {
                                selectedDate = DateFormat("yyyy-MM-dd").parse(dateStr);
                              }
                            }
                          });
                        }
                        return Future.value();
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-1.0, -1.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 15, 0, 15),
                    child: Text(
                      DateFormat('dd MMM yyyy').format(selectedDate),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: GoogleFonts.readexPro().fontFamily,
                            color: const Color(0xFFF9B052),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                if (isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else
                  RefreshIndicator(
                    onRefresh: _loadTimeAttendance,
                    child: selectedDateEntries.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'No attendance records for this date',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height - 550, // Adjust based on your layout
                            minHeight: 100,
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: selectedDateEntries.length,
                            itemBuilder: (context, index) {
                              final item = selectedDateEntries[index];
                              Map<String, dynamic> data;
                              try {
                                data = jsonDecode(item);
                              } catch (e) {
                                print('Error decoding JSON at index $index: $e');
                                return const SizedBox.shrink();
                              }
                              return CardTimeAttendanceWidget(
                                key: Key('attendance_$index'),
                                location: data['clock_In_Location'] ?? '',
                                checkIn: data['clock_In_Time'] ?? '',
                                checkOut: data['clock_Out_Time'] ?? '',
                                checkInAndOuttype: data['remark'] ?? '',
                                checkInStatus: data['checkIn_Status'] ?? '',
                              );
                            },
                          ),
                        ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}