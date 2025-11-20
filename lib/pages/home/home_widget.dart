import '/backend/api_requests/api_calls.dart';
import 'package:flutter/material.dart';
import '../core/utils/app_utils.dart';
import 'package:hr_app/core/utils/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'home_model.dart';
import '/features/home/presentation/widgets/personal_info_section.dart';
import '/features/home/presentation/providers/home_provider.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          await _homeProvider.loadHomeData();
        }),
        Future(() async {
          if (AppState().isPinCodeFlag) {
            if (AppState().isChangePinCodeFlag) {
              await showDialog(
                context: context,
                builder: (alertDialogContext) {
                  return WebViewAware(
                    child: AlertDialog(
                      title: Text('Pincode changed successfully.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(alertDialogContext),
                          child: Text('Ok'),
                        ),
                      ],
                    ),
                  );
                },
              );
              AppState().isChangePinCodeFlag = false;
              safeSetState(() {});
            } else {
              _model.apiResultGetDayViewOfSTA =
                  await MainGroup.getDayViewOfSTACall.call(
                token: AppState().token,
                companyID: AppState().companyID,
                employeeID: AppState().employeeID,
                todayDate: functions.dateFormatToDay(),
              );

              if (MainGroup.getDayViewOfSTACall.status(
                    (_model.apiResultGetDayViewOfSTA?.jsonBody ?? ''),
                  ) ==
                  0) {
                AppState().approve = MainGroup.getDayViewOfSTACall.approve(
                  (_model.apiResultGetDayViewOfSTA?.jsonBody ?? ''),
                )!;
                AppState().shiftStartTIme =
                    MainGroup.getDayViewOfSTACall.startTime(
                  (_model.apiResultGetDayViewOfSTA?.jsonBody ?? ''),
                )!;
                AppState().shiftEndTime =
                    MainGroup.getDayViewOfSTACall.endTime(
                  (_model.apiResultGetDayViewOfSTA?.jsonBody ?? ''),
                )!;
                AppState().timeType = 'Regular';
                AppState().timezoneOffset =
                    functions.getTimezoneOffset(getCurrentTimestamp);
                AppState().clockInTime = '-' ==
                        MainGroup.getDayViewOfSTACall.latestCheckIN(
                          (_model.apiResultGetDayViewOfSTA?.jsonBody ?? ''),
                        )
                    ? '-'
                    : functions.changeCheckInOutTimeFormatFunction(
                        MainGroup.getDayViewOfSTACall.latestCheckIN(
                        (_model.apiResultGetDayViewOfSTA?.jsonBody ?? ''),
                      ))!;
                AppState().clockOutTime = '-' ==
                        MainGroup.getDayViewOfSTACall.lastestCheckOut(
                          (_model.apiResultGetDayViewOfSTA?.jsonBody ?? ''),
                        )
                    ? '-'
                    : functions.changeCheckInOutTimeFormatFunction(
                        MainGroup.getDayViewOfSTACall.lastestCheckOut(
                        (_model.apiResultGetDayViewOfSTA?.jsonBody ?? ''),
                      ))!;
                safeSetState(() {});
              } else {
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return WebViewAware(
                      child: AlertDialog(
                        title: Text('Alert'),
                        content: Text('Fail !'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(alertDialogContext),
                            child: Text('Ok'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }
          } else {
            Navigator.of(context).pushNamed(PinCodeWidget.routeName);
          }
        }),
        Future(() async {
          _model.apiResultGetDayView = await MainGroup.getDayViewOfSTACall.call(
            token: AppState().token,
            companyID: AppState().companyID,
            employeeID: AppState().employeeID,
            todayDate: functions.dateFormatToDay(),
          );

          if ((_model.apiResultGetDayView?.succeeded ?? true)) {
            _model.timeOffWholeDay =
                MainGroup.getDayViewOfSTACall.timeOffWholeDay(
              (_model.apiResultGetDayView?.jsonBody ?? ''),
            );
            safeSetState(() {});
            AppState().clockInTime = '-' ==
                    MainGroup.getDayViewOfSTACall.latestCheckIN(
                      (_model.apiResultGetDayView?.jsonBody ?? ''),
                    )
                ? '-'
                : functions.changeCheckInOutTimeFormatFunction(
                    MainGroup.getDayViewOfSTACall.latestCheckIN(
                    (_model.apiResultGetDayView?.jsonBody ?? ''),
                  ))!;
            AppState().clockOutTime = '-' ==
                    MainGroup.getDayViewOfSTACall.lastestCheckOut(
                      (_model.apiResultGetDayView?.jsonBody ?? ''),
                    )
                ? '-'
                : functions.changeCheckInOutTimeFormatFunction(
                    MainGroup.getDayViewOfSTACall.lastestCheckOut(
                    (_model.apiResultGetDayView?.jsonBody ?? ''),
                  ))!;
            AppState().checkInOutshowStatus =
                (AppState().clockInTime != '-') &&
                        (AppState().clockOutTime != '-')
                    ? true
                    : false;
            safeSetState(() {});
          }
        }),
        Future(() async {
          _model.apiResultgetLastestNoti =
              await MainGroup.apiLatestNotificationPOSTCall.call(
            companyID: AppState().companyID,
            receiverID: AppState().employeeID,
            token: AppState().token,
          );

          if ((_model.apiResultgetLastestNoti?.succeeded ?? true)) {
            AppState().NotificationCount =
                MainGroup.apiLatestNotificationPOSTCall
                    .notificationList(
                      (_model.apiResultgetLastestNoti?.jsonBody ?? ''),
                    )!
                    .where((e) =>
                        'true' ==
                        getJsonField(
                          e,
                          r'''$.seen''',
                        ).toString().toString())
                    .toList()
                    .length;
            safeSetState(() {});
          }
        }),
        Future(() async {
          _model.apiResultAnnouncement =
              await MainGroup.getCustomerWebCall.call(
            timezoneOffset: AppState().timezoneOffset,
            token: AppState().token,
            companyID: AppState().companyID,
            employeeID: AppState().employeeID,
            perpage: 100,
            page: 100,
            searchValue: 'Announcement',
          );

          if ((_model.apiResultAnnouncement?.succeeded ?? true)) {
            _model.announcementListView = MainGroup.getCustomerWebCall
                .announcementList(
                  (_model.apiResultAnnouncement?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
            safeSetState(() {});
          }
        }),
      ]);
    });

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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).colorScheme.secondaryBackground,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: PersonalInfoSection(),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.of(context).pushNamed(NotificationWidget.routeName);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Badge(
                                label: Text(
                                  valueOrDefault<String>(
                                    AppState().NotificationCount.toString(),
                                    '0',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        fontSize: 10.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                ),
                                backgroundColor: Color(0xFFFF0412),
                                offset: const Offset(8, -8),
                                isLabelVisible: true,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 0.0, 0.0),
                                  child: Icon(
                                    Icons.notifications_sharp,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 0.0))
                          .addToStart(SizedBox(width: 1.0))
                          .addToEnd(SizedBox(width: 1.0)),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).bkCheckin,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(0.0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-0.8, 0.04),
                                  child: Text(
                                    dateTimeFormat(
                                      "MMMMEEEEd",
                                      getCurrentTimestamp,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                                Text(
                                  dateTimeFormat(
                                    "Hm",
                                    getCurrentTimestamp,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        fontSize:
                                            AppState().languageStatus == 'my'
                                                ? 26.0
                                                : 32.5,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '8kyk0g5e' /* Check in */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.readexPro(
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
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            AppState().clockInTime,
                                            '-',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.readexPro(
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
                                                color: functions
                                                    .clockInColorFunction(
                                                        AppState()
                                                            .clockInTime,
                                                        AppState()
                                                            .shiftStartTIme),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                    SizedBox(
                                      height: 50.0,
                                      child: VerticalDivider(
                                        thickness: 1.0,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '8gdrz11r' /* Check out */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.readexPro(
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
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            AppState().clockOutTime,
                                            '-',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.readexPro(
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
                                                color: functions
                                                    .clockOutColorFunction(
                                                        AppState()
                                                            .clockOutTime,
                                                        AppState()
                                                            .shiftEndTime),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                  ],
                                ),
                              ].divide(SizedBox(height: 10.0)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (_model.timeOffWholeDay == null) {
                                      if (AppState().checkInOutshowStatus ==
                                          false) {
                                        if (AppState().clockInTime == '-') {
                                          Navigator.of(context).pushNamed(
                                            CheckInOverAllWidget.routeName,
                                            queryParameters: {
                                              'timeType': serializeParam(
                                                AppState().timeType,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        } else {
                                          if (AppState().clockOutTime ==
                                              '-') {
                                            Navigator.of(context).pushNamed(
                                              CheckOutMergedWidget.routeName,
                                              queryParameters: {
                                                'timeType': serializeParam(
                                                  'Regular',
                                                  ParamType.String,
                                                ),
                                                'checkInData': serializeParam(
                                                  getJsonField(
                                                    (_model.apiResultGetDayView
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$''',
                                                  ),
                                                  ParamType.JSON,
                                                ),
                                              }.withoutNulls,
                                            );
                                          } else {
                                            Navigator.of(context).pushNamed(
                                              CheckInOverAllWidget.routeName,
                                              queryParameters: {
                                                'timeType': serializeParam(
                                                  AppState().timeType,
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                            );
                                          }
                                        }
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return WebViewAware(
                                              child: AlertDialog(
                                                title: Text('Alert'),
                                                content: Text(
                                                    'You have already completed check-in and check-out!'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return WebViewAware(
                                            child: AlertDialog(
                                              title: Text('Alert'),
                                              content: Text(
                                                  'Can\'t CheckIn ! You took leave Today'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.356,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.169,
                                    constraints: BoxConstraints(
                                      maxWidth: 150.0,
                                      maxHeight: 150.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: () {
                                        if (AppState().clockInTime == '-') {
                                          return FlutterFlowTheme.of(context)
                                              .themeColor;
                                        } else if ((AppState().clockInTime !=
                                                '-') &&
                                            (AppState().clockOutTime !=
                                                '-')) {
                                          return Color(0xFFFFA500);
                                        } else {
                                          return Color(0xFF57636C);
                                        }
                                      }(),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        if (AppState().checkInOutshowStatus ==
                                            false)
                                          Icon(
                                            Icons.fingerprint,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            size: 100.0,
                                          ),
                                        if (AppState().checkInOutshowStatus ==
                                            true)
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/fingerprint_1.png',
                                              width: 100.0,
                                              height: 100.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        Text(
                                          () {
                                            if (AppState().clockInTime ==
                                                '-') {
                                              return 'Check In';
                                            } else if ((AppState()
                                                        .clockInTime !=
                                                    '-') &&
                                                (AppState().clockOutTime ==
                                                    '-')) {
                                              return 'Check Out';
                                            } else {
                                              return 'Completed';
                                            }
                                          }(),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.readexPro(
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
                                                color: AppState()
                                                            .checkInOutStatus ==
                                                        'Completed'
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    maxWidth: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).bkCheckin,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 100.0,
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        constraints: BoxConstraints(
                          minWidth: double.infinity,
                          maxWidth: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryBackground,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(0.0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).pushNamed(OnSiteWidget.routeName);
                                  },
                                  child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/On-site.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'ffgqsgrv' /* On-site */,
                                  ),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context
                                        .pushNamed(LeavePageWidget.routeName);
                                  },
                                  child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/Leave.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context
                                        .pushNamed(LeavePageWidget.routeName);
                                  },
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '1gobg3nq' /* Leave */,
                                    ),
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).pushNamed(
                                        OvertimeNewPageWidget.routeName);
                                  },
                                  child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/Overtime.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).pushNamed(OvertimeWidget.routeName);
                                  },
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '5v3kjd4p' /* Overtime */,
                                    ),
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).pushNamed(
                                        ContactStaffWidget.routeName);
                                  },
                                  child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/Document.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).pushNamed(
                                        ContactStaffWidget.routeName);
                                  },
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'lk022jty' /* Contact staff */,
                                    ),
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ]
                              .addToStart(SizedBox(width: 1.0))
                              .addToEnd(SizedBox(width: 1.0)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.58,
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      maxWidth: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.99),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 1.0,
                            constraints: BoxConstraints(
                              minWidth: double.infinity,
                              maxWidth: double.infinity,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFF9ECD1),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(0.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 20.0, 10.0, 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'gh08tcm8' /* Announcements */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Builder(
                                      builder: (context) {
                                        if (_model
                                                .announcementListView.length !=
                                            0) {
                                          return Builder(
                                            builder: (context) {
                                              final announcementList = _model
                                                  .announcementListView
                                                  .toList();

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    announcementList.length,
                                                separatorBuilder: (_, __) =>
                                                    SizedBox(height: 10.0),
                                                itemBuilder: (context,
                                                    announcementListIndex) {
                                                  final announcementListItem =
                                                      announcementList[
                                                          announcementListIndex];
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.24,
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  1.0,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.24,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20.0),
                                                                ),
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20.0),
                                                                ),
                                                                child: Image
                                                                    .network(
                                                                  getJsonField(
                                                                    announcementListItem,
                                                                    r'''$.announcement_Image''',
                                                                  ).toString(),
                                                                  width: double
                                                                      .infinity,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.15,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    0.0),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                getJsonField(
                                                                  announcementListItem,
                                                                  r'''$.announcement_Title''',
                                                                ).toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .announcementTitleColor,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              AutoSizeText(
                                                                getJsonField(
                                                                  announcementListItem,
                                                                  r'''$.createdAnnouncement_Date''',
                                                                ).toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Color(
                                                                          0xFF8A8C8E),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Icon(
                                                                            Icons.remove_red_eye,
                                                                            color:
                                                                                Theme.of(context).colorScheme.primaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          Text(
                                                                            getJsonField(
                                                                              announcementListItem,
                                                                              r'''$.viewCount''',
                                                                            ).toString(),
                                                                            style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                  font: GoogleFonts.readexPro(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 5.0)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          FaIcon(
                                                                            FontAwesomeIcons.solidCommentDots,
                                                                            color:
                                                                                Theme.of(context).colorScheme.primaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          Text(
                                                                            getJsonField(
                                                                              announcementListItem,
                                                                              r'''$.countcomment''',
                                                                            ).toString(),
                                                                            style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                  font: GoogleFonts.readexPro(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 5.0)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        10.0)),
                                                              ),
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if (Navigator.of(
                                                                          context)
                                                                      .canPop()) {
                                                                    context
                                                                        .pop();
                                                                  }
                                                                  context
                                                                      .pushNamed(
                                                                    AnnouncementWebViewWidget
                                                                        .routeName,
                                                                    queryParameters:
                                                                        {
                                                                      'announcementMobileViewURL':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          announcementListItem,
                                                                          r'''$.announcement_ID''',
                                                                        ),
                                                                        ParamType
                                                                            .int,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                },
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'x8ivcl7l' /* Find out More */,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).announcementTitleColor,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_forward_ios_sharp,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .announcementTitleColor,
                                                                      size:
                                                                          14.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 0.0)),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        } else {
                                          return Container(
                                            width: double.infinity,
                                            height: 350.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF9ECD1),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: SvgPicture.asset(
                                                'assets/images/Group_726(1).svg',
                                                width: 200.0,
                                                height: 200.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
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
