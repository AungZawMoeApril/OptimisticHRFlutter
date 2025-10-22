import 'package:hr_optimistic/core/theme/app_theme_extension.dart';
import '../core/widgets/app_widgets.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/loading_component_widget.dart';
import '../core/widgets/app_icon_button.dart';;
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import '../core/widgets/app_button.dart';;
import 'package:hr_app/core/utils/upload_data.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:hr_app/core/utils/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'check_in_over_all_model.dart';
export 'check_in_over_all_model.dart';

class CheckInOverAllWidget extends StatefulWidget {
  const CheckInOverAllWidget({
    super.key,
    required this.timeType,
  });

  final String? timeType;

  static String routeName = 'CheckInOverAll';
  static String routePath = '/checkInOverAll';

  @override
  State<CheckInOverAllWidget> createState() => _CheckInOverAllWidgetState();
}

class _CheckInOverAllWidgetState extends State<CheckInOverAllWidget> {
  late CheckInOverAllModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckInOverAllModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      await Future.wait([
        Future(() async {
          _model.apiResultAllLocation =
              await MainGroup.getAllLocationsByCompanyIDCall.call(
            companyID: AppState().companyID,
            token: AppState().token,
          );

          if ('0' ==
              getJsonField(
                (_model.apiResultAllLocation?.jsonBody ?? ''),
                r'''$.status''',
              ).toString().toString()) {
            if (MainGroup.getAllLocationsByCompanyIDCall.activeStaus(
                  (_model.apiResultAllLocation?.jsonBody ?? ''),
                ) ==
                true) {
              _model.currentLocationLatLng = functions
                  .getCurrentLocationCustomFunction(currentUserLocationValue);
              _model.radius = MainGroup.getAllLocationsByCompanyIDCall.radius(
                (_model.apiResultAllLocation?.jsonBody ?? ''),
              );
              _model.statusAllLocation =
                  MainGroup.getAllLocationsByCompanyIDCall.activeStaus(
                (_model.apiResultAllLocation?.jsonBody ?? ''),
              );
              _model.workinLocationName =
                  MainGroup.getAllLocationsByCompanyIDCall.worklocationName(
                (_model.apiResultAllLocation?.jsonBody ?? ''),
              );
              safeSetState(() {});
              await showDialog(
                context: context,
                builder: (alertDialogContext) {
                  return WebViewAware(
                    child: AlertDialog(
                      title: Text('Alert'),
                      content: Text(
                          'raidus : ${_model.radius?.toString()}location : ${_model.statusAllLocation?.toString()}'),
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
              _model.radius = MainGroup.getAllLocationsByCompanyIDCall.radius(
                (_model.apiResultAllLocation?.jsonBody ?? ''),
              );
              _model.statusAllLocation =
                  MainGroup.getAllLocationsByCompanyIDCall.activeStaus(
                (_model.apiResultAllLocation?.jsonBody ?? ''),
              );
              _model.workinLocationName =
                  MainGroup.getAllLocationsByCompanyIDCall.worklocationName(
                (_model.apiResultAllLocation?.jsonBody ?? ''),
              );
              safeSetState(() {});
              _model.apiGetAddressResultCompany = await ApiGetAddressCall.call(
                originalValue:
                    '${'${_model.currentLocationLatLng?.latitude.toString()},${_model.currentLocationLatLng?.longitude.toString()}'}',
                userId: ' 501afb52-6d63-481f-4cba-08dcd9195c86',
                companyId: 'bda0f20e-0784-4f90-3701-08dccbc8d8e9',
              );

              if ((_model.apiGetAddressResultCompany?.succeeded ?? true)) {
                _model.checkinaddress = ApiGetAddressCall.location(
                  (_model.apiGetAddressResultCompany?.jsonBody ?? ''),
                );
                safeSetState(() {});
              }
            }
          }
        }),
        Future(() async {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (dialogContext) {
              return Dialog(
                elevation: 0,
                insetPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                alignment: AlignmentDirectional(0.0, 0.0)
                    .resolve(Directionality.of(context)),
                child: WebViewAware(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(dialogContext).unfocus();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: LoadingComponentWidget(),
                  ),
                ),
              );
            },
          );

          _model.currentLocationLatLng = functions
              .getCurrentLocationCustomFunction(currentUserLocationValue);
          safeSetState(() {});
          _model.apiGetAddressResult = await ApiGetAddressCall.call(
            originalValue:
                '${'${_model.currentLocationLatLng?.latitude.toString()},${_model.currentLocationLatLng?.longitude.toString()}'}',
            userId: ' 501afb52-6d63-481f-4cba-08dcd9195c86',
            companyId: 'bda0f20e-0784-4f90-3701-08dccbc8d8e9',
          );

          if ((_model.apiGetAddressResult?.succeeded ?? true)) {
            _model.checkinaddress = ApiGetAddressCall.location(
              (_model.apiGetAddressResult?.jsonBody ?? ''),
            );
            safeSetState(() {});
          }
          Navigator.pop(context);
        }),
        Future(() async {
          _model.apiResultDefaultSetting =
              await MainGroup.getDefaultSettingCall.call(
            companyID: AppState().companyID,
            token: AppState().token,
          );

          if ((_model.apiResultDefaultSetting?.succeeded ?? true)) {
            _model.checkInOffSite =
                MainGroup.getDefaultSettingCall.checkInOffSite(
              (_model.apiResultDefaultSetting?.jsonBody ?? ''),
            );
            _model.isCheckInPicture =
                MainGroup.getDefaultSettingCall.isCheckInPicture(
              (_model.apiResultDefaultSetting?.jsonBody ?? ''),
            );
            _model.isRequireCheckIn =
                MainGroup.getDefaultSettingCall.isRequireCheckIn(
              (_model.apiResultDefaultSetting?.jsonBody ?? ''),
            );
            safeSetState(() {});
          }
        }),
        Future(() async {
          _model.offSite = false;
          _model.forgotCheckIn = false;
          _model.statusAllLocation = false;
          safeSetState(() {});
        }),
      ]);
    });

