// // import '../../core/theme/app_theme_extension.dart';
// // import '../../core/widgets/app_widgets.dart';
// // import '../../core/widgets/web_view_aware.dart';
// // import '../../core/widgets/flutter_flow_drop_down.dart';
// // import '/backend/api_requests/api_calls.dart';
// // import '/components/delete_o_t_request_dialog/delete_o_t_request_dialog_widget.dart';
// // import '../../core/widgets/app_icon_button.dart';
// // import 'package:flutter/material.dart';
// // import '../../core/utils/app_utils.dart';
// // import '../../core/widgets/app_button.dart';
// // import '/backend/schema/structs/index.dart';
// // import 'package:h_r_optimistic_mobile/core/utils/custom_functions.dart' as functions;
// // import '../../app_state.dart';
// // import 'package:flutter/scheduler.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'overtime_model.dart';
// // import '/core/theme/app_colors.dart';
// // import '../../pages/home/home_widget.dart';
// // import '../overtime_request_main/overtime_request_main_widget.dart';
// // import '../overtime_detail/overtime_detail_widget.dart';
// // import '../overtime_detail_check_out/overtime_detail_check_out_widget.dart';
// // export 'overtime_model.dart';

// // class OvertimeWidget extends StatefulWidget {
// //   const OvertimeWidget({super.key});

// //   static String routeName = 'Overtime';
// //   static String routePath = '/overtime';

// //   @override
// //   State<OvertimeWidget> createState() => _OvertimeWidgetState();
// // }

// // class _OvertimeWidgetState extends State<OvertimeWidget> with TickerProviderStateMixin {
// //   late OvertimeModel _model;

// //   final scaffoldKey = GlobalKey<ScaffoldState>();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _model = createModel(context, () => OvertimeModel());

// //     // On page load action.
// //     SchedulerBinding.instance.addPostFrameCallback((_) async {
// //       await Future.wait([
// //         Future(() async {
// //           _model.apiResultCurrentOTime = await MainGroup.getCurrentOTMobileCall.call(
// //             timezoneOffset: AppState().timezoneOffset,
// //             employeeID: AppState().employeeID,
// //             companyID: AppState().companyID,
// //             token: AppState().token,
// //           );

// //           if (MainGroup.getCurrentOTMobileCall.status(
// //                 (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //               ) ==
// //               0) {
// //             AppState().otClockInTime = '-' ==
// //                     MainGroup.getCurrentOTMobileCall.clockInTime(
// //                       (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //                     )
// //                 ? '-'
// //                 : functions.changeCheckInOutTimeFormatFunction(
// //                     MainGroup.getCurrentOTMobileCall.clockInTime(
// //                     (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //                   ));
// //             AppState().otClockOutTime = '-' ==
// //                     MainGroup.getCurrentOTMobileCall.clockOutTime(
// //                       (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //                     )
// //                 ? '-'
// //                 : functions.changeCheckInOutTimeFormatFunction(
// //                     MainGroup.getCurrentOTMobileCall.clockOutTime(
// //                     (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //                   ));
// //             AppState().OTRequestID = MainGroup.getCurrentOTMobileCall.otrequestID(
// //               (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //             );
// //             AppState().clockID = MainGroup.getCurrentOTMobileCall.clockID(
// //               (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //             );
// //             safeSetState(() {});
// //           } else {
// //             await showDialog(
// //               context: context,
// //               builder: (alertDialogContext) {
// //                 return WebViewAware(
// //                   child: AlertDialog(
// //                     title: Text('Alert'),
// //                     content: Text(getJsonField(
// //                       (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //                       r'''$.message''',
// //                     ).toString().toString()),
// //                     actions: [
// //                       TextButton(
// //                         onPressed: () => Navigator.pop(alertDialogContext),
// //                         child: Text('Ok'),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               },
// //             );
// //           }
// //         }),
// //         Future(() async {
// //           _model.apiResulHistory = await MainGroup.apiOvertimeHistoryPOSTCall.call(
// //             companyIDMain: AppState().companyID,
// //             companyID: AppState().companyID,
// //             employeeIDMain: AppState().employeeID,
// //             todayDateMain: valueOrDefault<String>(
// //               dateTimeFormat(
// //                 "d/M/y",
// //                 getCurrentTimestamp,
// //                 locale: FFLocalizations.of(context).languageCode,
// //               ),
// //               '05/12/2024',
// //             ),
// //             token: AppState().token,
// //           );

// //           if (MainGroup.apiOvertimeHistoryPOSTCall.outputstatus(
// //                 (_model.apiResulHistory?.jsonBody ?? ''),
// //               ) ==
// //               0) {
// //             _model.overTimeHistory = MainGroup.apiOvertimeHistoryPOSTCall
// //                 .overtimeHistoryList(
// //                   (_model.apiResulHistory?.jsonBody ?? ''),
// //                 )!
// //                 .where((e) =>
// //                     AppState().employeeID ==
// //                     getJsonField(
// //                       e,
// //                       r'''$.requester_ID''',
// //                     ))
// //                 .toList()
// //                 .toList()
// //                 .cast<dynamic>();
// //             _model.overtimeStatusAllData = MainGroup.apiOvertimeHistoryPOSTCall
// //                 .overtimeHistoryList(
// //                   (_model.apiResulHistory?.jsonBody ?? ''),
// //                 )!
// //                 .where((e) =>
// //                     AppState().employeeID ==
// //                     getJsonField(
// //                       e,
// //                       r'''$.requester_ID''',
// //                     ))
// //                 .toList()
// //                 .toList()
// //                 .cast<dynamic>();
// //             _model.overtimeApprovedTab = MainGroup.apiOvertimeHistoryPOSTCall
// //                 .overtimeHistoryList(
// //                   (_model.apiResulHistory?.jsonBody ?? ''),
// //                 )!
// //                 .where((e) =>
// //                     ('Approved' ==
// //                         getJsonField(
// //                           e,
// //                           r'''$.status''',
// //                         ).toString().toString()) &&
// //                     (AppState().employeeID ==
// //                         getJsonField(
// //                           e,
// //                           r'''$.requester_ID''',
// //                         )))
// //                 .toList()
// //                 .toList()
// //                 .cast<dynamic>();
// //             safeSetState(() {});
// //           }
// //         }),
// //       ]);
// //     });

// //     _model.tabBarController = TabController(
// //       vsync: this,
// //       length: 3,
// //       initialIndex: 0,
// //     )..addListener(() => safeSetState(() {}));

// //     WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
// //   }

// //   @override
// //   void dispose() {
// //     _model.dispose();

// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     AppState();

