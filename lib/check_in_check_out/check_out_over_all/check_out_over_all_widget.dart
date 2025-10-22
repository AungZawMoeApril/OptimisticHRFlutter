import 'package:hr_optimistic/core/theme/app_theme_extension.dart';
import '../core/widgets/app_widgets.dart';
import '/backend/api_requests/api_calls.dart';
import '../core/widgets/app_icon_button.dart';;
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import '../core/widgets/app_button.dart';;
import 'package:hr_app/core/utils/upload_data.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:hr_app/core/utils/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'check_out_over_all_model.dart';
export 'check_out_over_all_model.dart';

class CheckOutOverAllWidget extends StatefulWidget {
  const CheckOutOverAllWidget({
    super.key,
    this.timeType,
  });

  final String? timeType;

  static String routeName = 'CheckOutOverAll';
  static String routePath = '/checkOutOverAll';

  @override
  State<CheckOutOverAllWidget> createState() => _CheckOutOverAllWidgetState();
}

class _CheckOutOverAllWidgetState extends State<CheckOutOverAllWidget> {
  late CheckOutOverAllModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckOutOverAllModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      await Future.wait([
        Future(() async {
          _model.apiResultLocation =
              await MainGroup.getAllLocationsByCompanyIDCall.call(
            companyID: AppState().companyID,
            token: AppState().token,
          );

          if ((_model.apiResultLocation?.succeeded ?? true)) {
            if ('true' ==
                getJsonField(
                  (_model.apiResultLocation?.jsonBody ?? ''),
                  r'''$.activeStatus''',
                ).toString().toString()) {
              _model.radius = MainGroup.getAllLocationsByCompanyIDCall.radius(
                (_model.apiResultLocation?.jsonBody ?? ''),
              );
              _model.worklocationName =
                  MainGroup.getAllLocationsByCompanyIDCall.worklocationName(
                (_model.apiResultLocation?.jsonBody ?? ''),
              );
              _model.statusAllLocation =
                  MainGroup.getAllLocationsByCompanyIDCall.activeStaus(
                (_model.apiResultLocation?.jsonBody ?? ''),
              );
              safeSetState(() {});
              _model.currentLocationLatLng = functions
                  .getCurrentLocationCustomFunction(currentUserLocationValue);
              safeSetState(() {});
              _model.apiGetAddressCheckOut = await ApiGetAddressCall.call(
                originalValue:
                    '${'${_model.currentLocationLatLng?.latitude.toString()},${_model.currentLocationLatLng?.longitude.toString()}'}',
                userId: ' 501afb52-6d63-481f-4cba-08dcd9195c86',
                companyId: 'bda0f20e-0784-4f90-3701-08dccbc8d8e9',
              );

              if ((_model.apiGetAddressCheckOut?.succeeded ?? true)) {
                _model.checkOutAddress = ApiGetAddressCall.location(
                  (_model.apiGetAddressCheckOut?.jsonBody ?? ''),
                );
                safeSetState(() {});
              }
            }
          }
        }),
        Future(() async {
          _model.currentLocationLatLng = functions
              .getCurrentLocationCustomFunction(currentUserLocationValue);
          _model.statusAllLocation = false;
          safeSetState(() {});
          _model.apiGetAddressResult = await ApiGetAddressCall.call(
            originalValue:
                '${'${_model.currentLocationLatLng?.latitude.toString()},${_model.currentLocationLatLng?.longitude.toString()}'}',
            userId: ' 501afb52-6d63-481f-4cba-08dcd9195c86',
            companyId: 'bda0f20e-0784-4f90-3701-08dccbc8d8e9',
          );

          if ((_model.apiGetAddressResult?.succeeded ?? true)) {
            _model.checkOutAddress = ApiGetAddressCall.location(
              (_model.apiGetAddressResult?.jsonBody ?? ''),
            );
            safeSetState(() {});
          }
        }),
        Future(() async {
          _model.apiGetDefaultSettingResult =
              await MainGroup.getDefaultSettingCall.call(
            companyID: AppState().companyID,
            token: AppState().token,
          );

          if ((_model.apiGetDefaultSettingResult?.succeeded ?? true)) {
            _model.checkOutLocationStatus =
                MainGroup.getDefaultSettingCall.checkOutLocation(
              (_model.apiGetDefaultSettingResult?.jsonBody ?? ''),
            );
            _model.checkOutradius = MainGroup.getDefaultSettingCall
                .distanceCheckInLocation(
                  (_model.apiGetDefaultSettingResult?.jsonBody ?? ''),
                )
                ?.toDouble();
            safeSetState(() {});
            if (_model.checkOutLocationStatus == 0) {
              _model.checkoutstatus = false;
              safeSetState(() {});
            } else {
              _model.checkoutstatus = true;
              safeSetState(() {});
            }
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

    return FutureBuilder<ApiCallResponse>(
      future: MainGroup.getDayViewOfSTACall.call(
        companyIDMain: AppState().companyID,
        employeeIDMain: AppState().employeeID,
        todayDateMain: functions.dateFormatToDay(),
        token: AppState().token,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primaryBackground,
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
        final checkOutOverAllGetDayViewOfSTAResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Theme.of(context).colorScheme.primaryBackground,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              automaticallyImplyLeading: false,
              leading: AppIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Theme.of(context).colorScheme.secondaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                FFLocalizations.of(context).getText(
                  'g2kql50b' /* Check - Out */,
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
                      color: Theme.of(context).colorScheme.primaryText,
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.9,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryBackground,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.272,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.272,
                                    child: custom_widgets.CustomMapTap(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.272,
                                      distanceThreshold:
                                          _model.checkOutradius?.toString(),
                                      addresstimeInterval: 1,
                                      checkinpinstatus: _model.checkoutstatus,
                                      onMarkerMoved: (moveMarker) async {
                                        _model.checkOutAddress = null;
                                        safeSetState(() {});
                                        _model.currentLocationLatLngCheckOut =
                                            functions
                                                .getCurrentLocationCustomFunction(
                                                    moveMarker);
                                        _model.statusAllLocation = MainGroup
                                            .getAllLocationsByCompanyIDCall
                                            .activeStaus(
                                          (_model.apiResultLocation?.jsonBody ??
                                              ''),
                                        );
                                        safeSetState(() {});
                                        await _model.getaddress(context);
                                        safeSetState(() {});
                                      },
                                      onInitialPositionSet:
                                          (initialLocation) async {
                                        _model.currentLocationLatLng = functions
                                            .getCurrentLocationCustomFunction(
                                                initialLocation);
                                        _model.lastKnowLocation = functions
                                            .getCurrentLocationCustomFunction(
                                                initialLocation);
                                        safeSetState(() {});
                                        await _model.getaddress(context);
                                        safeSetState(() {});
                                      },
                                      locstatus: (distancestatus) async {
                                        _model.statusAllLocation =
                                            distancestatus;
                                        safeSetState(() {});
                                        await _model.getaddress(context);
                                        safeSetState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.65,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 15.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'l5gehit9' /* Work Location */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  lineHeight:
                                                                      1.0,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        valueOrDefault<String>(
                                                          _model
                                                              .checkOutAddress,
                                                          'searching....',
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  lineHeight:
                                                                      2.0,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ].addToStart(SizedBox(width: 10.0)),
                                          ),
                                        ),
                                        Divider(
                                          height: 0.0,
                                          thickness: 1.0,
                                          indent: 10.0,
                                          endIndent: 10.0,
                                          color: FlutterFlowTheme.of(context)
                                              .themeColor,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .themeColor,
                                                        size: 24.0,
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          _model
                                                              .checkOutAddress,
                                                          'searching....',
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 3,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  lineHeight:
                                                                      3.0,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height: 370.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 10.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    5.0,
                                                                    0.0,
                                                                    5.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1.0,
                                                                      -1.0),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'fso6hvt4' /* Check In   : */,
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
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .themeColor,
                                                                      fontSize:
                                                                          14.0,
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
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  'Regular' ==
                                                                          widget
                                                                              .timeType
                                                                      ? AppState()
                                                                          .clockInTime
                                                                      : AppState()
                                                                          .otClockInTime,
                                                                  'CheckIn Time',
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
                                                          ],
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            'Regular' ==
                                                                    widget
                                                                        .timeType
                                                                ? MainGroup
                                                                    .getDayViewOfSTACall
                                                                    .checkInImage(
                                                                      checkOutOverAllGetDayViewOfSTAResponse
                                                                          .jsonBody,
                                                                    )!
                                                                    .lastOrNull!
                                                                : MainGroup
                                                                    .getDayViewOfSTACall
                                                                    .otCheckInImage(
                                                                      checkOutOverAllGetDayViewOfSTAResponse
                                                                          .jsonBody,
                                                                    )!
                                                                    .lastOrNull!,
                                                            width: 60.0,
                                                            height: 60.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    10.0,
                                                                    10.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .location_on,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .themeColor,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        _model
                                                                            .checkOutAddress,
                                                                        'searching....',
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      maxLines:
                                                                          3,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.readexPro(
                                                                              fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                              fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                context.textTheme.bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                context.textTheme.bodyMedium.fontStyle,
                                                                            lineHeight:
                                                                                3.0,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    10.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: InkWell(
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
                                                                  final selectedMedia =
                                                                      await selectMedia(
                                                                    multiImage:
                                                                        false,
                                                                  );
                                                                  if (selectedMedia !=
                                                                          null &&
                                                                      selectedMedia.every((m) => validateFileFormat(
                                                                          m.storagePath,
                                                                          context))) {
                                                                    safeSetState(() =>
                                                                        _model.isDataUploading_uploadDataQiw =
                                                                            true);
                                                                    var selectedUploadedFiles =
                                                                        <FFUploadedFile>[];

                                                                    try {
                                                                      selectedUploadedFiles = selectedMedia
                                                                          .map((m) => FFUploadedFile(
                                                                                name: m.storagePath.split('/').last,
                                                                                bytes: m.bytes,
                                                                                height: m.dimensions?.height,
                                                                                width: m.dimensions?.width,
                                                                                blurHash: m.blurHash,
                                                                              ))
                                                                          .toList();
                                                                    } finally {
                                                                      _model.isDataUploading_uploadDataQiw =
                                                                          false;
                                                                    }
                                                                    if (selectedUploadedFiles
                                                                            .length ==
                                                                        selectedMedia
                                                                            .length) {
                                                                      safeSetState(
                                                                          () {
                                                                        _model.uploadedLocalFile_uploadDataQiw =
                                                                            selectedUploadedFiles.first;
                                                                      });
                                                                    } else {
                                                                      safeSetState(
                                                                          () {});
                                                                      return;
                                                                    }
                                                                  }

                                                                  _model.apiResult4m6 =
                                                                      await GetCheckInImageURLCall
                                                                          .call(
                                                                    file: _model
                                                                        .uploadedLocalFile_uploadDataQiw,
                                                                  );

                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  elevation:
                                                                      0.0,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: _model
                                                                            .isDataUploading_uploadDataQiw
                                                                        ? double
                                                                            .infinity
                                                                        : 100.0,
                                                                    height:
                                                                        60.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0.0),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .camera_alt,
                                                                          color:
                                                                              Theme.of(context).colorScheme.secondaryText,
                                                                          size:
                                                                              24.0,
                                                                        ),
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '42s7sb64' /* Take a photo* */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: context.textTheme.bodyMedium.fontWeight,
                                                                                fontStyle: context.textTheme.bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            if ((_model
                                                                        .uploadedLocalFile_uploadDataQiw
                                                                        .bytes
                                                                        ?.isNotEmpty ??
                                                                    false))
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
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
                                                                    AppState()
                                                                            .showPopUpImage =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .memory(
                                                                      _model.uploadedLocalFile_uploadDataQiw
                                                                              .bytes ??
                                                                          Uint8List.fromList(
                                                                              []),
                                                                      width:
                                                                          60.0,
                                                                      height:
                                                                          60.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 150.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .bkCheckin,
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              width: 0.0,
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                dateTimeFormat(
                                                                  "MMMMEEEEd",
                                                                  getCurrentTimestamp,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
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
                                                              Text(
                                                                dateTimeFormat(
                                                                  "Hm",
                                                                  getCurrentTimestamp,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
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
                                                                      fontSize:
                                                                          50.0,
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
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ].addToStart(SizedBox(width: 0.0)),
                                        ),
                                        Flexible(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 1.0, 10.0, 0.0),
                                              child: AppButton(
                                                onPressed: () async {
                                                  _model.apiResultGetDayViewOfSTA =
                                                      await MainGroup
                                                          .getDayViewOfSTACall
                                                          .call(
                                                    companyIDMain:
                                                        AppState().companyID,
                                                    employeeIDMain:
                                                        AppState().employeeID,
                                                    todayDateMain: functions
                                                        .dateFormatToDay(),
                                                    token: AppState().token,
                                                  );

                                                  if (AppState().timeType ==
                                                      'Regular') {
                                                    AppState().clockOutTime =
                                                        dateTimeFormat(
                                                      "Hm",
                                                      getCurrentTimestamp,
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    );
                                                    AppState()
                                                            .clockOutLocation =
                                                        MainGroup
                                                            .getDayViewOfSTACall
                                                            .clockOutLocation(
                                                              checkOutOverAllGetDayViewOfSTAResponse
                                                                  .jsonBody,
                                                            )!
                                                            .lastOrNull!;
                                                    AppState()
                                                            .clockOutLattitude =
                                                        MainGroup
                                                            .getDayViewOfSTACall
                                                            .clockOutLattitude(
                                                              checkOutOverAllGetDayViewOfSTAResponse
                                                                  .jsonBody,
                                                            )!
                                                            .lastOrNull!;
                                                    AppState()
                                                            .clockOutLongitude =
                                                        MainGroup
                                                            .getDayViewOfSTACall
                                                            .clockOutLongitude(
                                                              checkOutOverAllGetDayViewOfSTAResponse
                                                                  .jsonBody,
                                                            )!
                                                            .firstOrNull!;
                                                    safeSetState(() {});
                                                    _model.apiResultUpdateClockInOut =
                                                        await MainGroup
                                                            .updateClockInOutMobileCall
                                                            .call(
                                                      timeID:
                                                          AppState().timeID,
                                                      clockID:
                                                          AppState().clockID,
                                                      clockInTime: AppState()
                                                          .clockInTime,
                                                      clockOutTime: functions
                                                          .localTimeToUTCtime(
                                                              dateTimeFormat(
                                                        "yyyy/MM/dd HH:mm",
                                                        getCurrentTimestamp,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      )),
                                                      clockInLocation:
                                                          AppState()
                                                              .clockInLocation,
                                                      clockOutLocation: _model
                                                          .checkOutAddress,
                                                      clockInLattitude:
                                                          AppState()
                                                              .clockInLattitude,
                                                      clockInLongitude:
                                                          AppState()
                                                              .clockInLongitude,
                                                      clockOutLattitude: _model
                                                          .currentLocationLatLngCheckOut
                                                          ?.latitude
                                                          .toString(),
                                                      clockOutLongitude: _model
                                                          .currentLocationLatLngCheckOut
                                                          ?.longitude
                                                          .toString(),
                                                      approve:
                                                          AppState().approve,
                                                      timeType: 'Regular',
                                                      employeeID: AppState()
                                                          .employeeID,
                                                      companyID: AppState()
                                                          .companyID,
                                                      shiftStartTime:
                                                          AppState()
                                                              .shiftStartTIme,
                                                      shftEndTime: AppState()
                                                          .shiftEndTime,
                                                      userID:
                                                          AppState().userID,
                                                      token: AppState().token,
                                                      checkOutImage:
                                                          GetCheckInImageURLCall
                                                              .imgURL(
                                                        (_model.apiResult4m6
                                                                ?.jsonBody ??
                                                            ''),
                                                      ),
                                                    );

                                                    await showDialog(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return WebViewAware(
                                                          child: AlertDialog(
                                                            title:
                                                                Text('Alert'),
                                                            content: Text(MainGroup
                                                                .updateClockInOutMobileCall
                                                                .status(
                                                                  (_model.apiResultUpdateClockInOut
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                )!
                                                                .toString()),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext),
                                                                child:
                                                                    Text('Ok'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                    await showDialog(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return WebViewAware(
                                                          child: AlertDialog(
                                                            title:
                                                                Text('Alert'),
                                                            content: Text(MainGroup
                                                                .updateClockInOutMobileCall
                                                                .message(
                                                              (_model.apiResultUpdateClockInOut
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            )!),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext),
                                                                child:
                                                                    Text('Ok'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                    if (MainGroup
                                                            .updateClockInOutMobileCall
                                                            .status(
                                                          (_model.apiResultUpdateClockInOut
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ) ==
                                                        0) {
                                                      AppState()
                                                              .clockOutTime =
                                                          dateTimeFormat(
                                                        "Hm",
                                                        getCurrentTimestamp,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      );
                                                      safeSetState(() {});
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              title:
                                                                  Text('Alert'),
                                                              content: Text(
                                                                  'Checked Out Successfully !'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );

                                                      Navigator.of(context).pushNamed(
                                                          HomeWidget.routeName);
                                                    } else {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              title: Text(
                                                                  'Error !'),
                                                              content: Text(
                                                                  MainGroup
                                                                      .updateClockInOutMobileCall
                                                                      .message(
                                                                (_model.apiResultUpdateClockInOut
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              )!),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  } else {
                                                    AppState()
                                                            .otClockOutTime =
                                                        dateTimeFormat(
                                                      "Hm",
                                                      getCurrentTimestamp,
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    );
                                                    AppState()
                                                            .otClockOutLocation =
                                                        MainGroup
                                                            .getDayViewOfSTACall
                                                            .otClockOutLocation(
                                                              checkOutOverAllGetDayViewOfSTAResponse
                                                                  .jsonBody,
                                                            )!
                                                            .lastOrNull!;
                                                    AppState()
                                                            .otClockOutLattitude =
                                                        MainGroup
                                                            .getDayViewOfSTACall
                                                            .otClockOutLattitude(
                                                              checkOutOverAllGetDayViewOfSTAResponse
                                                                  .jsonBody,
                                                            )!
                                                            .lastOrNull!;
                                                    safeSetState(() {});
                                                    _model.apiResultUpdateClockInOutOvertime =
                                                        await MainGroup
                                                            .updateClockInOutMobileCall
                                                            .call(
                                                      timeID:
                                                          AppState().timeID,
                                                      clockID:
                                                          AppState().clockID,
                                                      clockInTime: AppState()
                                                          .otClockInTime,
                                                      clockOutTime: functions
                                                          .localTimeToUTCtime(
                                                              dateTimeFormat(
                                                        "yyyy/MM/dd HH:mm",
                                                        getCurrentTimestamp,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      )),
                                                      clockInLocation:
                                                          AppState()
                                                              .otClockInLocation,
                                                      clockOutLocation: _model
                                                          .checkOutAddress,
                                                      clockInLattitude:
                                                          AppState()
                                                              .otClockInLattitude,
                                                      clockInLongitude:
                                                          AppState()
                                                              .otClockInLongitude,
                                                      clockOutLattitude: _model
                                                          .currentLocationLatLngCheckOut
                                                          ?.latitude
                                                          .toString(),
                                                      clockOutLongitude: _model
                                                          .currentLocationLatLngCheckOut
                                                          ?.longitude
                                                          .toString(),
                                                      approve:
                                                          AppState().approve,
                                                      timeType: 'Overtime',
                                                      employeeID: AppState()
                                                          .employeeID,
                                                      companyID: AppState()
                                                          .companyID,
                                                      shiftStartTime:
                                                          AppState()
                                                              .shiftStartTIme,
                                                      shftEndTime: AppState()
                                                          .shiftEndTime,
                                                      userID:
                                                          AppState().userID,
                                                      token: AppState().token,
                                                      checkOutImage:
                                                          GetCheckInImageURLCall
                                                              .imgURL(
                                                        (_model.apiResult4m6
                                                                ?.jsonBody ??
                                                            ''),
                                                      ),
                                                    );

                                                    await showDialog(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return WebViewAware(
                                                          child: AlertDialog(
                                                            title:
                                                                Text('Alert'),
                                                            content: Text(MainGroup
                                                                .updateClockInOutMobileCall
                                                                .status(
                                                                  (_model.apiResultUpdateClockInOutOvertime
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                )!
                                                                .toString()),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext),
                                                                child:
                                                                    Text('Ok'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                    await showDialog(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return WebViewAware(
                                                          child: AlertDialog(
                                                            title:
                                                                Text('Alert'),
                                                            content: Text(MainGroup
                                                                .updateClockInOutMobileCall
                                                                .message(
                                                              (_model.apiResultUpdateClockInOutOvertime
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            )!),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext),
                                                                child:
                                                                    Text('Ok'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                    if ('0' ==
                                                        getJsonField(
                                                          (_model.apiResultUpdateClockInOutOvertime
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.status''',
                                                        ).toString()) {
                                                      AppState()
                                                              .otClockInTime =
                                                          dateTimeFormat(
                                                        "Hm",
                                                        getCurrentTimestamp,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      );
                                                      safeSetState(() {});
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              title:
                                                                  Text('Alert'),
                                                              content: Text(
                                                                  'Checked Out Successfully !'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );

                                                      Navigator.of(context).pushNamed(
                                                          OvertimeWidget
                                                              .routeName);
                                                    } else {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              title: Text(
                                                                  'Error !'),
                                                              content: Text(
                                                                  MainGroup
                                                                      .updateClockInOutMobileCall
                                                                      .message(
                                                                (_model.apiResultUpdateClockInOutOvertime
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              )!),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  }

                                                  safeSetState(() {});
                                                },
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'e3parnef' /* Check Out */,
                                                ),
                                                options: FFButtonOptions(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          24.0, 0.0, 24.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .themeColor,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            font: GoogleFonts
                                                                .readexPro(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                          ),
                                                  elevation: 3.0,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
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
      },
    );
  }
}
