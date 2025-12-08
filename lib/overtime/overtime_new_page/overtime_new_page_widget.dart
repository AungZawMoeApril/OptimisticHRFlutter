import '../../core/theme/app_theme_extension.dart';
import '../../core/widgets/app_widgets.dart';
import '../../core/widgets/web_view_aware.dart';
import '../../core/widgets/flutter_flow_drop_down.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/delete_o_t_request_dialog/delete_o_t_request_dialog_widget.dart';
import '../../core/widgets/app_icon_button.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_utils.dart';
import '../../core/widgets/app_button.dart';

import '/backend/schema/structs/index.dart';
import 'package:h_r_optimistic_mobile/core/utils/custom_functions.dart' as functions;
import '../../app_state.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'overtime_new_page_model.dart';
import '/core/theme/app_colors.dart';
import '../../pages/home/home_widget.dart';
import '../overtime_request_main/overtime_request_main_widget.dart';
import '../overtime_detail/overtime_detail_widget.dart';
import '../overtime_detail_check_out/overtime_detail_check_out_widget.dart';
import '../edit_overtime_request/edit_overtime_request_widget.dart';
export 'overtime_new_page_model.dart';

class OvertimeNewPageWidget extends StatefulWidget {
  const OvertimeNewPageWidget({super.key});

  static String routeName = 'OvertimeNewPage';
  static String routePath = '/OvertimeNewPage';

  @override
  State<OvertimeNewPageWidget> createState() => _OvertimeNewPageWidgetState();
}