// //     return GestureDetector(
// //       onTap: () {
// //         FocusScope.of(context).unfocus();
// //         FocusManager.instance.primaryFocus?.unfocus();
// //       },
// //       child: Scaffold(
// //         key: scaffoldKey,
// //         backgroundColor: Color(0xFFF6F6F6),
// //         appBar: AppBar(
// //           backgroundColor: Theme.of(context).colorScheme.secondaryBackground,
// //           automaticallyImplyLeading: false,
// //           leading: AppIconButton(
// //             borderColor: Colors.transparent,
// //             borderRadius: 30.0,
// //             borderWidth: 1.0,
// //             buttonSize: 60.0,
// //             icon: FaIcon(
// //               FontAwesomeIcons.angleLeft,
// //               color: Theme.of(context).colorScheme.onSurfaceVariant,
// //               size: 30.0,
// //             ),
// //             onPressed: () async {
// //               Navigator.of(context).pushNamed(HomeWidget.routeName);
// //             },
// //           ),
// //           title: Text(
// //             FFLocalizations.of(context).getText(
// //               'k7oclrv5' /* Overtime */,
// //             ),
// //             style: GoogleFonts.outfit(
// //               color: Theme.of(context).colorScheme.onSurfaceVariant,
// //               fontSize: 22.0,
// //               letterSpacing: 0.0,
// //               fontWeight: context.headlineMedium?.fontWeight ?? FontWeight.normal,
// //               fontStyle: context.headlineMedium?.fontStyle ?? FontStyle.normal,
// //             ),
// //           ),
// //           actions: [
// //             Padding(
// //               padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 14.0, 0.0),
// //               child: InkWell(
// //                 splashColor: Colors.transparent,
// //                 focusColor: Colors.transparent,
// //                 hoverColor: Colors.transparent,
// //                 highlightColor: Colors.transparent,
// //                 onTap: () async {
// //                   Navigator.of(context).pushNamed(OvertimeRequestMainWidget.routeName);
// //                 },
// //                 child: FaIcon(
// //                   FontAwesomeIcons.plusCircle,
// //                   color: Color(0xFFF89D27),
// //                   size: 24.0,
// //                 ),
// //               ),
// //             ),
// //           ],
// //           centerTitle: true,
// //           elevation: 2.0,
// //         ),
// //         body: SafeArea(
// //           top: true,
// //           child: Column(
// //             mainAxisSize: MainAxisSize.max,
// //             children: [
// //               Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   if (functions
// //                           .overtimeShowDataFunction(MainGroup.getCurrentOTMobileCall.currentOTList(
// //                         (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //                       )) ==
// //                       true)
// //                     Padding(
// //                       padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
// //                       child: Container(
// //                         width: double.infinity,
// //                         height: MediaQuery.sizeOf(context).height * 0.25,
// //                         decoration: BoxDecoration(
// //                           color: Theme.of(context).colorScheme.secondaryBackground,
// //                           borderRadius: BorderRadius.circular(10.0),
// //                         ),
// //                         child: Align(
// //                           alignment: AlignmentDirectional(-1.0, 0.0),
// //                           child: Column(
// //                             mainAxisSize: MainAxisSize.max,
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Padding(
// //                                 padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 0.0, 0.0),
// //                                 child: Row(
// //                                   mainAxisSize: MainAxisSize.max,
// //                                   children: [
// //                                     Icon(
// //                                       Icons.date_range,
// //                                       color: Theme.of(context).textTheme.bodyMedium?.color,
// //                                       size: 24.0,
// //                                     ),
// //                                     Padding(
// //                                       padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 10.0, 0.0),
// //                                       child: Text(
// //                                         valueOrDefault<String>(
// //                                           dateTimeFormat(
// //                                             "dd/MM/yyyy",
// //                                             getCurrentTimestamp,
// //                                             locale: FFLocalizations.of(context).languageCode,
// //                                           ),
// //                                           '18/03/2025',
// //                                         ),
// //                                         textAlign: TextAlign.start,
// //                                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                                               fontFamily: GoogleFonts.readexPro(
// //                                                 fontWeight: Theme.of(context)
// //                                                     .fontFamily
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .fontWeight,
// //                                                 fontStyle: Theme.of(context)
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .fontStyle,
// //                                               ).fontFamily,
// //                                               letterSpacing: 0.0,
// //                                               fontWeight: Theme.of(context)
// //                                                   .textTheme
// //                                                   .bodyMedium!
// //                                                   .fontWeight,
// //                                               fontStyle:
// //                                                   Theme.of(context).textTheme.bodyMedium!.fontStyle,
// //                                             ),
// //                                       ),
// //                                     ),
// //                                     Text(
// //                                       valueOrDefault<String>(
// //                                         MainGroup.getCurrentOTMobileCall.otStartTime(
// //                                           (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //                                         ),
// //                                         '08:00',
// //                                       ),
// //                                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                                             fontFamily: GoogleFonts.readexPro(
// //                                               fontWeight: Theme.of(context)
// //                                                   .fontFamily
// //                                                   .textTheme
// //                                                   .bodyMedium!
// //                                                   .fontWeight,
// //                                               fontStyle:
// //                                                   Theme.of(context).textTheme.bodyMedium!.fontStyle,
// //                                             ).fontFamily,
// //                                             letterSpacing: 0.0,
// //                                             fontWeight:
// //                                                 Theme.of(context).textTheme.bodyMedium!.fontWeight,
// //                                             fontStyle:
// //                                                 Theme.of(context).textTheme.bodyMedium!.fontStyle,
// //                                           ),
// //                                     ),
// //                                     Text(
// //                                       FFLocalizations.of(context).getText(
// //                                         'tyrukrk2' /*  - */,
// //                                       ),
// //                                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                                             fontFamily: GoogleFonts.readexPro(
// //                                               fontWeight: Theme.of(context)
// //                                                   .fontFamily
// //                                                   .textTheme
// //                                                   .bodyMedium!
// //                                                   .fontWeight,
// //                                               fontStyle:
// //                                                   Theme.of(context).textTheme.bodyMedium!.fontStyle,
// //                                             ).fontFamily,
// //                                             letterSpacing: 0.0,
// //                                             fontWeight:
// //                                                 Theme.of(context).textTheme.bodyMedium!.fontWeight,
// //                                             fontStyle:
// //                                                 Theme.of(context).textTheme.bodyMedium!.fontStyle,
// //                                           ),
// //                                     ),
// //                                     Padding(
// //                                       padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
// //                                       child: Text(
// //                                         valueOrDefault<String>(
// //                                           MainGroup.getCurrentOTMobileCall.otEndTime(
// //                                             (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //                                           ),
// //                                           '17:00',
// //                                         ),
// //                                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                                               fontFamily: GoogleFonts.readexPro(
// //                                                 fontWeight: Theme.of(context)
// //                                                     .fontFamily
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .fontWeight,
// //                                                 fontStyle: Theme.of(context)
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .fontStyle,
// //                                               ).fontFamily,
// //                                               letterSpacing: 0.0,
// //                                               fontWeight: Theme.of(context)
// //                                                   .textTheme
// //                                                   .bodyMedium!
// //                                                   .fontWeight,
// //                                               fontStyle:
// //                                                   Theme.of(context).textTheme.bodyMedium!.fontStyle,
// //                                             ),
// //                                       ),
// //                                     ),
// //                                     Padding(
// //                                       padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
// //                                       child: Text(
// //                                         valueOrDefault<String>(
// //                                           MainGroup.getCurrentOTMobileCall.oTHour(
// //                                             (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //                                           ),
// //                                           '2 hr 30 min',
// //                                         ),
// //                                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                                               fontFamily: GoogleFonts.readexPro(
// //                                                 fontWeight: Theme.of(context)
// //                                                     .fontFamily
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .fontWeight,
// //                                                 fontStyle: Theme.of(context)
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .fontStyle,
// //                                               ).fontFamily,
// //                                               letterSpacing: 0.0,
// //                                               fontWeight: Theme.of(context)
// //                                                   .textTheme
// //                                                   .bodyMedium!
// //                                                   .fontWeight,
// //                                               fontStyle:
// //                                                   Theme.of(context).textTheme.bodyMedium!.fontStyle,
// //                                             ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                               Divider(
// //                                 thickness: 1.0,
// //                                 color: Theme.of(context).colorScheme.surface,
// //                               ),
// //                               Row(
// //                                 mainAxisSize: MainAxisSize.max,
// //                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Column(
// //                                     mainAxisSize: MainAxisSize.min,
// //                                     mainAxisAlignment: MainAxisAlignment.center,
// //                                     children: [
// //                                       Row(
// //                                         mainAxisSize: MainAxisSize.max,
// //                                         children: [
// //                                           Column(
// //                                             mainAxisSize: MainAxisSize.max,
// //                                             children: [
// //                                               Padding(
// //                                                 padding: EdgeInsets.all(8.0),
// //                                                 child: Text(
// //                                                   FFLocalizations.of(context).getText(
// //                                                     'ydrku3fa' /* Check in */,
// //                                                   ),
// //                                                   style: Theme.of(context)
// //                                                       .textTheme
// //                                                       .bodyMedium!
// //                                                       .copyWith(
// //                                                         fontFamily: GoogleFonts.readexPro(
// //                                                           fontWeight: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontWeight,
// //                                                           fontStyle: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontStyle,
// //                                                         ),
// //                                                         letterSpacing: 0.0,
// //                                                         fontWeight: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ),
// //                                                 ),
// //                                               ),
// //                                               Padding(
// //                                                 padding: EdgeInsets.all(8.0),
// //                                                 child: Text(
// //                                                   valueOrDefault<String>(
// //                                                     AppState().otClockInTime,
// //                                                     '-',
// //                                                   ),
// //                                                   style: Theme.of(context)
// //                                                       .textTheme
// //                                                       .bodyMedium!
// //                                                       .copyWith(
// //                                                         fontFamily: GoogleFonts.readexPro(
// //                                                           fontWeight: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontWeight,
// //                                                           fontStyle: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontStyle,
// //                                                         ),
// //                                                         color: AppColors.timeCheckin,
// //                                                         letterSpacing: 0.0,
// //                                                         fontWeight: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ),
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           ),
// //                                           SizedBox(
// //                                             height: 50.0,
// //                                             child: VerticalDivider(
// //                                               thickness: 1.0,
// //                                               color: Theme.of(context).textTheme.bodyMedium?.color,
// //                                             ),
// //                                           ),
// //                                           Column(
// //                                             mainAxisSize: MainAxisSize.max,
// //                                             children: [
// //                                               Padding(
// //                                                 padding: EdgeInsets.all(8.0),
// //                                                 child: Text(
// //                                                   FFLocalizations.of(context).getText(
// //                                                     'bb1ouzmo' /* Check out */,
// //                                                   ),
// //                                                   style: Theme.of(context)
// //                                                       .textTheme
// //                                                       .bodyMedium!
// //                                                       .copyWith(
// //                                                         fontFamily: GoogleFonts.readexPro(
// //                                                           fontWeight: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontWeight,
// //                                                           fontStyle: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontStyle,
// //                                                         ),
// //                                                         letterSpacing: 0.0,
// //                                                         fontWeight: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ),
// //                                                 ),
// //                                               ),
// //                                               Padding(
// //                                                 padding: EdgeInsets.all(8.0),
// //                                                 child: Text(
// //                                                   valueOrDefault<String>(
// //                                                     AppState().otClockOutTime,
// //                                                     '-',
// //                                                   ),
// //                                                   style: Theme.of(context)
// //                                                       .textTheme
// //                                                       .bodyMedium!
// //                                                       .copyWith(
// //                                                         fontFamily: GoogleFonts.readexPro(
// //                                                           fontWeight: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontWeight,
// //                                                           fontStyle: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontStyle,
// //                                                         ),
// //                                                         color: AppColors.timeCheckin,
// //                                                         letterSpacing: 0.0,
// //                                                         fontWeight: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ),
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           ),
// //                                         ],
// //                                       ),
// //                                       Align(
// //                                         alignment: AlignmentDirectional(-1.0, -1.0),
// //                                         child: Padding(
// //                                           padding:
// //                                               EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 40.0, 0.0),
// //                                           child: Row(
// //                                             mainAxisSize: MainAxisSize.max,
// //                                             mainAxisAlignment: MainAxisAlignment.start,
// //                                             crossAxisAlignment: CrossAxisAlignment.center,
// //                                             children: [
// //                                               Text(
// //                                                 FFLocalizations.of(context).getText(
// //                                                   'mkppa3jc' /* Total : */,
// //                                                 ),
// //                                                 textAlign: TextAlign.start,
// //                                                 style: Theme.of(context)
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .copyWith(
// //                                                       fontFamily: GoogleFonts.readexPro(
// //                                                         fontWeight: Theme.of(context)
// //                                                             .fontFamily
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ).fontFamily,
// //                                                       letterSpacing: 0.0,
// //                                                       fontWeight: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontWeight,
// //                                                       fontStyle: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontStyle,
// //                                                     ),
// //                                               ),
// //                                               Padding(
// //                                                 padding: EdgeInsetsDirectional.fromSTEB(
// //                                                     10.0, 0.0, 0.0, 0.0),
// //                                                 child: Text(
// //                                                   valueOrDefault<String>(
// //                                                     (AppState().otClockInTime != '-') &&
// //                                                             (AppState().otClockOutTime != '-')
// //                                                         ? functions.calculateOTHourFunction(
// //                                                             AppState().otClockInTime,
// //                                                             AppState().otClockOutTime)
// //                                                         : '00 hr 00 min',
// //                                                     '00 hr 00 min',
// //                                                   ),
// //                                                   style: Theme.of(context)
// //                                                       .textTheme
// //                                                       .bodyMedium!
// //                                                       .copyWith(
// //                                                         fontFamily: GoogleFonts.readexPro(
// //                                                           fontWeight: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontWeight,
// //                                                           fontStyle: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontStyle,
// //                                                         ),
// //                                                         letterSpacing: 0.0,
// //                                                         fontWeight: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ),
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   Column(
// //                                     mainAxisSize: MainAxisSize.max,
// //                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                                     children: [
// //                                       Container(
// //                                         width: MediaQuery.sizeOf(context).width * 0.356,
// //                                         height: MediaQuery.sizeOf(context).height * 0.169,
// //                                         constraints: BoxConstraints(
// //                                           maxWidth: 150.0,
// //                                           maxHeight: 150.0,
// //                                         ),
// //                                         decoration: BoxDecoration(
// //                                           color: () {
// //                                             if (AppState().otClockInTime == '-') {
// //                                               return Theme.of(context).colorScheme.primary;
// //                                             } else if ((AppState().otClockInTime != '-') &&
// //                                                 (AppState().otClockOutTime != '-')) {
// //                                               return Color(0xFFFFA500);
// //                                             } else {
// //                                               return Color(0xFF57636C);
// //                                             }
// //                                           }(),
// //                                           borderRadius: BorderRadius.circular(10.0),
// //                                         ),
// //                                         child: InkWell(
// //                                           splashColor: Colors.transparent,
// //                                           focusColor: Colors.transparent,
// //                                           hoverColor: Colors.transparent,
// //                                           highlightColor: Colors.transparent,
// //                                           onTap: () async {
// //                                             if (AppState().otClockInTime == '-') {
// //                                               Navigator.of(context).pushNamed(
// //                                                 OvertimeDetailWidget.routeName,
// //                                               );
// //                                             } else {
// //                                               if (AppState().otClockOutTime == '-') {
// //                                                 Navigator.of(context).pushNamed(
// //                                                   OvertimeDetailCheckOutWidget.routeName,
// //                                                 );
// //                                               }
// //                                             }
// //                                           },
// //                                           child: Column(
// //                                             mainAxisSize: MainAxisSize.max,
// //                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                                             children: [
// //                                               Icon(
// //                                                 Icons.fingerprint,
// //                                                 color: Theme.of(context).colorScheme.surface,
// //                                                 size: 100.0,
// //                                               ),
// //                                               Text(
// //                                                 () {
// //                                                   if (AppState().otClockInTime == '-') {
// //                                                     return 'Check In';
// //                                                   } else if ((AppState().otClockInTime != '-') &&
// //                                                       (AppState().otClockOutTime == '-')) {
// //                                                     return 'Check Out';
// //                                                   } else {
// //                                                     return 'Completed';
// //                                                   }
// //                                                 }(),
// //                                                 textAlign: TextAlign.center,
// //                                                 style: Theme.of(context)
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .copyWith(
// //                                                       fontFamily: GoogleFonts.readexPro(
// //                                                         fontWeight: Theme.of(context)
// //                                                             .fontFamily
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ).fontFamily,
// //                                                       letterSpacing: 0.0,
// //                                                       fontWeight: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontWeight,
// //                                                       fontStyle: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontStyle,
// //                                                     ),
// //                                               ),
// //                                             ],
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   if (!functions
// //                       .overtimeShowDataFunction(MainGroup.getCurrentOTMobileCall.currentOTList(
// //                     (_model.apiResultCurrentOTime?.jsonBody ?? ''),
// //                   )))
// //                     Padding(
// //                       padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
// //                       child: Container(
// //                         width: double.infinity,
// //                         height: 100.0,
// //                         decoration: BoxDecoration(
// //                           color: Theme.of(context).colorScheme.secondaryBackground,
// //                           borderRadius: BorderRadius.circular(12.0),
// //                           border: Border.all(
// //                             color: Color(0xFFB4AFAF),
// //                           ),
// //                         ),
// //                         child: Align(
// //                           alignment: AlignmentDirectional(0.0, 0.0),
// //                           child: Text(
// //                             FFLocalizations.of(context).getText(
// //                               'buy7hooh' /* There is no overtime shift tim... */,
// //                             ),
// //                             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                                   fontFamily: GoogleFonts.readexPro(
// //                                     fontWeight: Theme.of(context)
// //                                         .fontFamily
// //                                         .textTheme
// //                                         .bodyMedium!
// //                                         .fontWeight,
// //                                     fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
// //                                   ).fontFamily,
// //                                   letterSpacing: 0.0,
// //                                   fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
// //                                   fontStyle: Theme.of(context).textTheme.bodyMedium!.fontStyle,
// //                                 ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                 ],
// //               ),
// //               Expanded(
// //                 child: Column(
// //                   children: [
// //                     Align(
// //                       alignment: Alignment(0.0, 0),
// //                       child: FlutterFlowButtonTabBar(
// //                         labelStyle: GoogleFonts.readexPro(
// //                           fontSize: 14.0,
// //                           letterSpacing: 0.0,
// //                           fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight ??
// //                               FontWeight.normal,
// //                           fontStyle: Theme.of(context).textTheme.titleMedium?.fontStyle ??
// //                               FontStyle.normal,
// //                         ),
// //                         unselectedLabelStyle: TextStyle(),
// //                         labelColor: Theme.of(context).colorScheme.secondaryBackground,
// //                         unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
// //                         backgroundColor: Color(0xFFF9B052),
// //                         unselectedBackgroundColor:
// //                             Theme.of(context).colorScheme.secondaryBackground,
// //                         borderColor: Theme.of(context).colorScheme.primary,
// //                         borderWidth: 2.0,
// //                         borderRadius: BorderRadius.circular(8.0),
// //                         elevation: 0.0,
// //                         padding: EdgeInsets.all(4.0),
// //                         tabs: [
// //                           Tab(
// //                             text: FFLocalizations.of(context).getText(
// //                               'sj8hmsk2' /* Approved */,
// //                             ),
// //                           ),
// //                           Tab(
// //                             text: FFLocalizations.of(context).getText(
// //                               '13p5hmxl' /* Pending */,
// //                             ),
// //                           ),
// //                           Tab(
// //                             text: FFLocalizations.of(context).getText(
// //                               'x6kkqkiq' /* Histoy */,
// //                             ),
// //                           ),
// //                         ],
// //                         controller: _model.tabBarController!,
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: TabBarView(
// //                         controller: _model.tabBarController,
// //                         children: [
// //                           Column(
// //                             mainAxisSize: MainAxisSize.max,
// //                             children: [
// //                               Padding(
// //                                 padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 0.0, 10.0),
// //                                 child: Row(
// //                                   mainAxisSize: MainAxisSize.max,
// //                                   children: [
// //                                     Container(
// //                                       width: 210.0,
// //                                       height: 40.0,
// //                                       decoration: BoxDecoration(
// //                                         color: Theme.of(context).colorScheme.surface,
// //                                         borderRadius: BorderRadius.circular(4.0),
// //                                         border: Border.all(
// //                                           color: Theme.of(context).colorScheme.surface,
// //                                           width: 1.0,
// //                                         ),
// //                                       ),
// //                                       child: InkWell(
// //                                         splashColor: Colors.transparent,
// //                                         focusColor: Colors.transparent,
// //                                         hoverColor: Colors.transparent,
// //                                         highlightColor: Colors.transparent,
// //                                         onTap: () async {
// //                                           _model.yeardata = dateTimeFormat(
// //                                             "yyyy",
// //                                             getCurrentTimestamp,
// //                                             locale: FFLocalizations.of(context).languageCode,
// //                                           );
// //                                           _model.monthData = dateTimeFormat(
// //                                             "MM",
// //                                             getCurrentTimestamp,
// //                                             locale: FFLocalizations.of(context).languageCode,
// //                                           );
// //                                           safeSetState(() {});
// //                                           _model.apiResultftp =
// //                                               await MainGroup.getOTRequestByStatusMobileCall.call(
// //                                             monthNum: dateTimeFormat(
// //                                               "MM",
// //                                               getCurrentTimestamp,
// //                                               locale: FFLocalizations.of(context).languageCode,
// //                                             ),
// //                                             yearNum: dateTimeFormat(
// //                                               "yyyy",
// //                                               getCurrentTimestamp,
// //                                               locale: FFLocalizations.of(context).languageCode,
// //                                             ),
// //                                             status: 1,
// //                                             employeeID: AppState().employeeID,
// //                                             companyID: AppState().companyID,
// //                                             token: AppState().token,
// //                                           );

// //                                           if ((_model.apiResultftp?.succeeded ?? true)) {
// //                                             _model.overtimeApprovedTab = getJsonField(
// //                                               (_model.apiResultftp?.jsonBody ?? ''),
// //                                               r'''$.data''',
// //                                             )!
// //                                                 .toList()
// //                                                 .cast<dynamic>();
// //                                             safeSetState(() {});
// //                                           }

// //                                           safeSetState(() {});
// //                                         },
// //                                         child: Row(
// //                                           mainAxisSize: MainAxisSize.max,
// //                                           children: [
// //                                             Padding(
// //                                               padding: EdgeInsetsDirectional.fromSTEB(
// //                                                   5.0, 0.0, 0.0, 0.0),
// //                                               child: Text(
// //                                                 FFLocalizations.of(context).getText(
// //                                                   'w8yzgxer' /* Month:  */,
// //                                                 ),
// //                                                 style: Theme.of(context)
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .copyWith(
// //                                                       fontFamily: GoogleFonts.readexPro(
// //                                                         fontWeight: Theme.of(context)
// //                                                             .fontFamily
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ).fontFamily,
// //                                                       color: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium
// //                                                           ?.color,
// //                                                       letterSpacing: 0.0,
// //                                                       fontWeight: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontWeight,
// //                                                       fontStyle: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontStyle,
// //                                                     ),
// //                                               ),
// //                                             ),
// //                                             Text(
// //                                               dateTimeFormat(
// //                                                 "MMM",
// //                                                 getCurrentTimestamp,
// //                                                 locale: FFLocalizations.of(context).languageCode,
// //                                               ),
// //                                               style:
// //                                                   Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                                                         fontFamily: GoogleFonts.readexPro(
// //                                                           fontWeight: Theme.of(context)
// //                                                               .fontFamily
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontWeight,
// //                                                           fontStyle: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontStyle,
// //                                                         ).fontFamily,
// //                                                         color: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium
// //                                                             ?.color,
// //                                                         letterSpacing: 0.0,
// //                                                         fontWeight: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ),
// //                                             ),
// //                                             Padding(
// //                                               padding: EdgeInsetsDirectional.fromSTEB(
// //                                                   5.0, 0.0, 0.0, 0.0),
// //                                               child: Text(
// //                                                 FFLocalizations.of(context).getText(
// //                                                   'gmtn4nly' /* Year:  */,
// //                                                 ),
// //                                                 style: Theme.of(context)
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .copyWith(
// //                                                       fontFamily: GoogleFonts.readexPro(
// //                                                         fontWeight: Theme.of(context)
// //                                                             .fontFamily
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ).fontFamily,
// //                                                       color: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium
// //                                                           ?.color,
// //                                                       letterSpacing: 0.0,
// //                                                       fontWeight: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontWeight,
// //                                                       fontStyle: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontStyle,
// //                                                     ),
// //                                               ),
// //                                             ),
// //                                             Text(
// //                                               dateTimeFormat(
// //                                                 "yyyy",
// //                                                 getCurrentTimestamp,
// //                                                 locale: FFLocalizations.of(context).languageCode,
// //                                               ),
// //                                               style:
// //                                                   Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                                                         fontFamily: GoogleFonts.readexPro(
// //                                                           fontWeight: Theme.of(context)
// //                                                               .fontFamily
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontWeight,
// //                                                           fontStyle: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontStyle,
// //                                                         ).fontFamily,
// //                                                         color: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium
// //                                                             ?.color,
// //                                                         letterSpacing: 0.0,
// //                                                         fontWeight: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ),
// //                                             ),
// //                                             Padding(
// //                                               padding: EdgeInsetsDirectional.fromSTEB(
// //                                                   3.0, 0.0, 0.0, 0.0),
// //                                               child: Icon(
// //                                                 Icons.calendar_month,
// //                                                 color:
// //                                                     Theme.of(context).textTheme.bodyMedium?.color,
// //                                                 size: 22.0,
// //                                               ),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                               Expanded(
// //                                 child: Builder(
// //                                   builder: (context) {
// //                                     final overtimeApproved = _model.overtimeApprovedTab.toList();

// //                                     return ListView.builder(
// //                                       padding: EdgeInsets.zero,
// //                                       shrinkWrap: true,
// //                                       scrollDirection: Axis.vertical,
// //                                       itemCount: overtimeApproved.length,
// //                                       itemBuilder: (context, overtimeApprovedIndex) {
// //                                         final overtimeApprovedItem =
// //                                             overtimeApproved[overtimeApprovedIndex];
// //                                         return Align(
// //                                           alignment: AlignmentDirectional(-1.0, -1.0),
// //                                           child: Padding(
// //                                             padding:
// //                                                 EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 5.0),
// //                                             child: Container(
// //                                               width: double.infinity,
// //                                               height: 220.0,
// //                                               decoration: BoxDecoration(
// //                                                 color: Theme.of(context).colorScheme.surface,
// //                                                 borderRadius: BorderRadius.only(
// //                                                   bottomLeft: Radius.circular(13.0),
// //                                                   bottomRight: Radius.circular(13.0),
// //                                                   topLeft: Radius.circular(13.0),
// //                                                   topRight: Radius.circular(13.0),
// //                                                 ),
// //                                               ),
// //                                               child: SingleChildScrollView(
// //                                                 child: Column(
// //                                                   mainAxisSize: MainAxisSize.max,
// //                                                   children: [
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       mainAxisAlignment:
// //                                                           MainAxisAlignment.spaceBetween,
// //                                                       children: [
// //                                                         Column(
// //                                                           mainAxisSize: MainAxisSize.max,
// //                                                           children: [
// //                                                             Padding(
// //                                                               padding:
// //                                                                   EdgeInsetsDirectional.fromSTEB(
// //                                                                       10.0, 8.0, 15.0, 0.0),
// //                                                               child: Text(
// //                                                                 valueOrDefault<String>(
// //                                                                   getJsonField(
// //                                                                     overtimeApprovedItem,
// //                                                                     r'''$.workFlow_Name''',
// //                                                                   )?.toString(),
// //                                                                   'OT',
// //                                                                 ),
// //                                                                 style: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .copyWith(
// //                                                                       fontFamily:
// //                                                                           GoogleFonts.readexPro(
// //                                                                         fontWeight:
// //                                                                             Theme.of(context)
// //                                                                                 .textTheme
// //                                                                                 .bodyMedium!
// //                                                                                 .fontWeight,
// //                                                                         fontStyle: Theme.of(context)
// //                                                                             .textTheme
// //                                                                             .bodyMedium!
// //                                                                             .fontStyle,
// //                                                                       ),
// //                                                                       color: Color(0xFFF89D27),
// //                                                                       letterSpacing: 0.0,
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                               ),
// //                                                             ),
// //                                                           ],
// //                                                         ),
// //                                                         Column(
// //                                                           mainAxisSize: MainAxisSize.max,
// //                                                           children: [
// //                                                             Align(
// //                                                               alignment:
// //                                                                   AlignmentDirectional(0.0, 0.0),
// //                                                               child: Padding(
// //                                                                 padding:
// //                                                                     EdgeInsetsDirectional.fromSTEB(
// //                                                                         0.0, 15.0, 20.0, 0.0),
// //                                                                 child: AppButton(
// //                                                                   onPressed: () {
// //                                                                     print('Button pressed ...');
// //                                                                   },
// //                                                                   text: getJsonField(
// //                                                                     overtimeApprovedItem,
// //                                                                     r'''$.status''',
// //                                                                   ).toString(),
// //                                                                   options: FFButtonOptions(
// //                                                                     height: 30.0,
// //                                                                     padding: EdgeInsetsDirectional
// //                                                                         .fromSTEB(
// //                                                                             24.0, 0.0, 24.0, 0.0),
// //                                                                     iconPadding:
// //                                                                         EdgeInsetsDirectional
// //                                                                             .fromSTEB(
// //                                                                                 0.0, 0.0, 0.0, 0.0),
// //                                                                     color: functions
// //                                                                         .overtimeStatusBackgroundColor(
// //                                                                             getJsonField(
// //                                                                       overtimeApprovedItem,
// //                                                                       r'''$.status''',
// //                                                                     ).toString()),
// //                                                                     textStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .titleSmall!
// //                                                                         .copyWith(
// //                                                                           fontFamily:
// //                                                                               GoogleFonts.readexPro(
// //                                                                             fontWeight: Theme.of(
// //                                                                                         context)
// //                                                                                     .textTheme
// //                                                                                     .titleSmall
// //                                                                                     ?.fontWeight ??
// //                                                                                 FontWeight.normal,
// //                                                                             fontStyle: Theme.of(
// //                                                                                         context)
// //                                                                                     .textTheme
// //                                                                                     .titleSmall
// //                                                                                     ?.fontStyle ??
// //                                                                                 FontStyle.normal,
// //                                                                           ).fontFamily,
// //                                                                           color: functions
// //                                                                               .overtimeStatusTextColor(
// //                                                                                   getJsonField(
// //                                                                             overtimeApprovedItem,
// //                                                                             r'''$.status''',
// //                                                                           ).toString()),
// //                                                                           letterSpacing: 0.0,
// //                                                                           fontWeight:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .titleSmall!
// //                                                                                   .fontWeight,
// //                                                                           fontStyle:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .titleSmall!
// //                                                                                   .fontStyle,
// //                                                                         ),
// //                                                                     elevation: 3.0,
// //                                                                     borderSide: BorderSide(
// //                                                                       color: Colors.transparent,
// //                                                                       width: 1.0,
// //                                                                     ),
// //                                                                     borderRadius:
// //                                                                         BorderRadius.circular(24.0),
// //                                                                   ),
// //                                                                 ),
// //                                                               ),
// //                                                             ),
// //                                                           ],
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               10.0, 0.0, 0.0, 8.0),
// //                                                           child: Text(
// //                                                             FFLocalizations.of(context).getText(
// //                                                               '3f2xdgj0' /* Amount */,
// //                                                             ),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   color: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium
// //                                                                       ?.color,
// //                                                                   fontSize: 12.0,
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 0.0, 0.0, 8.0),
// //                                                             child: Text(
// //                                                               valueOrDefault<String>(
// //                                                                 functions.leaveDayAmountFunction(
// //                                                                     getJsonField(
// //                                                                       overtimeApprovedItem,
// //                                                                       r'''$.start_Date''',
// //                                                                     ).toString(),
// //                                                                     getJsonField(
// //                                                                       overtimeApprovedItem,
// //                                                                       r'''$.end_Date''',
// //                                                                     ).toString(),
// //                                                                     getJsonField(
// //                                                                       overtimeApprovedItem,
// //                                                                       r'''$.oT_Start_Time''',
// //                                                                     ).toString(),
// //                                                                     getJsonField(
// //                                                                       overtimeApprovedItem,
// //                                                                       r'''$.oT_End_Time''',
// //                                                                     ).toString()),
// //                                                                 'OverTimeDayAmount',
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     color: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium
// //                                                                         ?.color,
// //                                                                     fontSize: 10.0,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 0.0, 0.0, 8.0),
// //                                                             child: Text(
// //                                                               FFLocalizations.of(context).getText(
// //                                                                 'jkmwzdoj' /* From  */,
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     color: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium
// //                                                                         ?.color,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(0.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 0.0, 0.0, 5.0, 8.0),
// //                                                             child: Text(
// //                                                               valueOrDefault<String>(
// //                                                                 functions
// //                                                                     .changeDateFormat(getJsonField(
// //                                                                   overtimeApprovedItem,
// //                                                                   r'''$.start_Date''',
// //                                                                 ).toString()),
// //                                                                 'start date',
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(0.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 0.0, 0.0, 0.0, 8.0),
// //                                                             child: Text(
// //                                                               getJsonField(
// //                                                                 overtimeApprovedItem,
// //                                                                 r'''$.oT_Start_Time''',
// //                                                               ).toString(),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               0.0, 0.0, 0.0, 8.0),
// //                                                           child: Text(
// //                                                             FFLocalizations.of(context).getText(
// //                                                               '3n0duixp' /*  - */,
// //                                                             ),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               5.0, 0.0, 0.0, 8.0),
// //                                                           child: Text(
// //                                                             getJsonField(
// //                                                               overtimeApprovedItem,
// //                                                               r'''$.oT_End_Time''',
// //                                                             ).toString(),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 0.0, 0.0, 0.0),
// //                                                             child: Text(
// //                                                               FFLocalizations.of(context).getText(
// //                                                                 'mee4aeun' /* Note :  */,
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     fontSize: 10.0,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Text(
// //                                                           getJsonField(
// //                                                             overtimeApprovedItem,
// //                                                             r'''$.purpose_OT''',
// //                                                           ).toString(),
// //                                                           style: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .copyWith(
// //                                                                 fontFamily: GoogleFonts.readexPro(
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                                 letterSpacing: 0.0,
// //                                                                 fontWeight: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .fontWeight,
// //                                                                 fontStyle: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .fontStyle,
// //                                                               ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Builder(
// //                                                       builder: (context) => InkWell(
// //                                                         splashColor: Colors.transparent,
// //                                                         focusColor: Colors.transparent,
// //                                                         hoverColor: Colors.transparent,
// //                                                         highlightColor: Colors.transparent,
// //                                                         onTap: () async {
// //                                                           if ((getJsonField(
// //                                                             overtimeApprovedItem,
// //                                                             r'''$.attachmentlist''',
// //                                                           )
// //                                                                       .toList()
// //                                                                       .map<AttachmentFileModelStruct?>(
// //                                                                           AttachmentFileModelStruct
// //                                                                               .maybeFromMap)
// //                                                                       .toList()
// //                                                                   as Iterable<
// //                                                                       AttachmentFileModelStruct?>)
// //                                                               .withoutNulls
// //                                                               .isNotEmpty) {
// //                                                             await showDialog(
// //                                                               context: context,
// //                                                               builder: (dialogContext) {
// //                                                                 return Dialog(
// //                                                                   elevation: 0,
// //                                                                   insetPadding: EdgeInsets.zero,
// //                                                                   backgroundColor:
// //                                                                       Colors.transparent,
// //                                                                   alignment:
// //                                                                       AlignmentDirectional(0.0, 0.0)
// //                                                                           .resolve(
// //                                                                               Directionality.of(
// //                                                                                   context)),
// //                                                                   child: WebViewAware(
// //                                                                     child: GestureDetector(
// //                                                                       onTap: () {
// //                                                                         FocusScope.of(dialogContext)
// //                                                                             .unfocus();
// //                                                                         FocusManager
// //                                                                             .instance.primaryFocus
// //                                                                             ?.unfocus();
// //                                                                       },
// //                                                                       child:
// //                                                                           OvertimeAttachmentModelWidget(
// //                                                                         oTRequestID: 0,
// //                                                                         attachmentList:
// //                                                                             getJsonField(
// //                                                                           overtimeApprovedItem,
// //                                                                           r'''$.attachmentlist''',
// //                                                                         )!,
// //                                                                       ),
// //                                                                     ),
// //                                                                   ),
// //                                                                 );
// //                                                               },
// //                                                             );
// //                                                           }
// //                                                         },
// //                                                         child: Row(
// //                                                           mainAxisSize: MainAxisSize.max,
// //                                                           children: [
// //                                                             Padding(
// //                                                               padding:
// //                                                                   EdgeInsetsDirectional.fromSTEB(
// //                                                                       10.0, 10.0, 0.0, 0.0),
// //                                                               child: Text(
// //                                                                 valueOrDefault<String>(
// //                                                                   functions
// //                                                                       .attachmentCountFunction(
// //                                                                           (getJsonField(
// //                                                                         overtimeApprovedItem,
// //                                                                         r'''$.attachmentlist''',
// //                                                                       ) as List)
// //                                                                               .map<String>((s) =>
// //                                                                                   s.toString())
// //                                                                               .toList())
// //                                                                       .toString(),
// //                                                                   '0',
// //                                                                 ),
// //                                                                 style: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .copyWith(
// //                                                                       fontFamily:
// //                                                                           GoogleFonts.readexPro(
// //                                                                         fontWeight:
// //                                                                             Theme.of(context)
// //                                                                                 .textTheme
// //                                                                                 .bodyMedium!
// //                                                                                 .fontWeight,
// //                                                                         fontStyle: Theme.of(context)
// //                                                                             .textTheme
// //                                                                             .bodyMedium!
// //                                                                             .fontStyle,
// //                                                                       ),
// //                                                                       color: Theme.of(context)
// //                                                                           .colorScheme
// //                                                                           .primary,
// //                                                                       fontSize: 10.0,
// //                                                                       letterSpacing: 0.0,
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                               ),
// //                                                             ),
// //                                                             Align(
// //                                                               alignment:
// //                                                                   AlignmentDirectional(-1.0, 0.0),
// //                                                               child: Padding(
// //                                                                 padding:
// //                                                                     EdgeInsetsDirectional.fromSTEB(
// //                                                                         5.0, 10.0, 0.0, 0.0),
// //                                                                 child: Text(
// //                                                                   FFLocalizations.of(context)
// //                                                                       .getText(
// //                                                                     'pj3psnly' /* attachement */,
// //                                                                   ),
// //                                                                   style: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .copyWith(
// //                                                                         fontFamily:
// //                                                                             GoogleFonts.readexPro(
// //                                                                           fontWeight:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .bodyMedium!
// //                                                                                   .fontWeight,
// //                                                                           fontStyle:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .bodyMedium!
// //                                                                                   .fontStyle,
// //                                                                         ),
// //                                                                         color: Color(0xFFF89D27),
// //                                                                         fontSize: 10.0,
// //                                                                         letterSpacing: 0.0,
// //                                                                         fontWeight:
// //                                                                             Theme.of(context)
// //                                                                                 .textTheme
// //                                                                                 .bodyMedium!
// //                                                                                 .fontWeight,
// //                                                                         fontStyle: Theme.of(context)
// //                                                                             .textTheme
// //                                                                             .bodyMedium!
// //                                                                             .fontStyle,
// //                                                                       ),
// //                                                                 ),
// //                                                               ),
// //                                                             ),
// //                                                           ],
// //                                                         ),
// //                                                       ),
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 8.0, 0.0, 0.0),
// //                                                             child: Text(
// //                                                               FFLocalizations.of(context).getText(
// //                                                                 'q3mekv41' /* Request date :  */,
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     color:
// //                                                                         AppColors.overtimetextcolor,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               0.0, 8.0, 0.0, 0.0),
// //                                                           child: Text(
// //                                                             valueOrDefault<String>(
// //                                                               functions.changeRequestedDateFormat(
// //                                                                   getJsonField(
// //                                                                 overtimeApprovedItem,
// //                                                                 r'''$.oT_Requested_Date''',
// //                                                               ).toString()),
// //                                                               'request Date',
// //                                                             ),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   color:
// //                                                                       AppColors.overtimetextcolor,
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Divider(
// //                                                       color: Theme.of(context).colorScheme.surface,
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       mainAxisAlignment:
// //                                                           MainAxisAlignment.spaceBetween,
// //                                                       children: [
// //                                                         Container(
// //                                                           width: 250.0,
// //                                                           height: 20.0,
// //                                                           decoration: BoxDecoration(
// //                                                             color: Theme.of(context)
// //                                                                 .colorScheme
// //                                                                 .surface,
// //                                                           ),
// //                                                           child: Row(
// //                                                             mainAxisSize: MainAxisSize.max,
// //                                                             children: [
// //                                                               Padding(
// //                                                                 padding:
// //                                                                     EdgeInsetsDirectional.fromSTEB(
// //                                                                         10.0, 0.0, 0.0, 0.0),
// //                                                                 child: Text(
// //                                                                   FFLocalizations.of(context)
// //                                                                       .getText(
// //                                                                     'g9fvj8v3' /* Approved by :  */,
// //                                                                   ),
// //                                                                   style: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .copyWith(
// //                                                                         fontFamily:
// //                                                                             GoogleFonts.readexPro(
// //                                                                           fontWeight:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .bodyMedium!
// //                                                                                   .fontWeight,
// //                                                                           fontStyle:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .bodyMedium!
// //                                                                                   .fontStyle,
// //                                                                         ),
// //                                                                         color: AppColors
// //                                                                             .overtimetextcolor,
// //                                                                         fontSize: 12.0,
// //                                                                         letterSpacing: 0.0,
// //                                                                         fontWeight:
// //                                                                             Theme.of(context)
// //                                                                                 .textTheme
// //                                                                                 .bodyMedium!
// //                                                                                 .fontWeight,
// //                                                                         fontStyle: Theme.of(context)
// //                                                                             .textTheme
// //                                                                             .bodyMedium!
// //                                                                             .fontStyle,
// //                                                                       ),
// //                                                                 ),
// //                                                               ),
// //                                                               Text(
// //                                                                 getJsonField(
// //                                                                   overtimeApprovedItem,
// //                                                                   r'''$.approver_Name''',
// //                                                                 ).toString(),
// //                                                                 style: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .copyWith(
// //                                                                       fontFamily:
// //                                                                           GoogleFonts.readexPro(
// //                                                                         fontWeight:
// //                                                                             Theme.of(context)
// //                                                                                 .textTheme
// //                                                                                 .bodyMedium!
// //                                                                                 .fontWeight,
// //                                                                         fontStyle: Theme.of(context)
// //                                                                             .textTheme
// //                                                                             .bodyMedium!
// //                                                                             .fontStyle,
// //                                                                       ),
// //                                                                       color: AppColors
// //                                                                           .overtimetextcolor,
// //                                                                       letterSpacing: 0.0,
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                               ),
// //                                                             ],
// //                                                           ),
// //                                                         ),
// //                                                         Container(
// //                                                           width: 100.0,
// //                                                           height: 20.0,
// //                                                           decoration: BoxDecoration(
// //                                                             color: Theme.of(context)
// //                                                                 .colorScheme
// //                                                                 .surface,
// //                                                           ),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 0.0, 0.0, 10.0, 0.0),
// //                                                             child: Text(
// //                                                               getJsonField(
// //                                                                 overtimeApprovedItem,
// //                                                                 r'''$.status''',
// //                                                               ).toString(),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     color: functions
// //                                                                         .leaveStatusTextColor(
// //                                                                             getJsonField(
// //                                                                       overtimeApprovedItem,
// //                                                                       r'''$.status''',
// //                                                                     ).toString()),
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                   ],
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         );
// //                                       },
// //                                     );
// //                                   },
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           Column(
// //                             mainAxisSize: MainAxisSize.max,
// //                             children: [
// //                               Padding(
// //                                 padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 0.0, 10.0),
// //                                 child: Row(
// //                                   mainAxisSize: MainAxisSize.max,
// //                                   children: [
// //                                     Container(
// //                                       width: 190.0,
// //                                       height: 40.0,
// //                                       decoration: BoxDecoration(
// //                                         color: Theme.of(context).colorScheme.surface,
// //                                         borderRadius: BorderRadius.circular(4.0),
// //                                         border: Border.all(
// //                                           color: Theme.of(context).colorScheme.surface,
// //                                           width: 1.0,
// //                                         ),
// //                                       ),
// //                                       child: InkWell(
// //                                         splashColor: Colors.transparent,
// //                                         focusColor: Colors.transparent,
// //                                         hoverColor: Colors.transparent,
// //                                         highlightColor: Colors.transparent,
// //                                         onTap: () async {
// //                                           _model.yeardata = dateTimeFormat(
// //                                             "yyyy",
// //                                             getCurrentTimestamp,
// //                                             locale: FFLocalizations.of(context).languageCode,
// //                                           );
// //                                           _model.monthData = dateTimeFormat(
// //                                             "MM",
// //                                             getCurrentTimestamp,
// //                                             locale: FFLocalizations.of(context).languageCode,
// //                                           );
// //                                           safeSetState(() {});
// //                                           _model.apiResulOTPending =
// //                                               await MainGroup.getOTRequestByStatusMobileCall.call(
// //                                             monthNum: dateTimeFormat(
// //                                               "MM",
// //                                               getCurrentTimestamp,
// //                                               locale: FFLocalizations.of(context).languageCode,
// //                                             ),
// //                                             yearNum: dateTimeFormat(
// //                                               "yyyy",
// //                                               getCurrentTimestamp,
// //                                               locale: FFLocalizations.of(context).languageCode,
// //                                             ),
// //                                             status: 2,
// //                                             employeeID: AppState().employeeID,
// //                                             companyID: AppState().companyID,
// //                                             token: AppState().token,
// //                                           );

// //                                           if ((_model.apiResulOTPending?.succeeded ?? true)) {
// //                                             _model.overtimePendingTab = getJsonField(
// //                                               (_model.apiResulOTPending?.jsonBody ?? ''),
// //                                               r'''$.data''',
// //                                             )!
// //                                                 .toList()
// //                                                 .cast<dynamic>();
// //                                             safeSetState(() {});
// //                                           }

// //                                           safeSetState(() {});
// //                                         },
// //                                         child: Row(
// //                                           mainAxisSize: MainAxisSize.max,
// //                                           children: [
// //                                             Padding(
// //                                               padding: EdgeInsetsDirectional.fromSTEB(
// //                                                   5.0, 0.0, 0.0, 0.0),
// //                                               child: Text(
// //                                                 'Month: ${dateTimeFormat(
// //                                                   "MMM",
// //                                                   getCurrentTimestamp,
// //                                                   locale: FFLocalizations.of(context).languageCode,
// //                                                 )} Year: ${dateTimeFormat(
// //                                                   "yyyy",
// //                                                   getCurrentTimestamp,
// //                                                   locale: FFLocalizations.of(context).languageCode,
// //                                                 )}',
// //                                                 style: Theme.of(context)
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .copyWith(
// //                                                       fontFamily: GoogleFonts.readexPro(
// //                                                         fontWeight: Theme.of(context)
// //                                                             .fontFamily
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ).fontFamily,
// //                                                       color: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium
// //                                                           ?.color,
// //                                                       letterSpacing: 0.0,
// //                                                       fontWeight: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontWeight,
// //                                                       fontStyle: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontStyle,
// //                                                     ),
// //                                               ),
// //                                             ),
// //                                             Padding(
// //                                               padding: EdgeInsetsDirectional.fromSTEB(
// //                                                   3.0, 0.0, 0.0, 0.0),
// //                                               child: Icon(
// //                                                 Icons.calendar_month,
// //                                                 color:
// //                                                     Theme.of(context).textTheme.bodyMedium?.color,
// //                                                 size: 22.0,
// //                                               ),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                               Expanded(
// //                                 child: Builder(
// //                                   builder: (context) {
// //                                     final overtimePending = _model.overtimePendingTab.toList();

// //                                     return ListView.builder(
// //                                       padding: EdgeInsets.zero,
// //                                       shrinkWrap: true,
// //                                       scrollDirection: Axis.vertical,
// //                                       itemCount: overtimePending.length,
// //                                       itemBuilder: (context, overtimePendingIndex) {
// //                                         final overtimePendingItem =
// //                                             overtimePending[overtimePendingIndex];
// //                                         return Align(
// //                                           alignment: AlignmentDirectional(-1.0, -1.0),
// //                                           child: Padding(
// //                                             padding:
// //                                                 EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 5.0),
// //                                             child: Container(
// //                                               width: double.infinity,
// //                                               height: 220.0,
// //                                               decoration: BoxDecoration(
// //                                                 color: Theme.of(context).colorScheme.surface,
// //                                                 borderRadius: BorderRadius.only(
// //                                                   bottomLeft: Radius.circular(13.0),
// //                                                   bottomRight: Radius.circular(13.0),
// //                                                   topLeft: Radius.circular(13.0),
// //                                                   topRight: Radius.circular(13.0),
// //                                                 ),
// //                                               ),
// //                                               child: SingleChildScrollView(
// //                                                 child: Column(
// //                                                   mainAxisSize: MainAxisSize.max,
// //                                                   children: [
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       mainAxisAlignment:
// //                                                           MainAxisAlignment.spaceBetween,
// //                                                       children: [
// //                                                         Column(
// //                                                           mainAxisSize: MainAxisSize.max,
// //                                                           children: [
// //                                                             Padding(
// //                                                               padding:
// //                                                                   EdgeInsetsDirectional.fromSTEB(
// //                                                                       10.0, 8.0, 15.0, 0.0),
// //                                                               child: Text(
// //                                                                 valueOrDefault<String>(
// //                                                                   getJsonField(
// //                                                                     overtimePendingItem,
// //                                                                     r'''$.workFlow_Name''',
// //                                                                   )?.toString(),
// //                                                                   'OT',
// //                                                                 ),
// //                                                                 style: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .copyWith(
// //                                                                       fontFamily:
// //                                                                           GoogleFonts.readexPro(
// //                                                                         fontWeight:
// //                                                                             Theme.of(context)
// //                                                                                 .textTheme
// //                                                                                 .bodyMedium!
// //                                                                                 .fontWeight,
// //                                                                         fontStyle: Theme.of(context)
// //                                                                             .textTheme
// //                                                                             .bodyMedium!
// //                                                                             .fontStyle,
// //                                                                       ),
// //                                                                       color: Color(0xFFF89D27),
// //                                                                       letterSpacing: 0.0,
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                               ),
// //                                                             ),
// //                                                           ],
// //                                                         ),
// //                                                         Column(
// //                                                           mainAxisSize: MainAxisSize.max,
// //                                                           children: [
// //                                                             Align(
// //                                                               alignment:
// //                                                                   AlignmentDirectional(0.0, 0.0),
// //                                                               child: Padding(
// //                                                                 padding:
// //                                                                     EdgeInsetsDirectional.fromSTEB(
// //                                                                         0.0, 15.0, 20.0, 0.0),
// //                                                                 child: AppButton(
// //                                                                   onPressed: () {
// //                                                                     print('Button pressed ...');
// //                                                                   },
// //                                                                   text: FFLocalizations.of(context)
// //                                                                       .getText(
// //                                                                     '5pdvx498' /* Pending */,
// //                                                                   ),
// //                                                                   options: FFButtonOptions(
// //                                                                     height: 30.0,
// //                                                                     padding: EdgeInsetsDirectional
// //                                                                         .fromSTEB(
// //                                                                             24.0, 0.0, 24.0, 0.0),
// //                                                                     iconPadding:
// //                                                                         EdgeInsetsDirectional
// //                                                                             .fromSTEB(
// //                                                                                 0.0, 0.0, 0.0, 0.0),
// //                                                                     color: Color(0xFFDAE3F3),
// //                                                                     textStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .titleSmall!
// //                                                                         .copyWith(
// //                                                                           fontFamily:
// //                                                                               GoogleFonts.readexPro(
// //                                                                             fontWeight: Theme.of(
// //                                                                                         context)
// //                                                                                     .textTheme
// //                                                                                     .titleSmall
// //                                                                                     ?.fontWeight ??
// //                                                                                 FontWeight.normal,
// //                                                                             fontStyle: Theme.of(
// //                                                                                         context)
// //                                                                                     .textTheme
// //                                                                                     .titleSmall
// //                                                                                     ?.fontStyle ??
// //                                                                                 FontStyle.normal,
// //                                                                           ).fontFamily,
// //                                                                           color: Color(0xFF21A8D6),
// //                                                                           letterSpacing: 0.0,
// //                                                                           fontWeight:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .titleSmall!
// //                                                                                   .fontWeight,
// //                                                                           fontStyle:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .titleSmall!
// //                                                                                   .fontStyle,
// //                                                                         ),
// //                                                                     elevation: 3.0,
// //                                                                     borderSide: BorderSide(
// //                                                                       color: Colors.transparent,
// //                                                                       width: 1.0,
// //                                                                     ),
// //                                                                     borderRadius:
// //                                                                         BorderRadius.circular(24.0),
// //                                                                   ),
// //                                                                 ),
// //                                                               ),
// //                                                             ),
// //                                                           ],
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               10.0, 0.0, 0.0, 8.0),
// //                                                           child: Text(
// //                                                             FFLocalizations.of(context).getText(
// //                                                               'e3rw36wf' /* Amount */,
// //                                                             ),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   color: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium
// //                                                                       ?.color,
// //                                                                   fontSize: 12.0,
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 0.0, 0.0, 8.0),
// //                                                             child: Text(
// //                                                               valueOrDefault<String>(
// //                                                                 functions.leaveDayAmountFunction(
// //                                                                     getJsonField(
// //                                                                       overtimePendingItem,
// //                                                                       r'''$.start_Date''',
// //                                                                     ).toString(),
// //                                                                     getJsonField(
// //                                                                       overtimePendingItem,
// //                                                                       r'''$.end_Date''',
// //                                                                     ).toString(),
// //                                                                     getJsonField(
// //                                                                       overtimePendingItem,
// //                                                                       r'''$.oT_Start_Time''',
// //                                                                     ).toString(),
// //                                                                     getJsonField(
// //                                                                       overtimePendingItem,
// //                                                                       r'''$.oT_End_Time''',
// //                                                                     ).toString()),
// //                                                                 'OverTimeDayAmount',
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     color: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium
// //                                                                         ?.color,
// //                                                                     fontSize: 10.0,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 0.0, 0.0, 8.0),
// //                                                             child: Text(
// //                                                               FFLocalizations.of(context).getText(
// //                                                                 '9e6etozh' /* From  */,
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     color: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium
// //                                                                         ?.color,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(0.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 0.0, 0.0, 5.0, 8.0),
// //                                                             child: Text(
// //                                                               valueOrDefault<String>(
// //                                                                 functions
// //                                                                     .changeDateFormat(getJsonField(
// //                                                                   overtimePendingItem,
// //                                                                   r'''$.start_Date''',
// //                                                                 ).toString()),
// //                                                                 'start date',
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(0.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 0.0, 0.0, 0.0, 8.0),
// //                                                             child: Text(
// //                                                               getJsonField(
// //                                                                 overtimePendingItem,
// //                                                                 r'''$.oT_Start_Time''',
// //                                                               ).toString(),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               0.0, 0.0, 0.0, 8.0),
// //                                                           child: Text(
// //                                                             FFLocalizations.of(context).getText(
// //                                                               'u44hfory' /*  - */,
// //                                                             ),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               5.0, 0.0, 0.0, 8.0),
// //                                                           child: Text(
// //                                                             getJsonField(
// //                                                               overtimePendingItem,
// //                                                               r'''$.oT_End_Time''',
// //                                                             ).toString(),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 0.0, 0.0, 0.0),
// //                                                             child: Text(
// //                                                               FFLocalizations.of(context).getText(
// //                                                                 '9tufhddr' /* Note :  */,
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     fontSize: 10.0,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Text(
// //                                                           getJsonField(
// //                                                             overtimePendingItem,
// //                                                             r'''$.purpose_OT''',
// //                                                           ).toString(),
// //                                                           style: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .copyWith(
// //                                                                 fontFamily: GoogleFonts.readexPro(
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                                 letterSpacing: 0.0,
// //                                                                 fontWeight: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .fontWeight,
// //                                                                 fontStyle: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .fontStyle,
// //                                                               ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Builder(
// //                                                       builder: (context) => InkWell(
// //                                                         splashColor: Colors.transparent,
// //                                                         focusColor: Colors.transparent,
// //                                                         hoverColor: Colors.transparent,
// //                                                         highlightColor: Colors.transparent,
// //                                                         onTap: () async {
// //                                                           if ((getJsonField(
// //                                                             overtimePendingItem,
// //                                                             r'''$.attachmentlist''',
// //                                                           )
// //                                                                       .toList()
// //                                                                       .map<AttachmentFileModelStruct?>(
// //                                                                           AttachmentFileModelStruct
// //                                                                               .maybeFromMap)
// //                                                                       .toList()
// //                                                                   as Iterable<
// //                                                                       AttachmentFileModelStruct?>)
// //                                                               .withoutNulls
// //                                                               .isNotEmpty) {
// //                                                             await showDialog(
// //                                                               context: context,
// //                                                               builder: (dialogContext) {
// //                                                                 return Dialog(
// //                                                                   elevation: 0,
// //                                                                   insetPadding: EdgeInsets.zero,
// //                                                                   backgroundColor:
// //                                                                       Colors.transparent,
// //                                                                   alignment:
// //                                                                       AlignmentDirectional(0.0, 0.0)
// //                                                                           .resolve(
// //                                                                               Directionality.of(
// //                                                                                   context)),
// //                                                                   child: WebViewAware(
// //                                                                     child: GestureDetector(
// //                                                                       onTap: () {
// //                                                                         FocusScope.of(dialogContext)
// //                                                                             .unfocus();
// //                                                                         FocusManager
// //                                                                             .instance.primaryFocus
// //                                                                             ?.unfocus();
// //                                                                       },
// //                                                                       child:
// //                                                                           OvertimeAttachmentModelWidget(
// //                                                                         attachmentList:
// //                                                                             getJsonField(
// //                                                                           overtimePendingItem,
// //                                                                           r'''$.attachmentlist''',
// //                                                                         )!,
// //                                                                       ),
// //                                                                     ),
// //                                                                   ),
// //                                                                 );
// //                                                               },
// //                                                             );
// //                                                           }
// //                                                         },
// //                                                         child: Row(
// //                                                           mainAxisSize: MainAxisSize.max,
// //                                                           children: [
// //                                                             Padding(
// //                                                               padding:
// //                                                                   EdgeInsetsDirectional.fromSTEB(
// //                                                                       10.0, 10.0, 0.0, 0.0),
// //                                                               child: Text(
// //                                                                 valueOrDefault<String>(
// //                                                                   functions
// //                                                                       .attachmentCountFunction(
// //                                                                           (getJsonField(
// //                                                                         overtimePendingItem,
// //                                                                         r'''$.attachmentlist''',
// //                                                                       ) as List)
// //                                                                               .map<String>((s) =>
// //                                                                                   s.toString())
// //                                                                               .toList())
// //                                                                       .toString(),
// //                                                                   '0',
// //                                                                 ),
// //                                                                 style: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .copyWith(
// //                                                                       fontFamily:
// //                                                                           GoogleFonts.readexPro(
// //                                                                         fontWeight:
// //                                                                             Theme.of(context)
// //                                                                                 .textTheme
// //                                                                                 .bodyMedium!
// //                                                                                 .fontWeight,
// //                                                                         fontStyle: Theme.of(context)
// //                                                                             .textTheme
// //                                                                             .bodyMedium!
// //                                                                             .fontStyle,
// //                                                                       ),
// //                                                                       color: Theme.of(context)
// //                                                                           .colorScheme
// //                                                                           .primary,
// //                                                                       fontSize: 10.0,
// //                                                                       letterSpacing: 0.0,
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                               ),
// //                                                             ),
// //                                                             Align(
// //                                                               alignment:
// //                                                                   AlignmentDirectional(-1.0, 0.0),
// //                                                               child: Padding(
// //                                                                 padding:
// //                                                                     EdgeInsetsDirectional.fromSTEB(
// //                                                                         5.0, 10.0, 0.0, 0.0),
// //                                                                 child: Text(
// //                                                                   FFLocalizations.of(context)
// //                                                                       .getText(
// //                                                                     'sfu04278' /* attachement */,
// //                                                                   ),
// //                                                                   style: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .copyWith(
// //                                                                         fontFamily:
// //                                                                             GoogleFonts.readexPro(
// //                                                                           fontWeight:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .bodyMedium!
// //                                                                                   .fontWeight,
// //                                                                           fontStyle:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .bodyMedium!
// //                                                                                   .fontStyle,
// //                                                                         ),
// //                                                                         color: Color(0xFFF89D27),
// //                                                                         fontSize: 10.0,
// //                                                                         letterSpacing: 0.0,
// //                                                                         fontWeight:
// //                                                                             Theme.of(context)
// //                                                                                 .textTheme
// //                                                                                 .bodyMedium!
// //                                                                                 .fontWeight,
// //                                                                         fontStyle: Theme.of(context)
// //                                                                             .textTheme
// //                                                                             .bodyMedium!
// //                                                                             .fontStyle,
// //                                                                       ),
// //                                                                 ),
// //                                                               ),
// //                                                             ),
// //                                                           ],
// //                                                         ),
// //                                                       ),
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 8.0, 0.0, 0.0),
// //                                                             child: Text(
// //                                                               FFLocalizations.of(context).getText(
// //                                                                 'pgc99vje' /* Request date :  */,
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     color:
// //                                                                         AppColors.overtimetextcolor,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               0.0, 8.0, 0.0, 0.0),
// //                                                           child: Text(
// //                                                             valueOrDefault<String>(
// //                                                               functions.changeRequestedDateFormat(
// //                                                                   getJsonField(
// //                                                                 overtimePendingItem,
// //                                                                 r'''$.oT_Requested_Date''',
// //                                                               ).toString()),
// //                                                               'request Date',
// //                                                             ),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   color:
// //                                                                       AppColors.overtimetextcolor,
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Divider(
// //                                                       color: Theme.of(context).colorScheme.surface,
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       mainAxisAlignment: MainAxisAlignment.end,
// //                                                       children: [
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               0.0, 0.0, 15.0, 0.0),
// //                                                           child: InkWell(
// //                                                             splashColor: Colors.transparent,
// //                                                             focusColor: Colors.transparent,
// //                                                             hoverColor: Colors.transparent,
// //                                                             highlightColor: Colors.transparent,
// //                                                             onTap: () async {
// //                                                               Navigator.of(context).pushNamed(
// //                                                                 '/editOvertimeRequest',
// //                                                               );
// //                                                             },
// //                                                             child: ClipRRect(
// //                                                               borderRadius:
// //                                                                   BorderRadius.circular(8.0),
// //                                                               child: Image.asset(
// //                                                                 'assets/images/edit-rectangle-svgrepo-com_1_(1).png',
// //                                                                 width: 28.0,
// //                                                                 height: 30.0,
// //                                                                 fit: BoxFit.cover,
// //                                                               ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Builder(
// //                                                           builder: (context) => InkWell(
// //                                                             splashColor: Colors.transparent,
// //                                                             focusColor: Colors.transparent,
// //                                                             hoverColor: Colors.transparent,
// //                                                             highlightColor: Colors.transparent,
// //                                                             onTap: () async {
// //                                                               await showDialog(
// //                                                                 context: context,
// //                                                                 builder: (dialogContext) {
// //                                                                   return Dialog(
// //                                                                     elevation: 0,
// //                                                                     insetPadding: EdgeInsets.zero,
// //                                                                     backgroundColor:
// //                                                                         Colors.transparent,
// //                                                                     alignment: AlignmentDirectional(
// //                                                                             0.0, 0.0)
// //                                                                         .resolve(Directionality.of(
// //                                                                             context)),
// //                                                                     child: WebViewAware(
// //                                                                       child: GestureDetector(
// //                                                                         onTap: () {
// //                                                                           FocusScope.of(
// //                                                                                   dialogContext)
// //                                                                               .unfocus();
// //                                                                           FocusManager
// //                                                                               .instance.primaryFocus
// //                                                                               ?.unfocus();
// //                                                                         },
// //                                                                         child:
// //                                                                             DeleteOTRequestDialogWidget(
// //                                                                           oTID: getJsonField(
// //                                                                             overtimePendingItem,
// //                                                                             r'''$.oT_Request_ID''',
// //                                                                           ).toString(),
// //                                                                         ),
// //                                                                       ),
// //                                                                     ),
// //                                                                   );
// //                                                                 },
// //                                                               );
// //                                                             },
// //                                                             child: ClipRRect(
// //                                                               borderRadius:
// //                                                                   BorderRadius.circular(8.0),
// //                                                               child: Image.asset(
// //                                                                 'assets/images/delete-trash-remove-svgrepo-com_1.png',
// //                                                                 width: 28.0,
// //                                                                 height: 30.0,
// //                                                                 fit: BoxFit.cover,
// //                                                               ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                   ],
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         );
// //                                       },
// //                                     );
// //                                   },
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           Column(
// //                             mainAxisSize: MainAxisSize.max,
// //                             children: [
// //                               Padding(
// //                                 padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 0.0, 10.0),
// //                                 child: Row(
// //                                   mainAxisSize: MainAxisSize.max,
// //                                   children: [
// //                                     Container(
// //                                       width: 190.0,
// //                                       height: 40.0,
// //                                       decoration: BoxDecoration(
// //                                         color: Theme.of(context).colorScheme.surface,
// //                                         borderRadius: BorderRadius.circular(4.0),
// //                                         border: Border.all(
// //                                           color: Theme.of(context).colorScheme.surface,
// //                                           width: 1.0,
// //                                         ),
// //                                       ),
// //                                       child: InkWell(
// //                                         splashColor: Colors.transparent,
// //                                         focusColor: Colors.transparent,
// //                                         hoverColor: Colors.transparent,
// //                                         highlightColor: Colors.transparent,
// //                                         onTap: () async {
// //                                           _model.yeardata = dateTimeFormat(
// //                                             "yyyy",
// //                                             getCurrentTimestamp,
// //                                             locale: FFLocalizations.of(context).languageCode,
// //                                           );
// //                                           _model.monthData = dateTimeFormat(
// //                                             "MM",
// //                                             getCurrentTimestamp,
// //                                             locale: FFLocalizations.of(context).languageCode,
// //                                           );
// //                                           safeSetState(() {});
// //                                           _model.apiHistoryYearResult =
// //                                               await MainGroup.getOTRequestByStatusMobileCall.call(
// //                                             monthNum: dateTimeFormat(
// //                                               "MM",
// //                                               getCurrentTimestamp,
// //                                               locale: FFLocalizations.of(context).languageCode,
// //                                             ),
// //                                             yearNum: dateTimeFormat(
// //                                               "yyyy",
// //                                               getCurrentTimestamp,
// //                                               locale: FFLocalizations.of(context).languageCode,
// //                                             ),
// //                                             status: 3,
// //                                             employeeID: AppState().employeeID,
// //                                             companyID: AppState().companyID,
// //                                             token: AppState().token,
// //                                           );

// //                                           if ((_model.apiHistoryYearResult?.succeeded ?? true)) {
// //                                             _model.overTimeHistory = getJsonField(
// //                                               (_model.apiHistoryYearResult?.jsonBody ?? ''),
// //                                               r'''$.data''',
// //                                             )!
// //                                                 .toList()
// //                                                 .cast<dynamic>();
// //                                             safeSetState(() {});
// //                                           }

// //                                           safeSetState(() {});
// //                                         },
// //                                         child: Row(
// //                                           mainAxisSize: MainAxisSize.max,
// //                                           children: [
// //                                             Padding(
// //                                               padding: EdgeInsetsDirectional.fromSTEB(
// //                                                   5.0, 0.0, 0.0, 0.0),
// //                                               child: Text(
// //                                                 FFLocalizations.of(context).getText(
// //                                                   'cxo95bpf' /* Month: */,
// //                                                 ),
// //                                                 style: Theme.of(context)
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .copyWith(
// //                                                       fontFamily: GoogleFonts.readexPro(
// //                                                         fontWeight: Theme.of(context)
// //                                                             .fontFamily
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ).fontFamily,
// //                                                       color: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium
// //                                                           ?.color,
// //                                                       letterSpacing: 0.0,
// //                                                       fontWeight: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontWeight,
// //                                                       fontStyle: Theme.of(context)
// //                                                           .textTheme
// //                                                           .bodyMedium!
// //                                                           .fontStyle,
// //                                                     ),
// //                                               ),
// //                                             ),
// //                                             Text(
// //                                               dateTimeFormat(
// //                                                 "MMM",
// //                                                 getCurrentTimestamp,
// //                                                 locale: FFLocalizations.of(context).languageCode,
// //                                               ),
// //                                               style:
// //                                                   Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                                                         fontFamily: GoogleFonts.readexPro(
// //                                                           fontWeight: Theme.of(context)
// //                                                               .fontFamily
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontWeight,
// //                                                           fontStyle: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontStyle,
// //                                                         ).fontFamily,
// //                                                         color: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium
// //                                                             ?.color,
// //                                                         letterSpacing: 0.0,
// //                                                         fontWeight: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ),
// //                                             ),
// //                                             Text(
// //                                               FFLocalizations.of(context).getText(
// //                                                 'i3sff4zj' /*  Year: */,
// //                                               ),
// //                                               style:
// //                                                   Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                                                         fontFamily: GoogleFonts.readexPro(
// //                                                           fontWeight: Theme.of(context)
// //                                                               .fontFamily
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontWeight,
// //                                                           fontStyle: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontStyle,
// //                                                         ).fontFamily,
// //                                                         color: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium
// //                                                             ?.color,
// //                                                         letterSpacing: 0.0,
// //                                                         fontWeight: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ),
// //                                             ),
// //                                             Text(
// //                                               dateTimeFormat(
// //                                                 "yyyy",
// //                                                 getCurrentTimestamp,
// //                                                 locale: FFLocalizations.of(context).languageCode,
// //                                               ),
// //                                               style:
// //                                                   Theme.of(context).textTheme.bodyMedium!.copyWith(
// //                                                         fontFamily: GoogleFonts.readexPro(
// //                                                           fontWeight: Theme.of(context)
// //                                                               .fontFamily
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontWeight,
// //                                                           fontStyle: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .fontStyle,
// //                                                         ).fontFamily,
// //                                                         color: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium
// //                                                             ?.color,
// //                                                         letterSpacing: 0.0,
// //                                                         fontWeight: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontWeight,
// //                                                         fontStyle: Theme.of(context)
// //                                                             .textTheme
// //                                                             .bodyMedium!
// //                                                             .fontStyle,
// //                                                       ),
// //                                             ),
// //                                             Padding(
// //                                               padding: EdgeInsetsDirectional.fromSTEB(
// //                                                   3.0, 0.0, 0.0, 0.0),
// //                                               child: Icon(
// //                                                 Icons.calendar_month,
// //                                                 color:
// //                                                     Theme.of(context).textTheme.bodyMedium?.color,
// //                                                 size: 22.0,
// //                                               ),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     Align(
// //                                       alignment: AlignmentDirectional(-1.0, -1.0),
// //                                       child: Padding(
// //                                         padding:
// //                                             EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
// //                                         child: FlutterFlowDropDown<String>(
// //                                           options: [
// //                                             FFLocalizations.of(context).getText(
// //                                               '6p3cd236' /* All */,
// //                                             ),
// //                                             FFLocalizations.of(context).getText(
// //                                               'qfk5wh1i' /* Approved */,
// //                                             ),
// //                                             FFLocalizations.of(context).getText(
// //                                               'thxo3abx' /* Rejected */,
// //                                             ),
// //                                             FFLocalizations.of(context).getText(
// //                                               'xfdpqd4d' /* Canceled */,
// //                                             )
// //                                           ],
// //                                           onChanged: (val) async {
// //                                             safeSetState(() => _model.overtimeStatusValue = val);
// //                                             _model.overTimeHistory = functions
// //                                                 .filteredOvertimeStatusFunction(
// //                                                     _model.overTimeHistory.toList(),
// //                                                     _model.overtimeStatusValue)
// //                                                 .toList()
// //                                                 .cast<dynamic>();
// //                                             safeSetState(() {});
// //                                           },
// //                                           width: 180.0,
// //                                           height: 40.0,
// //                                           textStyle: Theme.of(context)
// //                                               .textTheme
// //                                               .bodyMedium!
// //                                               .copyWith(
// //                                                 fontFamily: GoogleFonts.readexPro(
// //                                                   fontWeight: Theme.of(context)
// //                                                       .fontFamily
// //                                                       .textTheme
// //                                                       .bodyMedium!
// //                                                       .fontWeight,
// //                                                   fontStyle: Theme.of(context)
// //                                                       .textTheme
// //                                                       .bodyMedium!
// //                                                       .fontStyle,
// //                                                 ).fontFamily,
// //                                                 color:
// //                                                     Theme.of(context).textTheme.bodyMedium?.color,
// //                                                 letterSpacing: 0.0,
// //                                                 fontWeight: Theme.of(context)
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .fontWeight,
// //                                                 fontStyle: Theme.of(context)
// //                                                     .textTheme
// //                                                     .bodyMedium!
// //                                                     .fontStyle,
// //                                               ),
// //                                           hintText: FFLocalizations.of(context).getText(
// //                                             'ibjt2lcn' /* All */,
// //                                           ),
// //                                           icon: Icon(
// //                                             Icons.keyboard_arrow_down_rounded,
// //                                             color: Theme.of(context).textTheme.bodyMedium?.color,
// //                                             size: 24.0,
// //                                           ),
// //                                           fillColor: Theme.of(context).colorScheme.surface,
// //                                           elevation: 0.0,
// //                                           borderColor: Theme.of(context).colorScheme.surface,
// //                                           borderWidth: 1.0,
// //                                           borderRadius: 4.0,
// //                                           margin:
// //                                               EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
// //                                           hidesUnderline: true,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                               Expanded(
// //                                 child: Builder(
// //                                   builder: (context) {
// //                                     final overtimeHistoryList = _model.overTimeHistory.toList();

// //                                     return ListView.builder(
// //                                       padding: EdgeInsets.zero,
// //                                       shrinkWrap: true,
// //                                       scrollDirection: Axis.vertical,
// //                                       itemCount: overtimeHistoryList.length,
// //                                       itemBuilder: (context, overtimeHistoryListIndex) {
// //                                         final overtimeHistoryListItem =
// //                                             overtimeHistoryList[overtimeHistoryListIndex];
// //                                         return Align(
// //                                           alignment: AlignmentDirectional(-1.0, -1.0),
// //                                           child: Padding(
// //                                             padding:
// //                                                 EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 5.0),
// //                                             child: Container(
// //                                               width: double.infinity,
// //                                               height: 220.0,
// //                                               decoration: BoxDecoration(
// //                                                 color: Theme.of(context).colorScheme.surface,
// //                                                 borderRadius: BorderRadius.only(
// //                                                   bottomLeft: Radius.circular(13.0),
// //                                                   bottomRight: Radius.circular(13.0),
// //                                                   topLeft: Radius.circular(13.0),
// //                                                   topRight: Radius.circular(13.0),
// //                                                 ),
// //                                               ),
// //                                               child: SingleChildScrollView(
// //                                                 child: Column(
// //                                                   mainAxisSize: MainAxisSize.max,
// //                                                   children: [
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       mainAxisAlignment:
// //                                                           MainAxisAlignment.spaceBetween,
// //                                                       children: [
// //                                                         Column(
// //                                                           mainAxisSize: MainAxisSize.max,
// //                                                           children: [
// //                                                             Padding(
// //                                                               padding:
// //                                                                   EdgeInsetsDirectional.fromSTEB(
// //                                                                       10.0, 8.0, 15.0, 0.0),
// //                                                               child: Text(
// //                                                                 valueOrDefault<String>(
// //                                                                   getJsonField(
// //                                                                     overtimeHistoryListItem,
// //                                                                     r'''$.workFlow_Name''',
// //                                                                   )?.toString(),
// //                                                                   'OT',
// //                                                                 ),
// //                                                                 style: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .copyWith(
// //                                                                       fontFamily:
// //                                                                           GoogleFonts.readexPro(
// //                                                                         fontWeight:
// //                                                                             Theme.of(context)
// //                                                                                 .textTheme
// //                                                                                 .bodyMedium!
// //                                                                                 .fontWeight,
// //                                                                         fontStyle: Theme.of(context)
// //                                                                             .textTheme
// //                                                                             .bodyMedium!
// //                                                                             .fontStyle,
// //                                                                       ),
// //                                                                       color: Color(0xFFF89D27),
// //                                                                       letterSpacing: 0.0,
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                               ),
// //                                                             ),
// //                                                           ],
// //                                                         ),
// //                                                         Column(
// //                                                           mainAxisSize: MainAxisSize.max,
// //                                                           children: [
// //                                                             Align(
// //                                                               alignment:
// //                                                                   AlignmentDirectional(0.0, 0.0),
// //                                                               child: Padding(
// //                                                                 padding:
// //                                                                     EdgeInsetsDirectional.fromSTEB(
// //                                                                         0.0, 15.0, 20.0, 0.0),
// //                                                                 child: AppButton(
// //                                                                   onPressed: () {
// //                                                                     print('Button pressed ...');
// //                                                                   },
// //                                                                   text: valueOrDefault<String>(
// //                                                                     functions
// //                                                                         .changeLeaveStatusRejectedFunction(
// //                                                                             getJsonField(
// //                                                                       overtimeHistoryListItem,
// //                                                                       r'''$.status''',
// //                                                                     ).toString()),
// //                                                                     'status',
// //                                                                   ),
// //                                                                   options: FFButtonOptions(
// //                                                                     height: 30.0,
// //                                                                     padding: EdgeInsetsDirectional
// //                                                                         .fromSTEB(
// //                                                                             24.0, 0.0, 24.0, 0.0),
// //                                                                     iconPadding:
// //                                                                         EdgeInsetsDirectional
// //                                                                             .fromSTEB(
// //                                                                                 0.0, 0.0, 0.0, 0.0),
// //                                                                     color: functions
// //                                                                         .overtimeStatusBackgroundColor(
// //                                                                             getJsonField(
// //                                                                       overtimeHistoryListItem,
// //                                                                       r'''$.status''',
// //                                                                     ).toString()),
// //                                                                     textStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .titleSmall!
// //                                                                         .copyWith(
// //                                                                           fontFamily:
// //                                                                               GoogleFonts.readexPro(
// //                                                                             fontWeight: Theme.of(
// //                                                                                         context)
// //                                                                                     .textTheme
// //                                                                                     .titleSmall
// //                                                                                     ?.fontWeight ??
// //                                                                                 FontWeight.normal,
// //                                                                             fontStyle: Theme.of(
// //                                                                                         context)
// //                                                                                     .textTheme
// //                                                                                     .titleSmall
// //                                                                                     ?.fontStyle ??
// //                                                                                 FontStyle.normal,
// //                                                                           ).fontFamily,
// //                                                                           color: functions
// //                                                                               .overtimeStatusTextColor(
// //                                                                                   getJsonField(
// //                                                                             overtimeHistoryListItem,
// //                                                                             r'''$.status''',
// //                                                                           ).toString()),
// //                                                                           letterSpacing: 0.0,
// //                                                                           fontWeight:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .titleSmall!
// //                                                                                   .fontWeight,
// //                                                                           fontStyle:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .titleSmall!
// //                                                                                   .fontStyle,
// //                                                                         ),
// //                                                                     elevation: 3.0,
// //                                                                     borderSide: BorderSide(
// //                                                                       color: Colors.transparent,
// //                                                                       width: 1.0,
// //                                                                     ),
// //                                                                     borderRadius:
// //                                                                         BorderRadius.circular(24.0),
// //                                                                   ),
// //                                                                 ),
// //                                                               ),
// //                                                             ),
// //                                                           ],
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               10.0, 0.0, 0.0, 8.0),
// //                                                           child: Text(
// //                                                             FFLocalizations.of(context).getText(
// //                                                               'rv2l9gd3' /* Amount */,
// //                                                             ),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   color: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium
// //                                                                       ?.color,
// //                                                                   fontSize: 12.0,
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 0.0, 0.0, 8.0),
// //                                                             child: Text(
// //                                                               getJsonField(
// //                                                                 overtimeHistoryListItem,
// //                                                                 r'''$.oT_Hours''',
// //                                                               ).toString(),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     color: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium
// //                                                                         ?.color,
// //                                                                     fontSize: 10.0,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 0.0, 0.0, 8.0),
// //                                                             child: Text(
// //                                                               FFLocalizations.of(context).getText(
// //                                                                 'xtr9ohoo' /* From  */,
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     color: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium
// //                                                                         ?.color,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(0.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 0.0, 0.0, 0.0, 8.0),
// //                                                             child: Text(
// //                                                               valueOrDefault<String>(
// //                                                                 functions
// //                                                                     .changeDateFormat(getJsonField(
// //                                                                   overtimeHistoryListItem,
// //                                                                   r'''$.start_Date''',
// //                                                                 ).toString()),
// //                                                                 'Start Date',
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               0.0, 0.0, 0.0, 8.0),
// //                                                           child: Text(
// //                                                             FFLocalizations.of(context).getText(
// //                                                               'do21wmg3' /*  - */,
// //                                                             ),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               5.0, 0.0, 0.0, 8.0),
// //                                                           child: Text(
// //                                                             valueOrDefault<String>(
// //                                                               functions.changeDateFormat(
// //                                                                   valueOrDefault<String>(
// //                                                                 getJsonField(
// //                                                                   overtimeHistoryListItem,
// //                                                                   r'''$.end_Date''',
// //                                                                 )?.toString(),
// //                                                                 'End Date',
// //                                                               )),
// //                                                               'End Date',
// //                                                             ),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 0.0, 0.0, 0.0),
// //                                                             child: Text(
// //                                                               FFLocalizations.of(context).getText(
// //                                                                 '20lb826q' /* Note :  */,
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     fontSize: 10.0,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Text(
// //                                                           getJsonField(
// //                                                             overtimeHistoryListItem,
// //                                                             r'''$.purpose_OT''',
// //                                                           ).toString(),
// //                                                           style: Theme.of(context)
// //                                                               .textTheme
// //                                                               .bodyMedium!
// //                                                               .copyWith(
// //                                                                 fontFamily: GoogleFonts.readexPro(
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                                 letterSpacing: 0.0,
// //                                                                 fontWeight: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .fontWeight,
// //                                                                 fontStyle: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .fontStyle,
// //                                                               ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Builder(
// //                                                       builder: (context) => Padding(
// //                                                         padding: EdgeInsetsDirectional.fromSTEB(
// //                                                             0.0, 10.0, 0.0, 0.0),
// //                                                         child: InkWell(
// //                                                           splashColor: Colors.transparent,
// //                                                           focusColor: Colors.transparent,
// //                                                           hoverColor: Colors.transparent,
// //                                                           highlightColor: Colors.transparent,
// //                                                           onTap: () async {
// //                                                             if ((getJsonField(
// //                                                               overtimeHistoryListItem,
// //                                                               r'''$.attachmentlist''',
// //                                                             )
// //                                                                         .toList()
// //                                                                         .map<AttachmentFileModelStruct?>(
// //                                                                             AttachmentFileModelStruct
// //                                                                                 .maybeFromMap)
// //                                                                         .toList()
// //                                                                     as Iterable<
// //                                                                         AttachmentFileModelStruct?>)
// //                                                                 .withoutNulls
// //                                                                 .isNotEmpty) {
// //                                                               await showDialog(
// //                                                                 context: context,
// //                                                                 builder: (dialogContext) {
// //                                                                   return Dialog(
// //                                                                     elevation: 0,
// //                                                                     insetPadding: EdgeInsets.zero,
// //                                                                     backgroundColor:
// //                                                                         Colors.transparent,
// //                                                                     alignment: AlignmentDirectional(
// //                                                                             0.0, 0.0)
// //                                                                         .resolve(Directionality.of(
// //                                                                             context)),
// //                                                                     child: WebViewAware(
// //                                                                       child: GestureDetector(
// //                                                                         onTap: () {
// //                                                                           FocusScope.of(
// //                                                                                   dialogContext)
// //                                                                               .unfocus();
// //                                                                           FocusManager
// //                                                                               .instance.primaryFocus
// //                                                                               ?.unfocus();
// //                                                                         },
// //                                                                         child:
// //                                                                             OvertimeAttachmentModelWidget(
// //                                                                           attachmentList:
// //                                                                               getJsonField(
// //                                                                             overtimeHistoryListItem,
// //                                                                             r'''$.attachmentlist''',
// //                                                                           )!,
// //                                                                         ),
// //                                                                       ),
// //                                                                     ),
// //                                                                   );
// //                                                                 },
// //                                                               );
// //                                                             }
// //                                                           },
// //                                                           child: Row(
// //                                                             mainAxisSize: MainAxisSize.max,
// //                                                             children: [
// //                                                               Padding(
// //                                                                 padding:
// //                                                                     EdgeInsetsDirectional.fromSTEB(
// //                                                                         10.0, 0.0, 0.0, 0.0),
// //                                                                 child: Text(
// //                                                                   valueOrDefault<String>(
// //                                                                     functions
// //                                                                         .attachmentCountFunction(
// //                                                                             (getJsonField(
// //                                                                           overtimeHistoryListItem,
// //                                                                           r'''$.attachmentlist''',
// //                                                                         ) as List)
// //                                                                                 .map<String>((s) =>
// //                                                                                     s.toString())
// //                                                                                 .toList())
// //                                                                         .toString(),
// //                                                                     '0',
// //                                                                   ),
// //                                                                   style: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .copyWith(
// //                                                                         fontFamily:
// //                                                                             GoogleFonts.readexPro(
// //                                                                           fontWeight:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .bodyMedium!
// //                                                                                   .fontWeight,
// //                                                                           fontStyle:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .bodyMedium!
// //                                                                                   .fontStyle,
// //                                                                         ),
// //                                                                         color: Theme.of(context)
// //                                                                             .colorScheme
// //                                                                             .primary,
// //                                                                         fontSize: 10.0,
// //                                                                         letterSpacing: 0.0,
// //                                                                         fontWeight:
// //                                                                             Theme.of(context)
// //                                                                                 .textTheme
// //                                                                                 .bodyMedium!
// //                                                                                 .fontWeight,
// //                                                                         fontStyle: Theme.of(context)
// //                                                                             .textTheme
// //                                                                             .bodyMedium!
// //                                                                             .fontStyle,
// //                                                                       ),
// //                                                                 ),
// //                                                               ),
// //                                                               Align(
// //                                                                 alignment: AlignmentDirectional(
// //                                                                     -1.0, -1.0),
// //                                                                 child: Padding(
// //                                                                   padding: EdgeInsetsDirectional
// //                                                                       .fromSTEB(5.0, 0.0, 0.0, 0.0),
// //                                                                   child: Text(
// //                                                                     FFLocalizations.of(context)
// //                                                                         .getText(
// //                                                                       'e1xwsu52' /* attachement */,
// //                                                                     ),
// //                                                                     style: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .copyWith(
// //                                                                           fontFamily:
// //                                                                               GoogleFonts.readexPro(
// //                                                                             fontWeight: Theme.of(
// //                                                                                         context)
// //                                                                                     .textTheme
// //                                                                                     .bodyMedium
// //                                                                                     ?.fontWeight ??
// //                                                                                 FontWeight.normal,
// //                                                                             fontStyle: Theme.of(
// //                                                                                         context)
// //                                                                                     .textTheme
// //                                                                                     .bodyMedium
// //                                                                                     ?.fontStyle ??
// //                                                                                 FontStyle.normal,
// //                                                                           ).fontFamily,
// //                                                                           color: Color(0xFFF89D27),
// //                                                                           fontSize: 10.0,
// //                                                                           letterSpacing: 0.0,
// //                                                                           fontWeight:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .bodyMedium!
// //                                                                                   .fontWeight,
// //                                                                           fontStyle:
// //                                                                               Theme.of(context)
// //                                                                                   .textTheme
// //                                                                                   .bodyMedium!
// //                                                                                   .fontStyle,
// //                                                                         ),
// //                                                                   ),
// //                                                                 ),
// //                                                               ),
// //                                                             ],
// //                                                           ),
// //                                                         ),
// //                                                       ),
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       children: [
// //                                                         Align(
// //                                                           alignment:
// //                                                               AlignmentDirectional(-1.0, -1.0),
// //                                                           child: Padding(
// //                                                             padding: EdgeInsetsDirectional.fromSTEB(
// //                                                                 10.0, 8.0, 0.0, 0.0),
// //                                                             child: Text(
// //                                                               FFLocalizations.of(context).getText(
// //                                                                 '9deb77gz' /* Request date :  */,
// //                                                               ),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     color: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium
// //                                                                         ?.color,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                         Padding(
// //                                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                                               0.0, 8.0, 0.0, 0.0),
// //                                                           child: Text(
// //                                                             valueOrDefault<String>(
// //                                                               functions.changeRequestedDateFormat(
// //                                                                   getJsonField(
// //                                                                 overtimeHistoryListItem,
// //                                                                 r'''$.oT_Requested_Date''',
// //                                                               ).toString()),
// //                                                               'Request Date',
// //                                                             ),
// //                                                             style: Theme.of(context)
// //                                                                 .textTheme
// //                                                                 .bodyMedium!
// //                                                                 .copyWith(
// //                                                                   fontFamily: GoogleFonts.readexPro(
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                                   letterSpacing: 0.0,
// //                                                                   fontWeight: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontWeight,
// //                                                                   fontStyle: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .bodyMedium!
// //                                                                       .fontStyle,
// //                                                                 ),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                     Divider(
// //                                                       color: Theme.of(context).colorScheme.surface,
// //                                                     ),
// //                                                     Row(
// //                                                       mainAxisSize: MainAxisSize.max,
// //                                                       mainAxisAlignment:
// //                                                           MainAxisAlignment.spaceBetween,
// //                                                       children: [
// //                                                         Row(
// //                                                           mainAxisSize: MainAxisSize.max,
// //                                                           children: [
// //                                                             Padding(
// //                                                               padding:
// //                                                                   EdgeInsetsDirectional.fromSTEB(
// //                                                                       10.0, 0.0, 0.0, 0.0),
// //                                                               child: Text(
// //                                                                 FFLocalizations.of(context).getText(
// //                                                                   '45wfvnii' /* Approved by :  */,
// //                                                                 ),
// //                                                                 style: Theme.of(context)
// //                                                                     .textTheme
// //                                                                     .bodyMedium!
// //                                                                     .copyWith(
// //                                                                       fontFamily:
// //                                                                           GoogleFonts.readexPro(
// //                                                                         fontWeight:
// //                                                                             Theme.of(context)
// //                                                                                 .textTheme
// //                                                                                 .bodyMedium!
// //                                                                                 .fontWeight,
// //                                                                         fontStyle: Theme.of(context)
// //                                                                             .textTheme
// //                                                                             .bodyMedium!
// //                                                                             .fontStyle,
// //                                                                       ),
// //                                                                       fontSize: 12.0,
// //                                                                       letterSpacing: 0.0,
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                               ),
// //                                                             ),
// //                                                             Text(
// //                                                               getJsonField(
// //                                                                 overtimeHistoryListItem,
// //                                                                 r'''$.approver_Name''',
// //                                                               ).toString(),
// //                                                               style: Theme.of(context)
// //                                                                   .textTheme
// //                                                                   .bodyMedium!
// //                                                                   .copyWith(
// //                                                                     fontFamily:
// //                                                                         GoogleFonts.readexPro(
// //                                                                       fontWeight: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontWeight,
// //                                                                       fontStyle: Theme.of(context)
// //                                                                           .textTheme
// //                                                                           .bodyMedium!
// //                                                                           .fontStyle,
// //                                                                     ),
// //                                                                     fontSize: 12.0,
// //                                                                     letterSpacing: 0.0,
// //                                                                     fontWeight: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontWeight,
// //                                                                     fontStyle: Theme.of(context)
// //                                                                         .textTheme
// //                                                                         .bodyMedium!
// //                                                                         .fontStyle,
// //                                                                   ),
// //                                                             ),
// //                                                           ],
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                   ],
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         );
// //                                       },
// //                                     );
// //                                   },
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