    _model.locationTextController ??= TextEditingController();
    _model.locationFocusNode ??= FocusNode();

    _model.detailsTextController ??= TextEditingController();
    _model.detailsFocusNode ??= FocusNode();

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

    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: WillPopScope(
          onWillPop: () async => false,
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
                  color: Theme.of(context).colorScheme.primaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  AppState().deleteCheckInStatusOnSite();
                  AppState().checkInStatusOnSite = 0;

                  safeSetState(() {});
                  context.safePop();
                },
              ),
              title: Text(
                FFLocalizations.of(context).getText(
                  'u4xbydda' /* Check in */,
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
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryBackground,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.272,
                                  child: custom_widgets.CustomMapTap(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.272,
                                    distanceThreshold:
                                        _model.radius?.toString(),
                                    addresstimeInterval: 1,
                                    checkinpinstatus: false,
                                    onMarkerMoved: (moveMarker) async {
                                      _model.checkinaddress = null;
                                      safeSetState(() {});
                                      _model.currentLocationLatLng = functions
                                          .getCurrentLocationCustomFunction(
                                              moveMarker);
                                      _model.forgotCheckIn = false;
                                      _model.offSite = false;
                                      _model.statusAllLocation = MainGroup
                                          .getAllLocationsByCompanyIDCall
                                          .activeStaus(
                                        (_model.apiResultAllLocation
                                                ?.jsonBody ??
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
                                      _model.statusAllLocation = distancestatus;
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
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.548,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    if (AppState().checkInStatusOnSite != 3)
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                              checkboxTheme: CheckboxThemeData(
                                                visualDensity:
                                                    VisualDensity.compact,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                              ),
                                              unselectedWidgetColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            child: Checkbox(
                                              value: _model
                                                  .forgotCheckInValue ??= false,
                                              onChanged: (_model.offSite ==
                                                      true)
                                                  ? null
                                                  : (newValue) async {
                                                      safeSetState(() => _model
                                                              .forgotCheckInValue =
                                                          newValue!);
                                                      if (newValue!) {
                                                        _model.forgotCheckIn =
                                                            _model
                                                                .forgotCheckInValue!;
                                                        _model.offSite = false;
                                                        safeSetState(() {});
                                                      } else {
                                                        _model.forgotCheckIn =
                                                            _model
                                                                .forgotCheckInValue!;
                                                        _model.offSite = false;
                                                        safeSetState(() {});
                                                      }
                                                    },
                                              side:
                                                  (FlutterFlowTheme.of(context)
                                                              .secondaryText !=
                                                          null)
                                                      ? BorderSide(
                                                          width: 2,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        )
                                                      : null,
                                              activeColor:
                                                  FlutterFlowTheme.of(context)
                                                      .themeColor,
                                              checkColor: (_model.offSite ==
                                                      true)
                                                  ? FlutterFlowTheme.of(context)
                                                      .secondary
                                                  : FlutterFlowTheme.of(context)
                                                      .info,
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'tzzj2kil' /* Forgot Check-in */,
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
                                          Theme(
                                            data: ThemeData(
                                              checkboxTheme: CheckboxThemeData(
                                                visualDensity:
                                                    VisualDensity.compact,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                              ),
                                              unselectedWidgetColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            child: Checkbox(
                                              value: _model.offSiteValue ??=
                                                  false,
                                              onChanged: ((_model
                                                              .forgotCheckIn ==
                                                          true) ||
                                                      (_model.checkInOffSite ==
                                                          0))
                                                  ? null
                                                  : (newValue) async {
                                                      safeSetState(() =>
                                                          _model.offSiteValue =
                                                              newValue!);
                                                      if (newValue!) {
                                                        _model.offSite = _model
                                                            .offSiteValue!;
                                                        _model.forgotCheckIn =
                                                            false;
                                                        safeSetState(() {});
                                                      } else {
                                                        _model.offSite = _model
                                                            .offSiteValue!;
                                                        _model.forgotCheckIn =
                                                            false;
                                                        safeSetState(() {});
                                                      }
                                                    },
                                              side:
                                                  (FlutterFlowTheme.of(context)
                                                              .secondaryText !=
                                                          null)
                                                      ? BorderSide(
                                                          width: 2,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        )
                                                      : null,
                                              activeColor:
                                                  FlutterFlowTheme.of(context)
                                                      .themeColor,
                                              checkColor: ((_model
                                                              .forgotCheckIn ==
                                                          true) ||
                                                      (_model.checkInOffSite ==
                                                          0))
                                                  ? FlutterFlowTheme.of(context)
                                                      .secondary
                                                  : FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'jsi2a60k' /* Off-site */,
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
                                        ],
                                      ),
                                    if (AppState().checkInStatusOnSite != 3)
                                      Divider(
                                        height: 10.0,
                                        thickness: 1.0,
                                        indent: 10.0,
                                        endIndent: 10.0,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ytyjzowf' /* Work Location */,
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
                                                                lineHeight: 1.0,
                                                              ),
                                                    ),
                                                  ),
                                                  if ((_model.statusAllLocation ==
                                                          false) &&
                                                      (_model.offSite == false))
                                                    Container(
                                                      width: 15.0,
                                                      height: 15.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .timeCheckin,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  if ((_model.statusAllLocation ==
                                                          true) &&
                                                      (_model.offSite == false))
                                                    Container(
                                                      width: 15.0,
                                                      height: 15.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  if ((_model.statusAllLocation ==
                                                          true) &&
                                                      (_model.offSite == false))
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ywdzqxko' /* You are not within the specifi... */,
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                fontSize: 10.0,
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
                                              if (_model.offSite == false)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      if (_model.offSite ==
                                                          false)
                                                        Expanded(
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              _model
                                                                  .checkinaddress,
                                                              'searching....',
                                                            ),
                                                            textAlign: TextAlign
                                                                .justify,
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
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              if (_model.offSite == true)
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (_model.offSite == true)
                                                      Expanded(
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .locationTextController,
                                                            focusNode: _model
                                                                .locationFocusNode,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              hintText:
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                'lp22z6ar' /* Location */,
                                                              ),
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
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
                                                            cursorColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            validator: _model
                                                                .locationTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ].addToStart(SizedBox(width: 10.0)),
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 10.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .themeColor,
                                                        size: 24.0,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            _model
                                                                .checkinaddress,
                                                            'searching....',
                                                          ),
                                                          textAlign:
                                                              TextAlign.justify,
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
                                                                lineHeight: 2.0,
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
                                    Divider(
                                      height: 0.0,
                                      thickness: 1.0,
                                      indent: 10.0,
                                      endIndent: 10.0,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 250.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 10.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, -1.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'wm6zicck' /* Details */,
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
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                  child: TextFormField(
                                                    controller: _model
                                                        .detailsTextController,
                                                    focusNode:
                                                        _model.detailsFocusNode,
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      alignLabelWithHint: false,
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
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
                                                    validator: _model
                                                        .detailsTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          final selectedMedia =
                                                              await selectMedia(
                                                            multiImage: false,
                                                          );
                                                          if (selectedMedia !=
                                                                  null &&
                                                              selectedMedia.every((m) =>
                                                                  validateFileFormat(
                                                                      m.storagePath,
                                                                      context))) {
                                                            safeSetState(() =>
                                                                _model.isDataUploading_uploadDataCheckIn =
                                                                    true);
                                                            var selectedUploadedFiles =
                                                                <FFUploadedFile>[];

                                                            try {
                                                              selectedUploadedFiles =
                                                                  selectedMedia
                                                                      .map((m) =>
                                                                          FFUploadedFile(
                                                                            name:
                                                                                m.storagePath.split('/').last,
                                                                            bytes:
                                                                                m.bytes,
                                                                            height:
                                                                                m.dimensions?.height,
                                                                            width:
                                                                                m.dimensions?.width,
                                                                            blurHash:
                                                                                m.blurHash,
                                                                          ))
                                                                      .toList();
                                                            } finally {
                                                              _model.isDataUploading_uploadDataCheckIn =
                                                                  false;
                                                            }
                                                            if (selectedUploadedFiles
                                                                    .length ==
                                                                selectedMedia
                                                                    .length) {
                                                              safeSetState(() {
                                                                _model.uploadedLocalFile_uploadDataCheckIn =
                                                                    selectedUploadedFiles
                                                                        .first;
                                                              });
                                                            } else {
                                                              safeSetState(
                                                                  () {});
                                                              return;
                                                            }
                                                          }

                                                          _model.apiResultGetCheckInImageURL =
                                                              await GetCheckInImageURLCall
                                                                  .call(
                                                            file: _model
                                                                .uploadedLocalFile_uploadDataCheckIn,
                                                          );

                                                          safeSetState(() {});
                                                        },
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 0.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 60.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0),
                                                              border:
                                                                  Border.all(
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                            child: Column(
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  size: 24.0,
                                                                ),
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'twsin0t9' /* Take a photo* */,
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
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    if ((_model
                                                                .uploadedLocalFile_uploadDataCheckIn
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
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.memory(
                                                            _model.uploadedLocalFile_uploadDataCheckIn
                                                                    .bytes ??
                                                                Uint8List
                                                                    .fromList(
                                                                        []),
                                                            width: 60.0,
                                                            height: 60.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 100.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            _model.forgotCheckIn ==
                                                                    true
                                                                ? (_model.datePicked ==
                                                                        null
                                                                    ? dateTimeFormat(
                                                                        "MMMMEEEEd",
                                                                        getCurrentTimestamp,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      )
                                                                    : dateTimeFormat(
                                                                        "MMMMEEEEd",
                                                                        _model
                                                                            .datePicked,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      ))
                                                                : dateTimeFormat(
                                                                    "MMMMEEEEd",
                                                                    getCurrentTimestamp,
                                                                    locale: FFLocalizations.of(
                                                                            context)
                                                                        .languageCode,
                                                                  ),
                                                            'Wednesday, January 29',
                                                          ),
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
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                _model.forgotCheckIn ==
                                                                        true
                                                                    ? (_model.datePicked ==
                                                                            null
                                                                        ? dateTimeFormat(
                                                                            "Hm",
                                                                            getCurrentTimestamp,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          )
                                                                        : dateTimeFormat(
                                                                            "Hm",
                                                                            _model.datePicked,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ))
                                                                    : dateTimeFormat(
                                                                        "Hm",
                                                                        getCurrentTimestamp,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
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
                                                            ),
                                                            if (_model
                                                                    .forgotCheckIn ==
                                                                true)
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
                                                                    await showModalBottomSheet<
                                                                            bool>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return ScrollConfiguration(
                                                                            behavior:
                                                                                const MaterialScrollBehavior().copyWith(
                                                                              dragDevices: {
                                                                                PointerDeviceKind.mouse,
                                                                                PointerDeviceKind.touch,
                                                                                PointerDeviceKind.stylus,
                                                                                PointerDeviceKind.unknown
                                                                              },
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              height: MediaQuery.of(context).size.height / 3,
                                                                              width: MediaQuery.of(context).size.width,
                                                                              child: CupertinoDatePicker(
                                                                                mode: CupertinoDatePickerMode.dateAndTime,
                                                                                minimumDate: DateTime(1900),
                                                                                initialDateTime: getCurrentTimestamp,
                                                                                maximumDate: DateTime(2050),
                                                                                use24hFormat: false,
                                                                                onDateTimeChanged: (newDateTime) => safeSetState(() {
                                                                                  _model.datePicked = newDateTime;
                                                                                }),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        });

                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/edit-rectangle-svgrepo-com_1_(1).png',
                                                                      width:
                                                                          30.0,
                                                                      height:
                                                                          30.0,
                                                                      fit: BoxFit
                                                                          .cover,
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      ].addToStart(SizedBox(width: 0.0)),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 10.0, 0.0),
                                                  child: AppButton(
                                                    onPressed: ((_model.statusAllLocation ==
                                                                true) ||
                                                            (_model.checkinaddress ==
                                                                    null ||
                                                                _model.checkinaddress ==
                                                                    '') ||
                                                            ((_model
                                                                        .uploadedLocalFile_uploadDataCheckIn
                                                                        .bytes
                                                                        ?.isEmpty ??
                                                                    true)) ||
                                                            ((_model.forgotCheckIn ==
                                                                    true) &&
                                                                (_model.detailsTextController
                                                                            .text ==
                                                                        '')) ||
                                                            ((_model.forgotCheckIn ==
                                                                    true) &&
                                                                (_model.datePicked ==
                                                                    null)))
                                                        ? null
                                                        : () async {
                                                            _model.apiResultAddotClockInOut =
                                                                await MainGroup
                                                                    .addClockInOutMobileCall
                                                                    .call(
                                                              approve:
                                                                  AppState()
                                                                      .approve,
                                                              timeID: 0,
                                                              userID:
                                                                  AppState()
                                                                      .userID,
                                                              companyID:
                                                                  AppState()
                                                                      .companyID,
                                                              employeeID:
                                                                  AppState()
                                                                      .employeeID,
                                                              timeType:
                                                                  AppState()
                                                                      .timeType,
                                                              shiftStartTime:
                                                                  AppState()
                                                                      .shiftStartTIme,
                                                              shftEndTime:
                                                                  AppState()
                                                                      .shiftEndTime,
                                                              clockInTime: _model
                                                                          .forgotCheckIn ==
                                                                      true
                                                                  ? functions
                                                                      .localTimeToUTCtime(
                                                                          dateTimeFormat(
                                                                      "yyyy/MM/dd HH:mm",
                                                                      _model
                                                                          .datePicked,
                                                                      locale: FFLocalizations.of(
                                                                              context)
                                                                          .languageCode,
                                                                    ))
                                                                  : functions
                                                                      .localTimeToUTCtime(
                                                                          dateTimeFormat(
                                                                      "yyyy/MM/dd HH:mm",
                                                                      getCurrentTimestamp,
                                                                      locale: FFLocalizations.of(
                                                                              context)
                                                                          .languageCode,
                                                                    )),
                                                              clockInLattitude: _model
                                                                  .currentLocationLatLng
                                                                  ?.latitude
                                                                  .toString(),
                                                              clockInLocation:
                                                                  _model
                                                                      .checkinaddress,
                                                              clockInLongitude: _model
                                                                  .currentLocationLatLng
                                                                  ?.longitude
                                                                  .toString(),
                                                              checkInImage:
                                                                  GetCheckInImageURLCall
                                                                      .imgURL(
                                                                (_model.apiResultGetCheckInImageURL
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              ).toString(),
                                                              token:
                                                                  AppState()
                                                                      .token,
                                                              clockInOutType:
                                                                  AppState()
                                                                      .timeType,
                                                              detail: _model
                                                                  .detailsTextController
                                                                  .text,
                                                              offSiteLocation:
                                                                  _model
                                                                      .locationTextController
                                                                      .text,
                                                              checkInStatus:
                                                                  () {
                                                                if (_model
                                                                        .offSite ==
                                                                    true) {
                                                                  return 2;
                                                                } else if (_model
                                                                        .forgotCheckIn ==
                                                                    true) {
                                                                  return 1;
                                                                } else if (AppState()
                                                                        .checkInStatusOnSite ==
                                                                    3) {
                                                                  return 3;
                                                                } else {
                                                                  return 0;
                                                                }
                                                              }(),
                                                              timeEntryDate:
                                                                  dateTimeFormat(
                                                                "yyyy-MM-ddTHH:mm:ss.SSSZ",
                                                                getCurrentTimestamp,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              ),
                                                            );

                                                            if ((_model
                                                                    .apiResultAddotClockInOut
                                                                    ?.succeeded ??
                                                                true)) {
                                                              _model.apiGetDayViewOfSTA =
                                                                  await MainGroup
                                                                      .getDayViewOfSTACall
                                                                      .call(
                                                                token:
                                                                    AppState()
                                                                        .token,
                                                                companyID:
                                                                    AppState()
                                                                        .companyID,
                                                                employeeID:
                                                                    AppState()
                                                                        .employeeID,
                                                                todayDate: functions
                                                                    .dateFormatToDay(),
                                                              );

                                                              if ('0' ==
                                                                  getJsonField(
                                                                    (_model.apiGetDayViewOfSTA
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$.status''',
                                                                  ).toString()) {
                                                                AppState()
                                                                    .clockInTime = '-' ==
                                                                        MainGroup.getDayViewOfSTACall
                                                                            .regclockInTime(
                                                                              (_model.apiGetDayViewOfSTA?.jsonBody ?? ''),
                                                                            )
                                                                            ?.lastOrNull
                                                                    ? functions.changeCheckInOutTimeFormatFunction(MainGroup.getDayViewOfSTACall
                                                                        .irregularClockInTime(
                                                                          (_model.apiGetDayViewOfSTA?.jsonBody ??
                                                                              ''),
                                                                        )
                                                                        ?.lastOrNull)!
                                                                    : functions.changeCheckInOutTimeFormatFunction(MainGroup.getDayViewOfSTACall
                                                                        .regclockInTime(
                                                                          (_model.apiGetDayViewOfSTA?.jsonBody ??
                                                                              ''),
                                                                        )
                                                                        ?.lastOrNull)!;
                                                                AppState()
                                                                        .clockInLocation =
                                                                    MainGroup
                                                                        .getDayViewOfSTACall
                                                                        .clockInLocation(
                                                                          (_model.apiGetDayViewOfSTA?.jsonBody ??
                                                                              ''),
                                                                        )!
                                                                        .lastOrNull!;
                                                                AppState()
                                                                        .clockInLattitude =
                                                                    MainGroup
                                                                        .getDayViewOfSTACall
                                                                        .clockInLattitude(
                                                                          (_model.apiGetDayViewOfSTA?.jsonBody ??
                                                                              ''),
                                                                        )!
                                                                        .lastOrNull!;
                                                                AppState()
                                                                        .clockInLongitude =
                                                                    MainGroup
                                                                        .getDayViewOfSTACall
                                                                        .clockOutLattitude(
                                                                          (_model.apiGetDayViewOfSTA?.jsonBody ??
                                                                              ''),
                                                                        )!
                                                                        .lastOrNull!;
                                                                safeSetState(
                                                                    () {});
                                                                await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (alertDialogContext) {
                                                                    return WebViewAware(
                                                                      child:
                                                                          AlertDialog(
                                                                        title: Text(
                                                                            'Checked In !'),
                                                                        content:
                                                                            Text('Checked In Successfully !'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext),
                                                                            child:
                                                                                Text('Ok'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                                _model.forgotCheckIn =
                                                                    false;
                                                                _model.offSite =
                                                                    false;
                                                                safeSetState(
                                                                    () {});

                                                                Navigator.of(context).pushNamed(
                                                                    HomeWidget
                                                                        .routeName);

                                                                AppState()
                                                                    .checkInStatusOnSite = 0;
                                                                safeSetState(
                                                                    () {});
                                                              }
                                                            } else {
                                                              await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return WebViewAware(
                                                                    child:
                                                                        AlertDialog(
                                                                      title: Text(
                                                                          'Check in Failed!'),
                                                                      content: Text(
                                                                          'Sorry, you cannot check in right now.'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed: () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                          child:
                                                                              Text('Ok'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'p11tr0px' /* Check in */,
                                                    ),
                                                    style: ElevatedButton.styleFrom(
      minimumSize: Size(MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0, 40.0),
      padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
      backgroundColor: null,
      textStyle: null,
      elevation: null,
      side: const BorderSide(
        color: Colors.transparent,
        width: 1.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: null,
      ),
    ),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .themeColor,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                      elevation: 3.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      disabledColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
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
      ),
    );
  }
}