class _OvertimeNewPageWidgetState extends State<OvertimeNewPageWidget>
    with TickerProviderStateMixin {
  late OvertimeNewPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OvertimeNewPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          _model.apiResultCurrentOTime = await MainGroup.overtimeListViewCall.call(
            timezoneOffset: AppState().timezoneOffset,
            employeeID: AppState().employeeID,
            companyID: AppState().companyID,
            token: AppState().token,
          );

          if ('0' ==
              getJsonField(
                (_model.apiResultCurrentOTime?.jsonBody ?? ''),
                r'''$.status''',
              ).toString().toString()) {
            _model.currentOTList = MainGroup.overtimeListViewCall
                .currentListView(
                  (_model.apiResultCurrentOTime?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
            safeSetState(() {});
            AppState().otClockInTime = '-' ==
                    MainGroup.overtimeListViewCall.clockInTime(
                      (_model.apiResultCurrentOTime?.jsonBody ?? ''),
                    )
                ? '-'
                : functions
                    .changeCheckInOutTimeFormatFunction(MainGroup.overtimeListViewCall.clockInTime(
                    (_model.apiResultCurrentOTime?.jsonBody ?? ''),
                  ));
            AppState().otClockOutTime = '-' ==
                    MainGroup.overtimeListViewCall.clockOutTime(
                      (_model.apiResultCurrentOTime?.jsonBody ?? ''),
                    )
                ? '-'
                : functions
                    .changeCheckInOutTimeFormatFunction(MainGroup.overtimeListViewCall.clockOutTime(
                    (_model.apiResultCurrentOTime?.jsonBody ?? ''),
                  ));
            AppState().OTRequestID = MainGroup.overtimeListViewCall.oTRequestID(
              (_model.apiResultCurrentOTime?.jsonBody ?? ''),
            );
            AppState().clockID = MainGroup.overtimeListViewCall.clockID(
              (_model.apiResultCurrentOTime?.jsonBody ?? ''),
            );
            safeSetState(() {});
          } else {
            await showDialog(
              context: context,
              builder: (alertDialogContext) {
                return WebViewAware(
                  child: AlertDialog(
                    title: Text('Alert'),
                    content: Text(getJsonField(
                      (_model.apiResultCurrentOTime?.jsonBody ?? ''),
                      r'''$.message''',
                    ).toString().toString()),
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
        }),
        Future(() async {
          _model.apiResulHistory = await MainGroup.apiOvertimeHistoryPOSTCall.call(
            companyIDMain: AppState().companyID,
            companyID: AppState().companyID,
            employeeIDMain: AppState().employeeID,
            todayDateMain: valueOrDefault<String>(
              dateTimeFormat(
                "d/M/y",
                getCurrentTimestamp,
                locale: FFLocalizations.of(context).languageCode,
              ),
              '05/12/2024',
            ),
            token: AppState().token,
          );

          if (MainGroup.apiOvertimeHistoryPOSTCall.outputstatus(
                (_model.apiResulHistory?.jsonBody ?? ''),
              ) ==
              0) {
            _model.overTimeHistory = MainGroup.apiOvertimeHistoryPOSTCall
                .overtimeHistoryList(
                  (_model.apiResulHistory?.jsonBody ?? ''),
                )!
                .where((e) =>
                    AppState().employeeID ==
                    getJsonField(
                      e,
                      r'''$.requester_ID''',
                    ))
                .toList()
                .toList()
                .cast<dynamic>();
            _model.overtimeStatusAllData = MainGroup.apiOvertimeHistoryPOSTCall
                .overtimeHistoryList(
                  (_model.apiResulHistory?.jsonBody ?? ''),
                )!
                .where((e) =>
                    AppState().employeeID ==
                    getJsonField(
                      e,
                      r'''$.requester_ID''',
                    ))
                .toList()
                .toList()
                .cast<dynamic>();
            _model.overtimeApprovedTab = MainGroup.apiOvertimeHistoryPOSTCall
                .overtimeHistoryList(
                  (_model.apiResulHistory?.jsonBody ?? ''),
                )!
                .where((e) =>
                    ('Approved' ==
                        getJsonField(
                          e,
                          r'''$.status''',
                        ).toString().toString()) &&
                    (AppState().employeeID ==
                        getJsonField(
                          e,
                          r'''$.requester_ID''',
                        )))
                .toList()
                .toList()
                .cast<dynamic>();
            safeSetState(() {});
          }
        }),
      ]);
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
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
    AppState();

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
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 30.0,
            ),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeWidget(),
                ),
              );
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'h3n5r5e6' /* Overtime */,
            ),
            style: GoogleFonts.outfit(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 22.0,
              letterSpacing: 0.0,
              fontWeight: context.headlineMedium?.fontWeight ?? FontWeight.normal,
              fontStyle: context.headlineMedium?.fontStyle ?? FontStyle.normal,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 14.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OvertimeRequestMainWidget(),
                    ),
                  );
                },
                child: FaIcon(
                  FontAwesomeIcons.plusCircle,
                  color: Color(0xFFF89D27),
                  size: 24.0,
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (functions.overtimeShowDataFunction(MainGroup.overtimeListViewCall
                      .currentListView(
                        (_model.apiResultCurrentOTime?.jsonBody ?? ''),
                      )
                      ?.toList()) ==
                  true)
                Builder(
                  builder: (context) {
                    final otList = _model.currentOTList.toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: otList.length,
                      itemBuilder: (context, otListIndex) {
                        final otListItem = otList[otListIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 0.25,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: Theme.of(context).textTheme.bodyMedium?.color,
                                          size: 24.0,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 10.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              dateTimeFormat(
                                                "dd/MM/yyyy",
                                                getCurrentTimestamp,
                                                locale: FFLocalizations.of(context).languageCode,
                                              ),
                                              '18/03/2025',
                                            ),
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  fontFamily: GoogleFonts.readexPro(
                                                    fontWeight: Theme.of(context)
                                                        .fontFamily
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontWeight,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ).fontFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            getJsonField(
                                              otListItem,
                                              r'''$.oT_Start_Time''',
                                            )?.toString(),
                                            '08:00',
                                          ),
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                fontFamily: GoogleFonts.readexPro(
                                                  fontWeight: Theme.of(context)
                                                      .fontFamily
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
                                                ).fontFamily,
                                                letterSpacing: 0.0,
                                                fontWeight: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .fontWeight,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '2o5ml060' /*  - */,
                                          ),
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                fontFamily: GoogleFonts.readexPro(
                                                  fontWeight: Theme.of(context)
                                                      .fontFamily
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
                                                ).fontFamily,
                                                letterSpacing: 0.0,
                                                fontWeight: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .fontWeight,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .fontStyle,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              getJsonField(
                                                otListItem,
                                                r'''$.oT_End_Time''',
                                              )?.toString(),
                                              '17:00',
                                            ),
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  fontFamily: GoogleFonts.readexPro(
                                                    fontWeight: Theme.of(context)
                                                        .fontFamily
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontWeight,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ).fontFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              getJsonField(
                                                otListItem,
                                                r'''$.oT_Hours''',
                                              )?.toString(),
                                              '8 hr 00 min',
                                            ),
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  fontFamily: GoogleFonts.readexPro(
                                                    fontWeight: Theme.of(context)
                                                        .fontFamily
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontWeight,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ).fontFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: Theme.of(context).colorScheme.surface,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Text(
                                                      FFLocalizations.of(context).getText(
                                                        'w6139z9e' /* Check in */,
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                            fontFamily: GoogleFonts.readexPro(
                                                              fontWeight: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontWeight,
                                                            fontStyle: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        functions
                                                            .changeCheckInOutTimeFormatFunction(
                                                                getJsonField(
                                                          otListItem,
                                                          r'''$.clock_In_Time''',
                                                        ).toString()),
                                                        '-',
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                            fontFamily: GoogleFonts.readexPro(
                                                              fontWeight: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                            color: AppColors.timeCheckin,
                                                            letterSpacing: 0.0,
                                                            fontWeight: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontWeight,
                                                            fontStyle: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 50.0,
                                                child: VerticalDivider(
                                                  thickness: 1.0,
                                                  color:
                                                      Theme.of(context).textTheme.bodyMedium?.color,
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Text(
                                                      FFLocalizations.of(context).getText(
                                                        'v2v7obuq' /* Check out */,
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                            fontFamily: GoogleFonts.readexPro(
                                                              fontWeight: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontWeight,
                                                            fontStyle: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        functions
                                                            .changeCheckInOutTimeFormatFunction(
                                                                valueOrDefault<String>(
                                                          getJsonField(
                                                            otListItem,
                                                            r'''$.clock_Out_Time''',
                                                          )?.toString(),
                                                          '-',
                                                        )),
                                                        '-',
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                            fontFamily: GoogleFonts.readexPro(
                                                              fontWeight: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                            color: AppColors.timeCheckin,
                                                            letterSpacing: 0.0,
                                                            fontWeight: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontWeight,
                                                            fontStyle: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(-1.0, -1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 20.0, 40.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context).getText(
                                                      'p201mgxt' /* Total : */,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                          fontFamily: GoogleFonts.readexPro(
                                                            fontWeight: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontWeight,
                                                            fontStyle: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontWeight,
                                                          fontStyle: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontStyle,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        ('-' !=
                                                                    getJsonField(
                                                                      otListItem,
                                                                      r'''$.clock_In_Time''',
                                                                    ).toString()) &&
                                                                ('-' !=
                                                                    getJsonField(
                                                                      otListItem,
                                                                      r'''$.clock_Out_Time''',
                                                                    ).toString())
                                                            ? functions.calculateOTHourFunction(
                                                                getJsonField(
                                                                  otListItem,
                                                                  r'''$.clock_In_Time''',
                                                                ).toString(),
                                                                getJsonField(
                                                                  otListItem,
                                                                  r'''$.clock_Out_Time''',
                                                                ).toString())
                                                            : '00 hr 00 min',
                                                        '00 hr 00 min',
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                            fontFamily: GoogleFonts.readexPro(
                                                              fontWeight: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontWeight,
                                                            fontStyle: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context).width * 0.356,
                                            height: MediaQuery.sizeOf(context).height * 0.169,
                                            constraints: BoxConstraints(
                                              maxWidth: 150.0,
                                              maxHeight: 150.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: () {
                                                if ('-' ==
                                                    getJsonField(
                                                      otListItem,
                                                      r'''$.clock_In_Time''',
                                                    ).toString()) {
                                                  return Theme.of(context).colorScheme.primary;
                                                } else if (('-' !=
                                                        getJsonField(
                                                          otListItem,
                                                          r'''$.clock_In_Time''',
                                                        ).toString()) &&
                                                    ('-' !=
                                                        getJsonField(
                                                          otListItem,
                                                          r'''$.clock_Out_Time''',
                                                        ).toString())) {
                                                  return Color(0xFFFFA500);
                                                } else {
                                                  return Color(0xFF57636C);
                                                }
                                              }(),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: () async {
                                                if ('-' ==
                                                    getJsonField(
                                                      otListItem,
                                                      r'''$.clock_In_Time''',
                                                    ).toString()) {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) => OvertimeDetailWidget(
                                                        overtimedetails:
                                                            CurrentOTListStruct.maybeFromMap(
                                                                getJsonField(
                                                          (_model.apiResultCurrentOTime?.jsonBody ??
                                                              ''),
                                                          r'''$.data[0]''',
                                                        )),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  if ('-' ==
                                                      getJsonField(
                                                        otListItem,
                                                        r'''$.clock_Out_Time''',
                                                      ).toString()) {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OvertimeDetailCheckOutWidget(
                                                          overtimedetails:
                                                              CurrentOTListStruct.maybeFromMap(
                                                                  getJsonField(
                                                            (_model.apiResultCurrentOTime
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.data[0]''',
                                                          )),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Icons.fingerprint,
                                                    color: Theme.of(context).colorScheme.surface,
                                                    size: 100.0,
                                                  ),
                                                  Text(
                                                    () {
                                                      if ('-' ==
                                                          getJsonField(
                                                            otListItem,
                                                            r'''$.clock_In_Time''',
                                                          ).toString()) {
                                                        return 'Check In';
                                                      } else if (('-' !=
                                                              getJsonField(
                                                                otListItem,
                                                                r'''$.clock_In_Time''',
                                                              ).toString()) &&
                                                          ('-' ==
                                                              getJsonField(
                                                                otListItem,
                                                                r'''$.clock_Out_Time''',
                                                              ).toString())) {
                                                        return 'Check Out';
                                                      } else {
                                                        return 'Completed';
                                                      }
                                                    }(),
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                          fontFamily: GoogleFonts.readexPro(
                                                            fontWeight: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontWeight,
                                                            fontStyle: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontWeight,
                                                          fontStyle: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
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
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              if (!functions.overtimeShowDataFunction(MainGroup.overtimeListViewCall
                  .currentListView(
                    (_model.apiResultCurrentOTime?.jsonBody ?? ''),
                  )
                  ?.toList()))
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Color(0xFFB4AFAF),
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '4wtgh51r' /* There is no overtime shift tim... */,
                        ),
                        style: GoogleFonts.readexPro(
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight ??
                              FontWeight.normal,
                          fontStyle:
                              Theme.of(context).textTheme.bodyMedium?.fontStyle ?? FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(0.0, 0),
                      child: FlutterFlowButtonTabBar(
                        labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontFamily: GoogleFonts.readexPro().fontFamily,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                        unselectedLabelStyle: TextStyle(),
                        labelColor: Theme.of(context).colorScheme.secondaryBackground,
                        unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
                        backgroundColor: Color(0xFFF9B052),
                        unselectedBackgroundColor:
                            Theme.of(context).colorScheme.secondaryBackground,
                        borderColor: Theme.of(context).colorScheme.primary,
                        borderWidth: 2.0,
                        borderRadius: BorderRadius.circular(8.0),
                        elevation: 0.0,
                        padding: EdgeInsets.all(4.0),
                        tabs: [
                          Tab(
                            text: FFLocalizations.of(context).getText(
                              'chkylcmm' /* Approved */,
                            ),
                          ),
                          Tab(
                            text: FFLocalizations.of(context).getText(
                              '8n11hw6r' /* Pending */,
                            ),
                          ),
                          Tab(
                            text: FFLocalizations.of(context).getText(
                              'o6ss9rze' /* Histoy */,
                            ),
                          ),
                        ],
                        controller: _model.tabBarController!,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 0.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 210.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(4.0),
                                        border: Border.all(
                                          color: Theme.of(context).colorScheme.surface,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.yeardata = dateTimeFormat(
                                            "yyyy",
                                            getCurrentTimestamp,
                                            locale: FFLocalizations.of(context).languageCode,
                                          );
                                          _model.monthData = dateTimeFormat(
                                            "MM",
                                            getCurrentTimestamp,
                                            locale: FFLocalizations.of(context).languageCode,
                                          );
                                          safeSetState(() {});
                                          _model.apiResultftp =
                                              await MainGroup.getOTRequestByStatusMobileCall.call(
                                            monthNum: dateTimeFormat(
                                              "MM",
                                              getCurrentTimestamp,
                                              locale: FFLocalizations.of(context).languageCode,
                                            ),
                                            yearNum: dateTimeFormat(
                                              "yyyy",
                                              getCurrentTimestamp,
                                              locale: FFLocalizations.of(context).languageCode,
                                            ),
                                            status: 1,
                                            employeeID: AppState().employeeID,
                                            companyID: AppState().companyID,
                                            token: AppState().token,
                                          );

                                          if ((_model.apiResultftp?.succeeded ?? true)) {
                                            _model.overtimeApprovedTab = getJsonField(
                                              (_model.apiResultftp?.jsonBody ?? ''),
                                              r'''$.data''',
                                            )!
                                                .toList()
                                                .cast<dynamic>();
                                            safeSetState(() {});
                                          }

                                          safeSetState(() {});
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context).getText(
                                                  'e9ivyc3i' /* Month:  */,
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontFamily: GoogleFonts.readexPro(
                                                        fontWeight: Theme.of(context)
                                                            .fontFamily
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontWeight,
                                                        fontStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontStyle,
                                                      ).fontFamily,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.color,
                                                      letterSpacing: 0.0,
                                                      fontWeight: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .fontWeight,
                                                      fontStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .fontStyle,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              dateTimeFormat(
                                                "MMM",
                                                getCurrentTimestamp,
                                                locale: FFLocalizations.of(context).languageCode,
                                              ),
                                              style:
                                                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                        fontFamily: GoogleFonts.readexPro(
                                                          fontWeight: Theme.of(context)
                                                              .fontFamily
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontWeight,
                                                          fontStyle: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontStyle,
                                                        ).fontFamily,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.color,
                                                        letterSpacing: 0.0,
                                                        fontWeight: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontWeight,
                                                        fontStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontStyle,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context).getText(
                                                  'coqp474n' /* Year:  */,
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontFamily: GoogleFonts.readexPro(
                                                        fontWeight: Theme.of(context)
                                                            .fontFamily
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontWeight,
                                                        fontStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontStyle,
                                                      ).fontFamily,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.color,
                                                      letterSpacing: 0.0,
                                                      fontWeight: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .fontWeight,
                                                      fontStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .fontStyle,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              dateTimeFormat(
                                                "yyyy",
                                                getCurrentTimestamp,
                                                locale: FFLocalizations.of(context).languageCode,
                                              ),
                                              style:
                                                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                        fontFamily: GoogleFonts.readexPro(
                                                          fontWeight: Theme.of(context)
                                                              .fontFamily
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontWeight,
                                                          fontStyle: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontStyle,
                                                        ).fontFamily,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.color,
                                                        letterSpacing: 0.0,
                                                        fontWeight: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontWeight,
                                                        fontStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontStyle,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  3.0, 0.0, 0.0, 0.0),
                                              child: Icon(
                                                Icons.calendar_month,
                                                color:
                                                    Theme.of(context).textTheme.bodyMedium?.color,
                                                size: 22.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    final overtimeApproved = _model.overtimeApprovedTab.toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: overtimeApproved.length,
                                      itemBuilder: (context, overtimeApprovedIndex) {
                                        final overtimeApprovedItem =
                                            overtimeApproved[overtimeApprovedIndex];
                                        return Align(
                                          alignment: AlignmentDirectional(-1.0, -1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 5.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 220.0,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.surface,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(13.0),
                                                  bottomRight: Radius.circular(13.0),
                                                  topLeft: Radius.circular(13.0),
                                                  topRight: Radius.circular(13.0),
                                                ),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                      10.0, 8.0, 15.0, 0.0),
                                                              child: Text(
                                                                valueOrDefault<String>(
                                                                  getJsonField(
                                                                    overtimeApprovedItem,
                                                                    r'''$.workFlow_Name''',
                                                                  )?.toString(),
                                                                  'OT',
                                                                ),
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                      fontFamily:
                                                                          GoogleFonts.readexPro(
                                                                        fontWeight:
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium!
                                                                                .fontWeight,
                                                                        fontStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Color(0xFFF89D27),
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        0.0, 15.0, 20.0, 0.0),
                                                                child: AppButton(
                                                                  onPressed: () {
                                                                    print('Button pressed ...');
                                                                  },
                                                                  text: getJsonField(
                                                                    overtimeApprovedItem,
                                                                    r'''$.status''',
                                                                  ).toString(),
                                                                  options: FFButtonOptions(
                                                                    height: 30.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            24.0, 0.0, 24.0, 0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                                0.0, 0.0, 0.0, 0.0),
                                                                    color: functions
                                                                        .overtimeStatusBackgroundColor(
                                                                            getJsonField(
                                                                      overtimeApprovedItem,
                                                                      r'''$.status''',
                                                                    ).toString()),
                                                                    textStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .copyWith(
                                                                          fontFamily: GoogleFonts
                                                                                  .readexPro()
                                                                              .fontFamily,
                                                                          color: functions
                                                                              .overtimeStatusTextColor(
                                                                                  getJsonField(
                                                                            overtimeApprovedItem,
                                                                            r'''$.status''',
                                                                          ).toString()),
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                    elevation: 3.0,
                                                                    borderSide: BorderSide(
                                                                      color: Colors.transparent,
                                                                      width: 1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(24.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              10.0, 0.0, 0.0, 8.0),
                                                          child: Text(
                                                            FFLocalizations.of(context).getText(
                                                              '6bum7bzr' /* Amount */,
                                                            ),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium
                                                                      ?.color,
                                                                  fontSize: 12.0,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 0.0, 0.0, 8.0),
                                                            child: Text(
                                                              valueOrDefault<String>(
                                                                functions.leaveDayAmountFunction(
                                                                    getJsonField(
                                                                      overtimeApprovedItem,
                                                                      r'''$.start_Date''',
                                                                    ).toString(),
                                                                    getJsonField(
                                                                      overtimeApprovedItem,
                                                                      r'''$.end_Date''',
                                                                    ).toString(),
                                                                    getJsonField(
                                                                      overtimeApprovedItem,
                                                                      r'''$.oT_Start_Time''',
                                                                    ).toString(),
                                                                    getJsonField(
                                                                      overtimeApprovedItem,
                                                                      r'''$.oT_End_Time''',
                                                                    ).toString()),
                                                                'OverTimeDayAmount',
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium
                                                                        ?.color,
                                                                    fontSize: 10.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 0.0, 0.0, 8.0),
                                                            child: Text(
                                                              FFLocalizations.of(context).getText(
                                                                'o3zrkysl' /* From  */,
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium
                                                                        ?.color,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(0.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                0.0, 0.0, 5.0, 8.0),
                                                            child: Text(
                                                              valueOrDefault<String>(
                                                                functions
                                                                    .changeDateFormat(getJsonField(
                                                                  overtimeApprovedItem,
                                                                  r'''$.start_Date''',
                                                                ).toString()),
                                                                'start date',
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(0.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                0.0, 0.0, 0.0, 8.0),
                                                            child: Text(
                                                              getJsonField(
                                                                overtimeApprovedItem,
                                                                r'''$.oT_Start_Time''',
                                                              ).toString(),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              0.0, 0.0, 0.0, 8.0),
                                                          child: Text(
                                                            FFLocalizations.of(context).getText(
                                                              '77qyq835' /*  - */,
                                                            ),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              5.0, 0.0, 0.0, 8.0),
                                                          child: Text(
                                                            getJsonField(
                                                              overtimeApprovedItem,
                                                              r'''$.oT_End_Time''',
                                                            ).toString(),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 0.0, 0.0, 0.0),
                                                            child: Text(
                                                              FFLocalizations.of(context).getText(
                                                                '11xllhg3' /* Note :  */,
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize: 10.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          getJsonField(
                                                            overtimeApprovedItem,
                                                            r'''$.purpose_OT''',
                                                          ).toString(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                fontFamily: GoogleFonts.readexPro(
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing: 0.0,
                                                                fontWeight: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                                fontStyle: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    Builder(
                                                      builder: (context) => InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          if ((getJsonField(
                                                            overtimeApprovedItem,
                                                            r'''$.attachmentlist''',
                                                          )
                                                                      .toList()
                                                                      .map<AttachmentFileModelStruct?>(
                                                                          AttachmentFileModelStruct
                                                                              .maybeFromMap)
                                                                      .toList()
                                                                  as Iterable<
                                                                      AttachmentFileModelStruct?>)
                                                              .withoutNulls
                                                              .isNotEmpty) {
                                                            await showDialog(
                                                              context: context,
                                                              builder: (dialogContext) {
                                                                return Dialog(
                                                                  elevation: 0,
                                                                  insetPadding: EdgeInsets.zero,
                                                                  backgroundColor:
                                                                      Colors.transparent,
                                                                  alignment:
                                                                      AlignmentDirectional(0.0, 0.0)
                                                                          .resolve(
                                                                              Directionality.of(
                                                                                  context)),
                                                                  child: WebViewAware(
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        FocusScope.of(dialogContext)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance.primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          OvertimeAttachmentModelWidget(
                                                                        oTRequestID: 0,
                                                                        attachmentList:
                                                                            getJsonField(
                                                                          overtimeApprovedItem,
                                                                          r'''$.attachmentlist''',
                                                                        )!,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                        },
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                      10.0, 10.0, 0.0, 0.0),
                                                              child: Text(
                                                                valueOrDefault<String>(
                                                                  functions
                                                                      .attachmentCountFunction(
                                                                          (getJsonField(
                                                                        overtimeApprovedItem,
                                                                        r'''$.attachmentlist''',
                                                                      ) as List)
                                                                              .map<String>((s) =>
                                                                                  s.toString())
                                                                              .toList())
                                                                      .toString(),
                                                                  '0',
                                                                ),
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                      fontFamily:
                                                                          GoogleFonts.readexPro(
                                                                        fontWeight:
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium!
                                                                                .fontWeight,
                                                                        fontStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Theme.of(context)
                                                                          .colorScheme
                                                                          .primary,
                                                                      fontSize: 10.0,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(-1.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        5.0, 10.0, 0.0, 0.0),
                                                                child: Text(
                                                                  FFLocalizations.of(context)
                                                                      .getText(
                                                                    '1reect74' /* attachement */,
                                                                  ),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                        fontFamily:
                                                                            GoogleFonts.readexPro(
                                                                          fontWeight:
                                                                              Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyMedium!
                                                                                  .fontWeight,
                                                                          fontStyle:
                                                                              Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyMedium!
                                                                                  .fontStyle,
                                                                        ),
                                                                        color: Color(0xFFF89D27),
                                                                        fontSize: 10.0,
                                                                        letterSpacing: 0.0,
                                                                        fontWeight:
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium!
                                                                                .fontWeight,
                                                                        fontStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 8.0, 0.0, 0.0),
                                                            child: Text(
                                                              FFLocalizations.of(context).getText(
                                                                '0q7wykc6' /* Request date :  */,
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color:
                                                                        AppColors.overtimetextcolor,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              0.0, 8.0, 0.0, 0.0),
                                                          child: Text(
                                                            valueOrDefault<String>(
                                                              functions.changeRequestedDateFormat(
                                                                  getJsonField(
                                                                overtimeApprovedItem,
                                                                r'''$.oT_Requested_Date''',
                                                              ).toString()),
                                                              'request Date',
                                                            ),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color:
                                                                      AppColors.overtimetextcolor,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: Theme.of(context).colorScheme.surface,
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 250.0,
                                                          height: 20.0,
                                                          decoration: BoxDecoration(
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .surface,
                                                          ),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        10.0, 0.0, 0.0, 0.0),
                                                                child: Text(
                                                                  FFLocalizations.of(context)
                                                                      .getText(
                                                                    '9f03rh1g' /* Approved by :  */,
                                                                  ),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                        fontFamily:
                                                                            GoogleFonts.readexPro(
                                                                          fontWeight:
                                                                              Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyMedium!
                                                                                  .fontWeight,
                                                                          fontStyle:
                                                                              Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyMedium!
                                                                                  .fontStyle,
                                                                        ),
                                                                        color: AppColors
                                                                            .overtimetextcolor,
                                                                        fontSize: 12.0,
                                                                        letterSpacing: 0.0,
                                                                        fontWeight:
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium!
                                                                                .fontWeight,
                                                                        fontStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                              Text(
                                                                getJsonField(
                                                                  overtimeApprovedItem,
                                                                  r'''$.approver_Name''',
                                                                ).toString(),
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                      fontFamily:
                                                                          GoogleFonts.readexPro(
                                                                        fontWeight:
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium!
                                                                                .fontWeight,
                                                                        fontStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                      color: AppColors
                                                                          .overtimetextcolor,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 100.0,
                                                          height: 20.0,
                                                          decoration: BoxDecoration(
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .surface,
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                0.0, 0.0, 10.0, 0.0),
                                                            child: Text(
                                                              getJsonField(
                                                                overtimeApprovedItem,
                                                                r'''$.status''',
                                                              ).toString(),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: functions
                                                                        .leaveStatusTextColor(
                                                                            getJsonField(
                                                                      overtimeApprovedItem,
                                                                      r'''$.status''',
                                                                    ).toString()),
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 0.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 190.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(4.0),
                                        border: Border.all(
                                          color: Theme.of(context).colorScheme.surface,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.yeardata = dateTimeFormat(
                                            "yyyy",
                                            getCurrentTimestamp,
                                            locale: FFLocalizations.of(context).languageCode,
                                          );
                                          _model.monthData = dateTimeFormat(
                                            "MM",
                                            getCurrentTimestamp,
                                            locale: FFLocalizations.of(context).languageCode,
                                          );
                                          safeSetState(() {});
                                          _model.apiResulOTPending =
                                              await MainGroup.getOTRequestByStatusMobileCall.call(
                                            monthNum: dateTimeFormat(
                                              "MM",
                                              getCurrentTimestamp,
                                              locale: FFLocalizations.of(context).languageCode,
                                            ),
                                            yearNum: dateTimeFormat(
                                              "yyyy",
                                              getCurrentTimestamp,
                                              locale: FFLocalizations.of(context).languageCode,
                                            ),
                                            status: 2,
                                            employeeID: AppState().employeeID,
                                            companyID: AppState().companyID,
                                            token: AppState().token,
                                          );

                                          if ((_model.apiResulOTPending?.succeeded ?? true)) {
                                            _model.overtimePendingTab = getJsonField(
                                              (_model.apiResulOTPending?.jsonBody ?? ''),
                                              r'''$.data''',
                                            )!
                                                .toList()
                                                .cast<dynamic>();
                                            safeSetState(() {});
                                          }

                                          safeSetState(() {});
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Month: ${dateTimeFormat(
                                                  "MMM",
                                                  getCurrentTimestamp,
                                                  locale: FFLocalizations.of(context).languageCode,
                                                )} Year: ${dateTimeFormat(
                                                  "yyyy",
                                                  getCurrentTimestamp,
                                                  locale: FFLocalizations.of(context).languageCode,
                                                )}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontFamily: GoogleFonts.readexPro(
                                                        fontWeight: Theme.of(context)
                                                            .fontFamily
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontWeight,
                                                        fontStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontStyle,
                                                      ).fontFamily,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.color,
                                                      letterSpacing: 0.0,
                                                      fontWeight: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .fontWeight,
                                                      fontStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .fontStyle,
                                                    ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  3.0, 0.0, 0.0, 0.0),
                                              child: Icon(
                                                Icons.calendar_month,
                                                color:
                                                    Theme.of(context).textTheme.bodyMedium?.color,
                                                size: 22.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    final overtimePending = _model.overtimePendingTab.toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: overtimePending.length,
                                      itemBuilder: (context, overtimePendingIndex) {
                                        final overtimePendingItem =
                                            overtimePending[overtimePendingIndex];
                                        return Align(
                                          alignment: AlignmentDirectional(-1.0, -1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 5.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 220.0,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.surface,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(13.0),
                                                  bottomRight: Radius.circular(13.0),
                                                  topLeft: Radius.circular(13.0),
                                                  topRight: Radius.circular(13.0),
                                                ),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                      10.0, 8.0, 15.0, 0.0),
                                                              child: Text(
                                                                valueOrDefault<String>(
                                                                  getJsonField(
                                                                    overtimePendingItem,
                                                                    r'''$.workFlow_Name''',
                                                                  )?.toString(),
                                                                  'OT',
                                                                ),
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                      fontFamily:
                                                                          GoogleFonts.readexPro(
                                                                        fontWeight:
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium!
                                                                                .fontWeight,
                                                                        fontStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Color(0xFFF89D27),
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        0.0, 15.0, 20.0, 0.0),
                                                                child: AppButton(
                                                                  onPressed: () {
                                                                    print('Button pressed ...');
                                                                  },
                                                                  text: FFLocalizations.of(context)
                                                                      .getText(
                                                                    '256rkl3g' /* Pending */,
                                                                  ),
                                                                  options: FFButtonOptions(
                                                                    height: 30.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            24.0, 0.0, 24.0, 0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                                0.0, 0.0, 0.0, 0.0),
                                                                    color: Color(0xFFDAE3F3),
                                                                    textStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .copyWith(
                                                                          fontFamily: GoogleFonts
                                                                                  .readexPro()
                                                                              .fontFamily,
                                                                          color: Color(0xFF21A8D6),
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                    elevation: 3.0,
                                                                    borderSide: BorderSide(
                                                                      color: Colors.transparent,
                                                                      width: 1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(24.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              10.0, 0.0, 0.0, 8.0),
                                                          child: Text(
                                                            FFLocalizations.of(context).getText(
                                                              'n7hf91ws' /* Amount */,
                                                            ),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium
                                                                      ?.color,
                                                                  fontSize: 12.0,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 0.0, 0.0, 8.0),
                                                            child: Text(
                                                              valueOrDefault<String>(
                                                                functions.leaveDayAmountFunction(
                                                                    getJsonField(
                                                                      overtimePendingItem,
                                                                      r'''$.start_Date''',
                                                                    ).toString(),
                                                                    getJsonField(
                                                                      overtimePendingItem,
                                                                      r'''$.end_Date''',
                                                                    ).toString(),
                                                                    getJsonField(
                                                                      overtimePendingItem,
                                                                      r'''$.oT_Start_Time''',
                                                                    ).toString(),
                                                                    getJsonField(
                                                                      overtimePendingItem,
                                                                      r'''$.oT_End_Time''',
                                                                    ).toString()),
                                                                'OverTimeDayAmount',
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium
                                                                        ?.color,
                                                                    fontSize: 10.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 0.0, 0.0, 8.0),
                                                            child: Text(
                                                              FFLocalizations.of(context).getText(
                                                                'g7584o6e' /* From  */,
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium
                                                                        ?.color,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(0.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                0.0, 0.0, 5.0, 8.0),
                                                            child: Text(
                                                              valueOrDefault<String>(
                                                                functions
                                                                    .changeDateFormat(getJsonField(
                                                                  overtimePendingItem,
                                                                  r'''$.start_Date''',
                                                                ).toString()),
                                                                'start date',
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(0.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                0.0, 0.0, 0.0, 8.0),
                                                            child: Text(
                                                              getJsonField(
                                                                overtimePendingItem,
                                                                r'''$.oT_Start_Time''',
                                                              ).toString(),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              0.0, 0.0, 0.0, 8.0),
                                                          child: Text(
                                                            FFLocalizations.of(context).getText(
                                                              'cmtjte0x' /*  - */,
                                                            ),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              5.0, 0.0, 0.0, 8.0),
                                                          child: Text(
                                                            getJsonField(
                                                              overtimePendingItem,
                                                              r'''$.oT_End_Time''',
                                                            ).toString(),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 0.0, 0.0, 0.0),
                                                            child: Text(
                                                              FFLocalizations.of(context).getText(
                                                                'pgalkk1y' /* Note :  */,
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize: 10.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          getJsonField(
                                                            overtimePendingItem,
                                                            r'''$.purpose_OT''',
                                                          ).toString(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                fontFamily: GoogleFonts.readexPro(
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing: 0.0,
                                                                fontWeight: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                                fontStyle: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    Builder(
                                                      builder: (context) => InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          if ((getJsonField(
                                                            overtimePendingItem,
                                                            r'''$.attachmentlist''',
                                                          )
                                                                      .toList()
                                                                      .map<AttachmentFileModelStruct?>(
                                                                          AttachmentFileModelStruct
                                                                              .maybeFromMap)
                                                                      .toList()
                                                                  as Iterable<
                                                                      AttachmentFileModelStruct?>)
                                                              .withoutNulls
                                                              .isNotEmpty) {
                                                            await showDialog(
                                                              context: context,
                                                              builder: (dialogContext) {
                                                                return Dialog(
                                                                  elevation: 0,
                                                                  insetPadding: EdgeInsets.zero,
                                                                  backgroundColor:
                                                                      Colors.transparent,
                                                                  alignment:
                                                                      AlignmentDirectional(0.0, 0.0)
                                                                          .resolve(
                                                                              Directionality.of(
                                                                                  context)),
                                                                  child: WebViewAware(
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        FocusScope.of(dialogContext)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance.primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          OvertimeAttachmentModelWidget(
                                                                        oTRequestID: 0,
                                                                        attachmentList:
                                                                            getJsonField(
                                                                          overtimePendingItem,
                                                                          r'''$.attachmentlist''',
                                                                        )!,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                        },
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                      10.0, 10.0, 0.0, 0.0),
                                                              child: Text(
                                                                valueOrDefault<String>(
                                                                  functions
                                                                      .attachmentCountFunction(
                                                                          (getJsonField(
                                                                        overtimePendingItem,
                                                                        r'''$.attachmentlist''',
                                                                      ) as List)
                                                                              .map<String>((s) =>
                                                                                  s.toString())
                                                                              .toList())
                                                                      .toString(),
                                                                  '0',
                                                                ),
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                      fontFamily:
                                                                          GoogleFonts.readexPro(
                                                                        fontWeight:
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium!
                                                                                .fontWeight,
                                                                        fontStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Theme.of(context)
                                                                          .colorScheme
                                                                          .primary,
                                                                      fontSize: 10.0,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(-1.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        5.0, 10.0, 0.0, 0.0),
                                                                child: Text(
                                                                  FFLocalizations.of(context)
                                                                      .getText(
                                                                    'jwqn0q70' /* attachement */,
                                                                  ),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                        fontFamily:
                                                                            GoogleFonts.readexPro(
                                                                          fontWeight:
                                                                              Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyMedium!
                                                                                  .fontWeight,
                                                                          fontStyle:
                                                                              Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyMedium!
                                                                                  .fontStyle,
                                                                        ),
                                                                        color: Color(0xFFF89D27),
                                                                        fontSize: 10.0,
                                                                        letterSpacing: 0.0,
                                                                        fontWeight:
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium!
                                                                                .fontWeight,
                                                                        fontStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 8.0, 0.0, 0.0),
                                                            child: Text(
                                                              FFLocalizations.of(context).getText(
                                                                'xz78yenc' /* Request date :  */,
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color:
                                                                        AppColors.overtimetextcolor,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              0.0, 8.0, 0.0, 0.0),
                                                          child: Text(
                                                            valueOrDefault<String>(
                                                              functions.changeRequestedDateFormat(
                                                                  getJsonField(
                                                                overtimePendingItem,
                                                                r'''$.oT_Requested_Date''',
                                                              ).toString()),
                                                              'request Date',
                                                            ),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color:
                                                                      AppColors.overtimetextcolor,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: Theme.of(context).colorScheme.surface,
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              0.0, 0.0, 15.0, 0.0),
                                                          child: InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      EditOvertimeRequestWidget(
                                                                    editOTRequest: getJsonField(
                                                                      overtimePendingItem,
                                                                      r'''$''',
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(8.0),
                                                              child: Image.asset(
                                                                'assets/images/edit-rectangle-svgrepo-com_1_(1).png',
                                                                width: 28.0,
                                                                height: 30.0,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Builder(
                                                          builder: (context) => InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              await showDialog(
                                                                context: context,
                                                                builder: (dialogContext) {
                                                                  return Dialog(
                                                                    elevation: 0,
                                                                    insetPadding: EdgeInsets.zero,
                                                                    backgroundColor:
                                                                        Colors.transparent,
                                                                    alignment: AlignmentDirectional(
                                                                            0.0, 0.0)
                                                                        .resolve(Directionality.of(
                                                                            context)),
                                                                    child: WebViewAware(
                                                                      child: GestureDetector(
                                                                        onTap: () {
                                                                          FocusScope.of(
                                                                                  dialogContext)
                                                                              .unfocus();
                                                                          FocusManager
                                                                              .instance.primaryFocus
                                                                              ?.unfocus();
                                                                        },
                                                                        child:
                                                                            DeleteOTRequestDialogWidget(
                                                                          oTID: getJsonField(
                                                                            overtimePendingItem,
                                                                            r'''$.oT_Request_ID''',
                                                                          ).toString(),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(8.0),
                                                              child: Image.asset(
                                                                'assets/images/delete-trash-remove-svgrepo-com_1.png',
                                                                width: 28.0,
                                                                height: 30.0,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 0.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 190.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(4.0),
                                        border: Border.all(
                                          color: Theme.of(context).colorScheme.surface,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.yeardata = dateTimeFormat(
                                            "yyyy",
                                            getCurrentTimestamp,
                                            locale: FFLocalizations.of(context).languageCode,
                                          );
                                          _model.monthData = dateTimeFormat(
                                            "MM",
                                            getCurrentTimestamp,
                                            locale: FFLocalizations.of(context).languageCode,
                                          );
                                          safeSetState(() {});
                                          _model.apiHistoryYearResult =
                                              await MainGroup.getOTRequestByStatusMobileCall.call(
                                            monthNum: dateTimeFormat(
                                              "MM",
                                              getCurrentTimestamp,
                                              locale: FFLocalizations.of(context).languageCode,
                                            ),
                                            yearNum: dateTimeFormat(
                                              "yyyy",
                                              getCurrentTimestamp,
                                              locale: FFLocalizations.of(context).languageCode,
                                            ),
                                            status: 3,
                                            employeeID: AppState().employeeID,
                                            companyID: AppState().companyID,
                                            token: AppState().token,
                                          );

                                          if ((_model.apiHistoryYearResult?.succeeded ?? true)) {
                                            _model.overTimeHistory = getJsonField(
                                              (_model.apiHistoryYearResult?.jsonBody ?? ''),
                                              r'''$.data''',
                                            )!
                                                .toList()
                                                .cast<dynamic>();
                                            safeSetState(() {});
                                          }

                                          safeSetState(() {});
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context).getText(
                                                  'cr9fglcf' /* Month: */,
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontFamily: GoogleFonts.readexPro(
                                                        fontWeight: Theme.of(context)
                                                            .fontFamily
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontWeight,
                                                        fontStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontStyle,
                                                      ).fontFamily,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.color,
                                                      letterSpacing: 0.0,
                                                      fontWeight: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .fontWeight,
                                                      fontStyle: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .fontStyle,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              dateTimeFormat(
                                                "MMM",
                                                getCurrentTimestamp,
                                                locale: FFLocalizations.of(context).languageCode,
                                              ),
                                              style:
                                                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                        fontFamily: GoogleFonts.readexPro(
                                                          fontWeight: Theme.of(context)
                                                              .fontFamily
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontWeight,
                                                          fontStyle: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontStyle,
                                                        ).fontFamily,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.color,
                                                        letterSpacing: 0.0,
                                                        fontWeight: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontWeight,
                                                        fontStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontStyle,
                                                      ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context).getText(
                                                'lmdescbx' /*  Year: */,
                                              ),
                                              style:
                                                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                        fontFamily: GoogleFonts.readexPro(
                                                          fontWeight: Theme.of(context)
                                                              .fontFamily
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontWeight,
                                                          fontStyle: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontStyle,
                                                        ).fontFamily,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.color,
                                                        letterSpacing: 0.0,
                                                        fontWeight: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontWeight,
                                                        fontStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontStyle,
                                                      ),
                                            ),
                                            Text(
                                              dateTimeFormat(
                                                "yyyy",
                                                getCurrentTimestamp,
                                                locale: FFLocalizations.of(context).languageCode,
                                              ),
                                              style:
                                                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                        fontFamily: GoogleFonts.readexPro(
                                                          fontWeight: Theme.of(context)
                                                              .fontFamily
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontWeight,
                                                          fontStyle: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .fontStyle,
                                                        ).fontFamily,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.color,
                                                        letterSpacing: 0.0,
                                                        fontWeight: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontWeight,
                                                        fontStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .fontStyle,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  3.0, 0.0, 0.0, 0.0),
                                              child: Icon(
                                                Icons.calendar_month,
                                                color:
                                                    Theme.of(context).textTheme.bodyMedium?.color,
                                                size: 22.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(-1.0, -1.0),
                                      child: Padding(
                                        padding:
                                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                        child: FlutterFlowDropDown<String>(
                                          options: [
                                            FFLocalizations.of(context).getText(
                                              'civlau0b' /* All */,
                                            ),
                                            FFLocalizations.of(context).getText(
                                              'lemclvgn' /* Approved */,
                                            ),
                                            FFLocalizations.of(context).getText(
                                              'thg5wd89' /* Rejected */,
                                            ),
                                            FFLocalizations.of(context).getText(
                                              'w8p6gfjh' /* Canceled */,
                                            )
                                          ],
                                          onChanged: (val) async {
                                            safeSetState(() => _model.overtimeStatusValue = val);
                                            _model.overTimeHistory = functions
                                                .filteredOvertimeStatusFunction(
                                                    _model.overtimeStatusAllData.toList(),
                                                    _model.overtimeStatusValue!)
                                                .toList()
                                                .cast<dynamic>();
                                            safeSetState(() {});
                                          },
                                          width: 180.0,
                                          height: 40.0,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontFamily: GoogleFonts.readexPro(
                                                  fontWeight: Theme.of(context)
                                                      .fontFamily
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontWeight,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
                                                ).fontFamily,
                                                color:
                                                    Theme.of(context).textTheme.bodyMedium?.color,
                                                letterSpacing: 0.0,
                                                fontWeight: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .fontWeight,
                                                fontStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .fontStyle,
                                              ),
                                          hintText: FFLocalizations.of(context).getText(
                                            'qbx4vm5p' /* All */,
                                          ),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Theme.of(context).textTheme.bodyMedium?.color,
                                            size: 24.0,
                                          ),
                                          fillColor: Theme.of(context).colorScheme.surface,
                                          elevation: 0.0,
                                          borderColor: Theme.of(context).colorScheme.surface,
                                          borderWidth: 1.0,
                                          borderRadius: 4.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                          hidesUnderline: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    final overtimeHistoryList = _model.overTimeHistory.toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: overtimeHistoryList.length,
                                      itemBuilder: (context, overtimeHistoryListIndex) {
                                        final overtimeHistoryListItem =
                                            overtimeHistoryList[overtimeHistoryListIndex];
                                        return Align(
                                          alignment: AlignmentDirectional(-1.0, -1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 5.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 220.0,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.surface,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(13.0),
                                                  bottomRight: Radius.circular(13.0),
                                                  topLeft: Radius.circular(13.0),
                                                  topRight: Radius.circular(13.0),
                                                ),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                      10.0, 8.0, 15.0, 0.0),
                                                              child: Text(
                                                                valueOrDefault<String>(
                                                                  getJsonField(
                                                                    overtimeHistoryListItem,
                                                                    r'''$.workFlow_Name''',
                                                                  )?.toString(),
                                                                  'OT',
                                                                ),
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                      fontFamily:
                                                                          GoogleFonts.readexPro(
                                                                        fontWeight:
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium!
                                                                                .fontWeight,
                                                                        fontStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Color(0xFFF89D27),
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        0.0, 15.0, 20.0, 0.0),
                                                                child: AppButton(
                                                                  onPressed: () {
                                                                    print('Button pressed ...');
                                                                  },
                                                                  text: valueOrDefault<String>(
                                                                    functions
                                                                        .changeLeaveStatusRejectedFunction(
                                                                            getJsonField(
                                                                      overtimeHistoryListItem,
                                                                      r'''$.status''',
                                                                    ).toString()),
                                                                    'status',
                                                                  ),
                                                                  options: FFButtonOptions(
                                                                    height: 30.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            24.0, 0.0, 24.0, 0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                                0.0, 0.0, 0.0, 0.0),
                                                                    color: functions
                                                                        .overtimeStatusBackgroundColor(
                                                                            getJsonField(
                                                                      overtimeHistoryListItem,
                                                                      r'''$.status''',
                                                                    ).toString()),
                                                                    textStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .copyWith(
                                                                          fontFamily: GoogleFonts
                                                                                  .readexPro()
                                                                              .fontFamily,
                                                                          color: functions
                                                                              .overtimeStatusTextColor(
                                                                                  getJsonField(
                                                                            overtimeHistoryListItem,
                                                                            r'''$.status''',
                                                                          ).toString()),
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                    elevation: 3.0,
                                                                    borderSide: BorderSide(
                                                                      color: Colors.transparent,
                                                                      width: 1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(24.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              10.0, 0.0, 0.0, 8.0),
                                                          child: Text(
                                                            FFLocalizations.of(context).getText(
                                                              'r7v6ntp5' /* Amount */,
                                                            ),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium
                                                                      ?.color,
                                                                  fontSize: 12.0,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 0.0, 0.0, 8.0),
                                                            child: Text(
                                                              getJsonField(
                                                                overtimeHistoryListItem,
                                                                r'''$.oT_Hours''',
                                                              ).toString(),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium
                                                                        ?.color,
                                                                    fontSize: 10.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 0.0, 0.0, 8.0),
                                                            child: Text(
                                                              FFLocalizations.of(context).getText(
                                                                '5xpdsimz' /* From  */,
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium
                                                                        ?.color,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(0.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                0.0, 0.0, 0.0, 8.0),
                                                            child: Text(
                                                              valueOrDefault<String>(
                                                                functions
                                                                    .changeDateFormat(getJsonField(
                                                                  overtimeHistoryListItem,
                                                                  r'''$.start_Date''',
                                                                ).toString()),
                                                                'Start Date',
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              0.0, 0.0, 0.0, 8.0),
                                                          child: Text(
                                                            FFLocalizations.of(context).getText(
                                                              '5jtj22ue' /*  - */,
                                                            ),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              5.0, 0.0, 0.0, 8.0),
                                                          child: Text(
                                                            valueOrDefault<String>(
                                                              functions.changeDateFormat(
                                                                  valueOrDefault<String>(
                                                                getJsonField(
                                                                  overtimeHistoryListItem,
                                                                  r'''$.end_Date''',
                                                                )?.toString(),
                                                                'End Date',
                                                              )),
                                                              'End Date',
                                                            ),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 0.0, 0.0, 0.0),
                                                            child: Text(
                                                              FFLocalizations.of(context).getText(
                                                                '1rndbtas' /* Note :  */,
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize: 10.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          getJsonField(
                                                            overtimeHistoryListItem,
                                                            r'''$.purpose_OT''',
                                                          ).toString(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                fontFamily: GoogleFonts.readexPro(
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing: 0.0,
                                                                fontWeight: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                                fontStyle: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    Builder(
                                                      builder: (context) => Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                            0.0, 10.0, 0.0, 0.0),
                                                        child: InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          onTap: () async {
                                                            if ((getJsonField(
                                                              overtimeHistoryListItem,
                                                              r'''$.attachmentlist''',
                                                            )
                                                                        .toList()
                                                                        .map<AttachmentFileModelStruct?>(
                                                                            AttachmentFileModelStruct
                                                                                .maybeFromMap)
                                                                        .toList()
                                                                    as Iterable<
                                                                        AttachmentFileModelStruct?>)
                                                                .withoutNulls
                                                                .isNotEmpty) {
                                                              await showDialog(
                                                                context: context,
                                                                builder: (dialogContext) {
                                                                  return Dialog(
                                                                    elevation: 0,
                                                                    insetPadding: EdgeInsets.zero,
                                                                    backgroundColor:
                                                                        Colors.transparent,
                                                                    alignment: AlignmentDirectional(
                                                                            0.0, 0.0)
                                                                        .resolve(Directionality.of(
                                                                            context)),
                                                                    child: WebViewAware(
                                                                      child: GestureDetector(
                                                                        onTap: () {
                                                                          FocusScope.of(
                                                                                  dialogContext)
                                                                              .unfocus();
                                                                          FocusManager
                                                                              .instance.primaryFocus
                                                                              ?.unfocus();
                                                                        },
                                                                        child:
                                                                            OvertimeAttachmentModelWidget(
                                                                          oTRequestID: 0,
                                                                          attachmentList:
                                                                              getJsonField(
                                                                            overtimeHistoryListItem,
                                                                            r'''$.attachmentlist''',
                                                                          )!,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            }
                                                          },
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        10.0, 0.0, 0.0, 0.0),
                                                                child: Text(
                                                                  valueOrDefault<String>(
                                                                    functions
                                                                        .attachmentCountFunction(
                                                                            (getJsonField(
                                                                          overtimeHistoryListItem,
                                                                          r'''$.attachmentlist''',
                                                                        ) as List)
                                                                                .map<String>((s) =>
                                                                                    s.toString())
                                                                                .toList())
                                                                        .toString(),
                                                                    '0',
                                                                  ),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                        fontFamily:
                                                                            GoogleFonts.readexPro(
                                                                          fontWeight:
                                                                              Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyMedium!
                                                                                  .fontWeight,
                                                                          fontStyle:
                                                                              Theme.of(context)
                                                                                  .textTheme
                                                                                  .bodyMedium!
                                                                                  .fontStyle,
                                                                        ),
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .primary,
                                                                        fontSize: 10.0,
                                                                        letterSpacing: 0.0,
                                                                        fontWeight:
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium!
                                                                                .fontWeight,
                                                                        fontStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment: AlignmentDirectional(
                                                                    -1.0, -1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                  child: Text(
                                                                    FFLocalizations.of(context)
                                                                        .getText(
                                                                      '3gws8bfa' /* attachement */,
                                                                    ),
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .copyWith(
                                                                          fontFamily: GoogleFonts
                                                                                  .readexPro()
                                                                              .fontFamily,
                                                                          color: Color(0xFFF89D27),
                                                                          fontSize: 10.0,
                                                                          letterSpacing: 0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(-1.0, -1.0),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                10.0, 8.0, 0.0, 0.0),
                                                            child: Text(
                                                              FFLocalizations.of(context).getText(
                                                                '1sinmk3w' /* Request date :  */,
                                                              ),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium
                                                                        ?.color,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              0.0, 8.0, 0.0, 0.0),
                                                          child: Text(
                                                            valueOrDefault<String>(
                                                              functions.changeRequestedDateFormat(
                                                                  getJsonField(
                                                                overtimeHistoryListItem,
                                                                r'''$.oT_Requested_Date''',
                                                              ).toString()),
                                                              'Request Date',
                                                            ),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontFamily: GoogleFonts.readexPro(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: Theme.of(context).colorScheme.surface,
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                      10.0, 0.0, 0.0, 0.0),
                                                              child: Text(
                                                                FFLocalizations.of(context).getText(
                                                                  't30bpyvi' /* Approved by :  */,
                                                                ),
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                      fontFamily:
                                                                          GoogleFonts.readexPro(
                                                                        fontWeight:
                                                                            Theme.of(context)
                                                                                .textTheme
                                                                                .bodyMedium!
                                                                                .fontWeight,
                                                                        fontStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                      fontSize: 12.0,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            Text(
                                                              getJsonField(
                                                                overtimeHistoryListItem,
                                                                r'''$.approver_Name''',
                                                              ).toString(),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontFamily:
                                                                        GoogleFonts.readexPro(
                                                                      fontWeight: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize: 12.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
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
            ],
          ),
        ),
      ),
    );
  }
}
