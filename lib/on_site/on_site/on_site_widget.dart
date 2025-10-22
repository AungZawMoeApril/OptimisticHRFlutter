import 'package:hr_optimistic/core/theme/app_theme_extension.dart';
import '../core/widgets/app_widgets.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/on_site_detail_list/on_site_detail_list_widget.dart';
import '../core/widgets/app_icon_button.dart';;
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import '../core/widgets/app_button.dart';;
import 'package:hr_app/core/utils/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'on_site_model.dart';
export 'on_site_model.dart';

class OnSiteWidget extends StatefulWidget {
  const OnSiteWidget({super.key});

  static String routeName = 'OnSite';
  static String routePath = '/onSite';

  @override
  State<OnSiteWidget> createState() => _OnSiteWidgetState();
}

class _OnSiteWidgetState extends State<OnSiteWidget>
    with TickerProviderStateMixin {
  late OnSiteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnSiteModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultGetALl =
          await MainGroup.getTimeAttendanceListMobileCall.call(
        employeeID: AppState().employeeID,
        companyID: AppState().companyID,
        token: AppState().token,
      );

      if ((_model.apiResultGetALl?.succeeded ?? true)) {
        _model.onSiteListView = MainGroup.getTimeAttendanceListMobileCall
            .timeAttendanceList(
              (_model.apiResultGetALl?.jsonBody ?? ''),
            )!
            .toList()
            .cast<dynamic>();
        safeSetState(() {});
      }
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return FutureBuilder<ApiCallResponse>(
      future: MainGroup.getTimeAttendanceListMobileCall.call(
        employeeID: AppState().employeeID,
        companyID: AppState().companyID,
        token: AppState().token,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFF6F6F6),
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          );
        }
        final onSiteGetTimeAttendanceListMobileResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF6F6F6),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.secondaryBackground,
              automaticallyImplyLeading: false,
              leading: AppIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: FaIcon(
                  FontAwesomeIcons.angleLeft,
                  color: Theme.of(context).colorScheme.secondaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  AppState().deleteCheckInStatusOnSite();
                  AppState().checkInStatusOnSite = 0;

                  safeSetState(() {});
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                FFLocalizations.of(context).getText(
                  'csrhv0qr' /* On-site */,
                ),
                style: Theme.of(context).textTheme.$1?.copyWith(
                      font: GoogleFonts.outfit(
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
                      ),
                      color: Theme.of(context).colorScheme.secondaryText,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                      fontWeight: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .fontWeight,
                      fontStyle:
                          context.headlineMedium.fontStyle,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: AppButton(
                        onPressed: () async {
                          AppState().checkInStatusOnSite = 3;
                          safeSetState(() {});

                          Navigator.of(context).pushNamed(
                            CheckInOverAllWidget.routeName,
                            queryParameters: {
                              'timeType': serializeParam(
                                AppState().timeType,
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        },
                        text: FFLocalizations.of(context).getText(
                          'zi45w24r' /* Add Checkin On-Site */,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFFF9B052),
                          textStyle:
                              Theme.of(context).textTheme.$1?.copyWith(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 15.0, 0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/history_(1)_1.png',
                            width: 18.0,
                            height: 18.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(5.0, 15.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '1rayouze' /* History */,
                          ),
                          style:
                              Theme.of(context).textTheme.$1?.copyWith(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(0.0, 0),
                          child: FlutterFlowButtonTabBar(
                            useToggleButtonStyle: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                            unselectedLabelStyle: TextStyle(),
                            labelColor:
                                Theme.of(context).colorScheme.primaryText,
                            unselectedLabelColor:
                                Theme.of(context).colorScheme.secondaryText,
                            backgroundColor: Color(0xFFBDBDBD),
                            unselectedBackgroundColor:
                                FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                            borderColor: Theme.of(context).colorScheme.primary,
                            unselectedBorderColor:
                                Theme.of(context).colorScheme.surface,
                            borderWidth: 2.0,
                            borderRadius: 8.0,
                            elevation: 0.0,
                            buttonMargin: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            padding: EdgeInsets.all(4.0),
                            tabs: [
                              Tab(
                                text: FFLocalizations.of(context).getText(
                                  'oy6wmv5j' /* Today */,
                                ),
                              ),
                              Tab(
                                text: FFLocalizations.of(context).getText(
                                  '12gzzphv' /* This Week */,
                                ),
                              ),
                            ],
                            controller: _model.tabBarController,
                            onTap: (i) async {
                              [() async {}, () async {}][i]();
                            },
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _model.tabBarController,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      final todayView = functions
                                              .filterEntriesForDay(
                                                  _model.onSiteListView
                                                      .where((e) =>
                                                          '3' ==
                                                          getJsonField(
                                                            e,
                                                            r'''$.checkIn_Status''',
                                                          ).toString())
                                                      .toList())
                                              ?.toList() ??
                                          [];

                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: todayView.length,
                                        itemBuilder: (context, todayViewIndex) {
                                          final todayViewItem =
                                              todayView[todayViewIndex];
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 10.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      functions
                                                          .changeTimeEntriesDateFormate(
                                                              getJsonField(
                                                        todayViewItem,
                                                        r'''$.timeEntry_Date''',
                                                      ).toString()),
                                                      'date',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .themeColor,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              OnSiteDetailListWidget(
                                                key: Key(
                                                    'Keyqnq_${todayViewIndex}_of_${todayView.length}'),
                                                location: getJsonField(
                                                  todayViewItem,
                                                  r'''$.clock_In_Location''',
                                                ),
                                                checkIn: getJsonField(
                                                  todayViewItem,
                                                  r'''$.clock_In_Time''',
                                                ),
                                                checkOut: getJsonField(
                                                  todayViewItem,
                                                  r'''$.clock_Out_Time''',
                                                ),
                                                checkInAndOuttype: getJsonField(
                                                  todayViewItem,
                                                  r'''$.remark''',
                                                ),
                                                choutlocstion: getJsonField(
                                                  todayViewItem,
                                                  r'''$.clock_Out_Location''',
                                                ),
                                                note: getJsonField(
                                                  todayViewItem,
                                                  r'''$.detail''',
                                                ),
                                                photo: getJsonField(
                                                  todayViewItem,
                                                  r'''$.checkIn_Image''',
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Builder(
                                builder: (context) {
                                  final thisWeek = functions
                                          .filterEntriesForThisWeek(
                                              _model.onSiteListView.toList())
                                          ?.where((e) =>
                                              '3' ==
                                              getJsonField(
                                                e,
                                                r'''$.checkIn_Status''',
                                              ).toString())
                                          .toList()
                                          .toList() ??
                                      [];

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: thisWeek.length,
                                    itemBuilder: (context, thisWeekIndex) {
                                      final thisWeekItem =
                                          thisWeek[thisWeekIndex];
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  functions
                                                      .changeTimeEntriesDateFormate(
                                                          getJsonField(
                                                    thisWeekItem,
                                                    r'''$.timeEntry_Date''',
                                                  ).toString()),
                                                  'date',
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .themeColor,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          OnSiteDetailListWidget(
                                            key: Key(
                                                'Keyr8z_${thisWeekIndex}_of_${thisWeek.length}'),
                                            location: getJsonField(
                                              thisWeekItem,
                                              r'''$.clock_In_Location''',
                                            ),
                                            checkIn: getJsonField(
                                              thisWeekItem,
                                              r'''$.clock_In_Time''',
                                            ),
                                            checkOut: getJsonField(
                                              thisWeekItem,
                                              r'''$.clock_Out_Time''',
                                            ),
                                            checkInAndOuttype: getJsonField(
                                              thisWeekItem,
                                              r'''$.remark''',
                                            ),
                                            choutlocstion: getJsonField(
                                              thisWeekItem,
                                              r'''$.clock_Out_Location''',
                                            ),
                                            note: getJsonField(
                                              thisWeekItem,
                                              r'''$.detail''',
                                            ),
                                            photo: getJsonField(
                                              thisWeekItem,
                                              r'''$.checkIn_Image''',
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
