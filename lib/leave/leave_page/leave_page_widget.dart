import 'package:hr_optimistic/core/theme/app_theme_extension.dart';
import '../core/widgets/app_widgets.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/delete_leave_request_dialog/delete_leave_request_dialog_widget.dart';
import '/components/leave_attachment_model/leave_attachment_model_widget.dart';
import '../core/widgets/app_icon_button.dart';;
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import '../core/widgets/app_button.dart';;
import '/backend/schema/structs/index.dart';
import 'package:hr_app/core/utils/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'leave_page_model.dart';
export 'leave_page_model.dart';

class LeavePageWidget extends StatefulWidget {
  const LeavePageWidget({super.key});

  static String routeName = 'LeavePage';
  static String routePath = '/leavePage';

  @override
  State<LeavePageWidget> createState() => _LeavePageWidgetState();
}

class _LeavePageWidgetState extends State<LeavePageWidget>
    with TickerProviderStateMixin {
  late LeavePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LeavePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResutleaveList =
          await MainGroup.getTimeOffRequestByCompanyIdPaginationCall.call(
        monthNum: 13,
        yearNum: functions.leaveforYearCustomFunction(),
        employeeID: AppState().employeeID,
        companyID: AppState().companyID,
        requesterID: AppState().reportID,
        leaveTypeID: _model.leaveTypeID,
        status: 'All',
        perpage: 1000,
        page: 1,
        token: AppState().token,
      );

      if ((_model.apiResutleaveList?.succeeded ?? true)) {
        _model.allLeaveListView =
            MainGroup.getTimeOffRequestByCompanyIdPaginationCall
                .dataResult(
                  (_model.apiResutleaveList?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
        safeSetState(() {});
      }
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
    context.watch<AppState>();

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
              Navigator.of(context).pushNamed(HomeWidget.routeName);
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'o10rjd0l' /* Leave */,
            ),
            style: Theme.of(context).textTheme.$1?.copyWith(
                  font: GoogleFonts.outfit(
                    fontWeight:
                        context.headlineMedium.fontWeight,
                    fontStyle:
                        context.headlineMedium.fontStyle,
                  ),
                  color: Theme.of(context).colorScheme.secondaryText,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      context.headlineMedium.fontWeight,
                  fontStyle:
                      context.headlineMedium.fontStyle,
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
                  Navigator.of(context).pushNamed(LeaveRequestWidget.routeName);
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
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1.0, -1.0),
                      child: AppButton(
                        onPressed: () async {
                          _model.leaveTypeID = 0;
                          _model.leavedayCount = null;
                          safeSetState(() {});
                        },
                        text: FFLocalizations.of(context).getText(
                          'ahy2odf8' /* All */,
                        ),
                        options: FFButtonOptions(
                          height: 35.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: _model.leaveTypeID == 0
                              ? Color(0xFFF89D27)
                              : FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: GoogleFonts.readexPro(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: _model.leaveTypeID == 0
                                    ? FlutterFlowTheme.of(context)
                                        .secondaryBackground
                                    : Theme.of(context).colorScheme.primaryText,
                                fontSize: 14.0,
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
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                        ),
                        child: FutureBuilder<ApiCallResponse>(
                          future: MainGroup.getLeaveWithRemainingDaysCall.call(
                            companyIDMain: AppState().companyID,
                            employeeIDMain: AppState().employeeID,
                            token: AppState().token,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final listViewGetLeaveWithRemainingDaysResponse =
                                snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final getLeaveWithRemainingDaysList =
                                    MainGroup.getLeaveWithRemainingDaysCall
                                            .leaveTypeList(
                                              listViewGetLeaveWithRemainingDaysResponse
                                                  .jsonBody,
                                            )
                                            ?.toList() ??
                                        [];

                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      getLeaveWithRemainingDaysList.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(width: 10.0),
                                  itemBuilder: (context,
                                      getLeaveWithRemainingDaysListIndex) {
                                    final getLeaveWithRemainingDaysListItem =
                                        getLeaveWithRemainingDaysList[
                                            getLeaveWithRemainingDaysListIndex];
                                    return Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.leaveTypeID = getJsonField(
                                              getLeaveWithRemainingDaysListItem,
                                              r'''$.timeOff_ID''',
                                            );
                                            _model.leavedayCount = functions
                                                        .getDaysLeftFunction(
                                                            getJsonField(
                                                      getLeaveWithRemainingDaysListItem,
                                                      r'''$.leaveDaysLeft''',
                                                    ).toString()) ==
                                                    '0'
                                                ? '0'
                                                : functions.getDaysLeftFunction(
                                                    getJsonField(
                                                    getLeaveWithRemainingDaysListItem,
                                                    r'''$.leaveDaysLeft''',
                                                  ).toString());
                                            safeSetState(() {});
                                          },
                                          child: Container(
                                            width: 150.0,
                                            height: 85.0,
                                            decoration: BoxDecoration(
                                              color: _model.leaveTypeID ==
                                                      getJsonField(
                                                        getLeaveWithRemainingDaysListItem,
                                                        r'''$.timeOff_ID''',
                                                      )
                                                  ? Color(0xFFF9B052)
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 8.0,
                                                                0.0, 8.0),
                                                    child: Text(
                                                      getJsonField(
                                                        getLeaveWithRemainingDaysListItem,
                                                        r'''$.timeoff_TypeEN''',
                                                      ).toString(),
                                                      maxLines: 2,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, -1.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.asset(
                                                            'assets/images/Group_9084.png',
                                                            width: 38.0,
                                                            height: 35.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  1.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        13.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              getJsonField(
                                                                getLeaveWithRemainingDaysListItem,
                                                                r'''$.leaveDaysLeft''',
                                                              ).toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        12.0,
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
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(0.0, 0),
                      child: FlutterFlowButtonTabBar(
                        useToggleButtonStyle: false,
                        labelStyle:
                            Theme.of(context).textTheme.$1?.copyWith(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                        unselectedLabelStyle: TextStyle(),
                        labelColor:
                            Theme.of(context).colorScheme.secondaryBackground,
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.primary,
                        backgroundColor: Color(0xFFF9B052),
                        unselectedBackgroundColor:
                            FlutterFlowTheme.of(context).greyTitle,
                        borderColor: Theme.of(context).colorScheme.primary,
                        unselectedBorderColor:
                            Theme.of(context).colorScheme.secondaryBackground,
                        borderWidth: 2.0,
                        borderRadius: 8.0,
                        elevation: 0.0,
                        padding: EdgeInsets.all(8.0),
                        tabs: [
                          Tab(
                            text: 'Year : ${dateTimeFormat(
                              "yyyy",
                              getCurrentTimestamp,
                              locale: FFLocalizations.of(context).languageCode,
                            )}',
                          ),
                          Tab(
                            text: FFLocalizations.of(context).getText(
                              'bpdvfdln' /* Pending */,
                            ),
                          ),
                          Tab(
                            text: FFLocalizations.of(context).getText(
                              'ylkl8j2i' /* History */,
                            ),
                          ),
                        ],
                        controller: _model.tabBarController,
                        onTap: (i) async {
                          [() async {}, () async {}, () async {}][i]();
                        },
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if ((_model.leavedayCount == '0') &&
                                  (_model.leaveTypeID != 0))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'tkxntmcu' /* No Data Available */,
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
                              if (_model.leavedayCount != '0')
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 5.0, 5.0, 0.0),
                                    child: FutureBuilder<ApiCallResponse>(
                                      future: MainGroup
                                          .getTimeOffRequestByCompanyIdPaginationCall
                                          .call(
                                        monthNum: 13,
                                        yearNum: functions
                                            .leaveforYearCustomFunction(),
                                        employeeID: AppState().employeeID,
                                        companyID: AppState().companyID,
                                        requesterID: AppState().reportID,
                                        leaveTypeID: _model.leaveTypeID,
                                        status: 'All',
                                        perpage: 300,
                                        page: 1,
                                        token: AppState().token,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .themeColor,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final listViewGetTimeOffRequestByCompanyIdPaginationResponse =
                                            snapshot.data!;

                                        return Builder(
                                          builder: (context) {
                                            final yearforLeave = MainGroup
                                                    .getTimeOffRequestByCompanyIdPaginationCall
                                                    .dataResult(
                                                      listViewGetTimeOffRequestByCompanyIdPaginationResponse
                                                          .jsonBody,
                                                    )
                                                    ?.toList() ??
                                                [];
                                            if (yearforLeave.isEmpty) {
                                              return Image.asset(
                                                '',
                                              );
                                            }

                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: yearforLeave.length,
                                              itemBuilder:
                                                  (context, yearforLeaveIndex) {
                                                final yearforLeaveItem =
                                                    yearforLeave[
                                                        yearforLeaveIndex];
                                                return SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, -1.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      8.0,
                                                                      0.0,
                                                                      8.0,
                                                                      5.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 220.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        13.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        13.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        13.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        13.0),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              8.0,
                                                                              15.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              getJsonField(
                                                                                yearforLeaveItem,
                                                                                r'''$.timeoff_Name''',
                                                                              )?.toString(),
                                                                              'LeaveName',
                                                                            ),
                                                                            style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                  font: GoogleFonts.readexPro(
                                                                                    fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                    fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: Color(0xFFF9B052),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              15.0,
                                                                              15.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100.0,
                                                                            height:
                                                                                25.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: functions.leaveStatusBackgroundColor(getJsonField(
                                                                                yearforLeaveItem,
                                                                                r'''$.status''',
                                                                              ).toString()),
                                                                              borderRadius: BorderRadius.circular(24.0),
                                                                            ),
                                                                            child:
                                                                                Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: Text(
                                                                                valueOrDefault<String>(
                                                                                  functions.changeLeaveStatusPendingFunction(getJsonField(
                                                                                    yearforLeaveItem,
                                                                                    r'''$.status''',
                                                                                  ).toString()),
                                                                                  'status',
                                                                                ),
                                                                                style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                      font: GoogleFonts.readexPro(
                                                                                        fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                        fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: functions.leaveStatusTextColor(getJsonField(
                                                                                        yearforLeaveItem,
                                                                                        r'''$.status''',
                                                                                      ).toString()),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                      fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'm89ulbz6' /* Amount */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                                color: Theme.of(context).colorScheme.secondaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          5.0,
                                                                          8.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions.leaveDayAmountFunction(
                                                                              getJsonField(
                                                                                yearforLeaveItem,
                                                                                r'''$.start_Date''',
                                                                              ).toString(),
                                                                              getJsonField(
                                                                                yearforLeaveItem,
                                                                                r'''$.end_Date''',
                                                                              ).toString(),
                                                                              getJsonField(
                                                                                yearforLeaveItem,
                                                                                r'''$.start_Time''',
                                                                              ).toString(),
                                                                              getJsonField(
                                                                                yearforLeaveItem,
                                                                                r'''$.end_Time''',
                                                                              ).toString()),
                                                                          'leaveAmount',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Theme.of(context).colorScheme.secondaryText,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'ljcb9h46' /* From  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                                color: Theme.of(context).colorScheme.secondaryText,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          8.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions
                                                                              .changeDateFormat(valueOrDefault<String>(
                                                                            getJsonField(
                                                                              yearforLeaveItem,
                                                                              r'''$.start_Date''',
                                                                            )?.toString(),
                                                                            'startDate',
                                                                          )),
                                                                          'start date',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Theme.of(context).colorScheme.secondaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          8.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '4mpgd3tg' /*  - */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Theme.of(context).colorScheme.secondaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          8.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions
                                                                              .changeDateFormat(getJsonField(
                                                                            yearforLeaveItem,
                                                                            r'''$.end_Date''',
                                                                          ).toString()),
                                                                          'end date',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Theme.of(context).colorScheme.secondaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'ywbamyv2' /* Note :  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                                color: Theme.of(context).colorScheme.secondaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        getJsonField(
                                                                          yearforLeaveItem,
                                                                          r'''$.message''',
                                                                        )?.toString(),
                                                                        'leaveNote',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Builder(
                                                                  builder:
                                                                      (context) =>
                                                                          Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        if ((getJsonField(
                                                                          yearforLeaveItem,
                                                                          r'''$.attachmentList''',
                                                                        ).toList().map<LeaveAttachmentListStruct?>(LeaveAttachmentListStruct.maybeFromMap).toList()
                                                                                as Iterable<LeaveAttachmentListStruct?>)
                                                                            .withoutNulls
                                                                            .isNotEmpty) {
                                                                          await showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (dialogContext) {
                                                                              return Dialog(
                                                                                elevation: 0,
                                                                                insetPadding: EdgeInsets.zero,
                                                                                backgroundColor: Colors.transparent,
                                                                                alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                child: WebViewAware(
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      FocusScope.of(dialogContext).unfocus();
                                                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                                                    },
                                                                                    child: LeaveAttachmentModelWidget(
                                                                                      attachmentListJson: getJsonField(
                                                                                        yearforLeaveItem,
                                                                                        r'''$.attachmentList''',
                                                                                        true,
                                                                                      )!,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                valueOrDefault<String>(
                                                                                  functions.attachmentCountFunction((getJsonField(
                                                                                    yearforLeaveItem,
                                                                                    r'''$.attachmentList''',
                                                                                    true,
                                                                                  ) as List)
                                                                                      .map<String>((s) => s.toString())
                                                                                      .toList()),
                                                                                  '0',
                                                                                ),
                                                                                style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                      font: GoogleFonts.readexPro(
                                                                                        fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                        fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: Color(0xFFF9B052),
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                      fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, -1.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  'pk0gkjsa' /* attachement */,
                                                                                ),
                                                                                style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                      font: GoogleFonts.readexPro(
                                                                                        fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                        fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: Color(0xFFF9B052),
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                      fontStyle: context.textTheme.bodyMedium.fontStyle,
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
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            8.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '4auid072' /* Request date :  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                                color: Theme.of(context).colorScheme.secondaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions
                                                                              .changeRequestedDateFormat(getJsonField(
                                                                            yearforLeaveItem,
                                                                            r'''$.request_On''',
                                                                          ).toString()),
                                                                          'Request date',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Theme.of(context).colorScheme.secondaryText,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1.0,
                                                                          1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              functions.changeLeaveStatusRejectedFunction(getJsonField(
                                                                                yearforLeaveItem,
                                                                                r'''$.status''',
                                                                              ).toString()),
                                                                              'Supervisor',
                                                                            ),
                                                                            style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                  font: GoogleFonts.readexPro(
                                                                                    fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                    fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: Theme.of(context).colorScheme.secondaryText,
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'x059z4y4' /* by : */,
                                                                            ),
                                                                            style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                  font: GoogleFonts.readexPro(
                                                                                    fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                    fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: Theme.of(context).colorScheme.secondaryText,
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              getJsonField(
                                                                                yearforLeaveItem,
                                                                                r'''$.approver_Name''',
                                                                              )?.toString(),
                                                                              'ApproverName',
                                                                            ),
                                                                            style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                  font: GoogleFonts.readexPro(
                                                                                    fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                    fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: Theme.of(context).colorScheme.secondaryText,
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
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
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 5.0, 5.0, 0.0),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: MainGroup
                                        .getTimeOffRequestByCompanyIdPaginationCall
                                        .call(
                                      monthNum: 13,
                                      yearNum: functions
                                          .leaveforYearCustomFunction(),
                                      employeeID: AppState().employeeID,
                                      companyID: AppState().companyID,
                                      requesterID: AppState().reportID,
                                      leaveTypeID: _model.leaveTypeID,
                                      status: 'All',
                                      perpage: 1000,
                                      page: 1,
                                      token: AppState().token,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .themeColor,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final listViewGetTimeOffRequestByCompanyIdPaginationResponse =
                                          snapshot.data!;

                                      return Builder(
                                        builder: (context) {
                                          final leaveStatusPending = MainGroup
                                                  .getTimeOffRequestByCompanyIdPaginationCall
                                                  .dataResult(
                                                    listViewGetTimeOffRequestByCompanyIdPaginationResponse
                                                        .jsonBody,
                                                  )
                                                  ?.where((e) =>
                                                      'Waiting Approval' ==
                                                      getJsonField(
                                                        e,
                                                        r'''$.status''',
                                                      ).toString())
                                                  .toList()
                                                  .toList() ??
                                              [];
                                          if (leaveStatusPending.isEmpty) {
                                            return Image.asset(
                                              '',
                                            );
                                          }

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                leaveStatusPending.length,
                                            itemBuilder: (context,
                                                leaveStatusPendingIndex) {
                                              final leaveStatusPendingItem =
                                                  leaveStatusPending[
                                                      leaveStatusPendingIndex];
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, -1.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  8.0,
                                                                  5.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 220.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    13.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    13.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    13.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    13.0),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          8.0,
                                                                          15.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            leaveStatusPendingItem,
                                                                            r'''$.timeoff_Name''',
                                                                          )?.toString(),
                                                                          'leave Type',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Color(0xFFF9B052),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          15.0,
                                                                          15.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            100.0,
                                                                        height:
                                                                            35.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFFDAE3F3),
                                                                          borderRadius:
                                                                              BorderRadius.circular(24.0),
                                                                        ),
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              functions.changeLeaveStatusPendingFunction(getJsonField(
                                                                                leaveStatusPendingItem,
                                                                                r'''$.status''',
                                                                              ).toString()),
                                                                              'status',
                                                                            ),
                                                                            style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                  font: GoogleFonts.readexPro(
                                                                                    fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                    fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: Color(0xFF21A8D6),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'y06o4her' /* Amount */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondaryText,
                                                                            fontSize:
                                                                                10.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          5.0,
                                                                          8.0),
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions.leaveDayAmountFunction(
                                                                          getJsonField(
                                                                            leaveStatusPendingItem,
                                                                            r'''$.start_Date''',
                                                                          ).toString(),
                                                                          getJsonField(
                                                                            leaveStatusPendingItem,
                                                                            r'''$.end_Date''',
                                                                          ).toString(),
                                                                          getJsonField(
                                                                            leaveStatusPendingItem,
                                                                            r'''$.start_Time''',
                                                                          ).toString(),
                                                                          getJsonField(
                                                                            leaveStatusPendingItem,
                                                                            r'''$.end_Time''',
                                                                          ).toString()),
                                                                      'leave amount',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Theme.of(context).colorScheme.secondaryText,
                                                                          fontSize:
                                                                              10.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'i8hs16h9' /* From  */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          8.0),
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions
                                                                          .changeDateFormat(
                                                                              getJsonField(
                                                                        leaveStatusPendingItem,
                                                                        r'''$.start_Date''',
                                                                      ).toString()),
                                                                      'start date',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Theme.of(context).colorScheme.secondaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          8.0),
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '2zfl2kam' /*  - */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Theme.of(context).colorScheme.secondaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          8.0),
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions
                                                                          .changeDateFormat(
                                                                              getJsonField(
                                                                        leaveStatusPendingItem,
                                                                        r'''$.end_Date''',
                                                                      ).toString()),
                                                                      'end date',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Theme.of(context).colorScheme.secondaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '9qsxmgnq' /* Note :  */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondaryText,
                                                                            fontSize:
                                                                                10.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      leaveStatusPendingItem,
                                                                      r'''$.message''',
                                                                    )?.toString(),
                                                                    'Note',
                                                                  ),
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
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
                                                            Builder(
                                                              builder:
                                                                  (context) =>
                                                                      Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
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
                                                                    if ((getJsonField(
                                                                      leaveStatusPendingItem,
                                                                      r'''$.attachmentList''',
                                                                    ).toList().map<LeaveAttachmentListStruct?>(LeaveAttachmentListStruct.maybeFromMap).toList()
                                                                            as Iterable<LeaveAttachmentListStruct?>)
                                                                        .withoutNulls
                                                                        .isNotEmpty) {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Dialog(
                                                                            elevation:
                                                                                0,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                            child:
                                                                                WebViewAware(
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  FocusScope.of(dialogContext).unfocus();
                                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                                },
                                                                                child: LeaveAttachmentModelWidget(
                                                                                  attachmentListJson: getJsonField(
                                                                                    leaveStatusPendingItem,
                                                                                    r'''$.attachmentList''',
                                                                                    true,
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
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              functions.attachmentCountFunction((getJsonField(
                                                                                leaveStatusPendingItem,
                                                                                r'''$.attachmentList''',
                                                                                true,
                                                                              ) as List)
                                                                                  .map<String>((s) => s.toString())
                                                                                  .toList()),
                                                                              '0',
                                                                            ),
                                                                            style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                  font: GoogleFonts.readexPro(
                                                                                    fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                    fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: Color(0xFFF9B052),
                                                                                  fontSize: 10.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              '2atwuidd' /* attachement */,
                                                                            ),
                                                                            style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                  font: GoogleFonts.readexPro(
                                                                                    fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                    fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: Color(0xFFF9B052),
                                                                                  fontSize: 10.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
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
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            8.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '8j7l3fdo' /* Request date :  */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).overtimetextcolor,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions
                                                                          .changeRequestedDateFormat(
                                                                              getJsonField(
                                                                        leaveStatusPendingItem,
                                                                        r'''$.request_On''',
                                                                      ).toString()),
                                                                      'request date',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).overtimetextcolor,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      1.0, 1.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          5.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          context
                                                                              .pushNamed(
                                                                            LeaveRequestEditMainWidget.routeName,
                                                                            queryParameters:
                                                                                {
                                                                              'editLeaveRequest': serializeParam(
                                                                                getJsonField(
                                                                                  leaveStatusPendingItem,
                                                                                  r'''$''',
                                                                                ),
                                                                                ParamType.JSON,
                                                                              ),
                                                                            }.withoutNulls,
                                                                          );
                                                                        },
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/edit-rectangle-svgrepo-com_1.png',
                                                                            width:
                                                                                28.0,
                                                                            height:
                                                                                30.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Builder(
                                                                      builder:
                                                                          (context) =>
                                                                              Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            await showDialog(
                                                                              context: context,
                                                                              builder: (dialogContext) {
                                                                                return Dialog(
                                                                                  elevation: 0,
                                                                                  insetPadding: EdgeInsets.zero,
                                                                                  backgroundColor: Colors.transparent,
                                                                                  alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                  child: WebViewAware(
                                                                                    child: GestureDetector(
                                                                                      onTap: () {
                                                                                        FocusScope.of(dialogContext).unfocus();
                                                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                                                      },
                                                                                      child: DeleteLeaveRequestDialogWidget(
                                                                                        timeOffRequestID: getJsonField(
                                                                                          leaveStatusPendingItem,
                                                                                          r'''$.time_off_RequestID''',
                                                                                        ),
                                                                                        reason: getJsonField(
                                                                                          leaveStatusPendingItem,
                                                                                          r'''$.reason''',
                                                                                        ).toString(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images/delete-trash-remove-svgrepo-com_1.png',
                                                                              width: 28.0,
                                                                              height: 30.0,
                                                                              fit: BoxFit.cover,
                                                                            ),
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
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (_model.leavedayCount == '0')
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'q1oxvbj1' /* No Data Available */,
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
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              if (_model.leavedayCount != '0')
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 5.0, 5.0, 0.0),
                                    child: FutureBuilder<ApiCallResponse>(
                                      future: MainGroup
                                          .getTimeOffRequestByCompanyIdPaginationCall
                                          .call(
                                        monthNum: 13,
                                        yearNum: functions
                                            .leaveforYearCustomFunction(),
                                        employeeID: AppState().employeeID,
                                        companyID: AppState().companyID,
                                        requesterID: AppState().reportID,
                                        leaveTypeID: _model.leaveTypeID,
                                        status: 'All',
                                        perpage: 1000000,
                                        page: 1,
                                        token: AppState().token,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .themeColor,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final listViewGetTimeOffRequestByCompanyIdPaginationResponse =
                                            snapshot.data!;

                                        return Builder(
                                          builder: (context) {
                                            final leaveHistory = MainGroup
                                                    .getTimeOffRequestByCompanyIdPaginationCall
                                                    .dataResult(
                                                      listViewGetTimeOffRequestByCompanyIdPaginationResponse
                                                          .jsonBody,
                                                    )
                                                    ?.where((e) =>
                                                        valueOrDefault<bool>(
                                                          ('Approved' ==
                                                                  getJsonField(
                                                                    e,
                                                                    r'''$.status''',
                                                                  ).toString()) ||
                                                              ('Denied' ==
                                                                  getJsonField(
                                                                    e,
                                                                    r'''$.status''',
                                                                  ).toString()) ||
                                                              ('Canceled' ==
                                                                  getJsonField(
                                                                    e,
                                                                    r'''$.status''',
                                                                  ).toString()),
                                                          true,
                                                        ))
                                                    .toList()
                                                    .toList() ??
                                                [];
                                            if (leaveHistory.isEmpty) {
                                              return Image.asset(
                                                '',
                                              );
                                            }

                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: leaveHistory.length,
                                              itemBuilder:
                                                  (context, leaveHistoryIndex) {
                                                final leaveHistoryItem =
                                                    leaveHistory[
                                                        leaveHistoryIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    0.0,
                                                                    8.0,
                                                                    5.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 220.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      13.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          13.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      13.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      13.0),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            8.0,
                                                                            15.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            getJsonField(
                                                                              leaveHistoryItem,
                                                                              r'''$.timeoff_Name''',
                                                                            )?.toString(),
                                                                            'LeaveName',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                                color: Color(0xFFF9B052),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            15.0,
                                                                            15.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              25.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                functions.leaveStatusBackgroundColor(getJsonField(
                                                                              leaveHistoryItem,
                                                                              r'''$.status''',
                                                                            ).toString()),
                                                                            borderRadius:
                                                                                BorderRadius.circular(24.0),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                functions.changeLeaveStatusRejectedFunction(getJsonField(
                                                                                  leaveHistoryItem,
                                                                                  r'''$.status''',
                                                                                ).toString()),
                                                                                'status',
                                                                              ),
                                                                              style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                      fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: functions.leaveStatusTextColor(getJsonField(
                                                                                      leaveHistoryItem,
                                                                                      r'''$.status''',
                                                                                    ).toString()),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                    fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            -1.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          8.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'v8dvycp8' /* Amount */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Theme.of(context).colorScheme.secondaryText,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            5.0,
                                                                            8.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        functions.leaveDayAmountFunction(
                                                                            getJsonField(
                                                                              leaveHistoryItem,
                                                                              r'''$.start_Date''',
                                                                            ).toString(),
                                                                            getJsonField(
                                                                              leaveHistoryItem,
                                                                              r'''$.end_Date''',
                                                                            ).toString(),
                                                                            getJsonField(
                                                                              leaveHistoryItem,
                                                                              r'''$.start_Time''',
                                                                            ).toString(),
                                                                            getJsonField(
                                                                              leaveHistoryItem,
                                                                              r'''$.end_Time''',
                                                                            ).toString()),
                                                                        'leaveAmount',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            -1.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          8.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '96f7xk34' /* From  */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Theme.of(context).colorScheme.secondaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        functions
                                                                            .changeDateFormat(valueOrDefault<String>(
                                                                          getJsonField(
                                                                            leaveHistoryItem,
                                                                            r'''$.start_Date''',
                                                                          )?.toString(),
                                                                          'startDate',
                                                                        )),
                                                                        'start date',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '04eqg811' /*  - */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        functions
                                                                            .changeDateFormat(getJsonField(
                                                                          leaveHistoryItem,
                                                                          r'''$.end_Date''',
                                                                        ).toString()),
                                                                        'end date',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            -1.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'z2sb05v7' /* Note :  */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Theme.of(context).colorScheme.secondaryText,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      getJsonField(
                                                                        leaveHistoryItem,
                                                                        r'''$.message''',
                                                                      )?.toString(),
                                                                      'leaveNote',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Theme.of(context).colorScheme.secondaryText,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
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
                                                              Builder(
                                                                builder:
                                                                    (context) =>
                                                                        Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      if ((getJsonField(
                                                                        leaveHistoryItem,
                                                                        r'''$.attachmentList''',
                                                                      ).toList().map<LeaveAttachmentListStruct?>(LeaveAttachmentListStruct.maybeFromMap).toList()
                                                                              as Iterable<LeaveAttachmentListStruct?>)
                                                                          .withoutNulls
                                                                          .isNotEmpty) {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (dialogContext) {
                                                                            return Dialog(
                                                                              elevation: 0,
                                                                              insetPadding: EdgeInsets.zero,
                                                                              backgroundColor: Colors.transparent,
                                                                              alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                              child: WebViewAware(
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    FocusScope.of(dialogContext).unfocus();
                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                  },
                                                                                  child: LeaveAttachmentModelWidget(
                                                                                    attachmentListJson: getJsonField(
                                                                                      leaveHistoryItem,
                                                                                      r'''$.attachmentList''',
                                                                                      true,
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
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                10.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                functions.attachmentCountFunction((getJsonField(
                                                                                  leaveHistoryItem,
                                                                                  r'''$.attachmentList''',
                                                                                  true,
                                                                                ) as List)
                                                                                    .map<String>((s) => s.toString())
                                                                                    .toList()),
                                                                                '0',
                                                                              ),
                                                                              style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                      fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: Color(0xFFF9B052),
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                    fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              -1.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                '2kiboccb' /* attachement */,
                                                                              ),
                                                                              style: Theme.of(context).textTheme.$1?.copyWith(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                      fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: Color(0xFFF9B052),
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                    fontStyle: context.textTheme.bodyMedium.fontStyle,
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
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            -1.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'aoltyjqv' /* Request date :  */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Theme.of(context).colorScheme.secondaryText,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        functions
                                                                            .changeRequestedDateFormat(getJsonField(
                                                                          leaveHistoryItem,
                                                                          r'''$.request_On''',
                                                                        ).toString()),
                                                                        'Request date',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Theme.of(context).colorScheme.secondaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          10.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            functions.changeLeaveStatusRejectedFunction(getJsonField(
                                                                              leaveHistoryItem,
                                                                              r'''$.status''',
                                                                            ).toString()),
                                                                            'Supervisor',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                                color: Theme.of(context).colorScheme.secondaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'jkr24xck' /* by : */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                                color: Theme.of(context).colorScheme.secondaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            getJsonField(
                                                                              leaveHistoryItem,
                                                                              r'''$.approver_Name''',
                                                                            )?.toString(),
                                                                            'ApproverName',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                                color: Theme.of(context).colorScheme.secondaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
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
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
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
            ],
          ),
        ),
      ),
    );
  }
}
