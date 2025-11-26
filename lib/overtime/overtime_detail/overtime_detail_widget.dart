import 'package:h_r_optimistic_mobile/core/theme/app_theme_extension.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import 'package:h_r_optimistic_mobile/core/widgets/app_icon_button.dart';
import 'package:h_r_optimistic_mobile/core/widgets/web_view_aware.dart';

import 'package:h_r_optimistic_mobile/core/utils/app_utils.dart';
import 'package:h_r_optimistic_mobile/core/widgets/app_button.dart';
// import 'package:h_r_optimistic_mobile/core/utils/upload_data.dart'; // Unused
import 'dart:ui';
import 'package:h_r_optimistic_mobile/core/utils/custom_functions.dart' as functions;
import '/index.dart';
import '/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'overtime_detail_model.dart';
import '/core/theme/app_colors.dart';
export 'overtime_detail_model.dart';

class OvertimeDetailWidget extends StatefulWidget {
  const OvertimeDetailWidget({
    super.key,
    required this.overtimedetails,
  });

  final CurrentOTListStruct? overtimedetails;

  static String routeName = 'OvertimeDetail';
  static String routePath = '/overtimeDetail';

  @override
  State<OvertimeDetailWidget> createState() => _OvertimeDetailWidgetState();
}

class _OvertimeDetailWidgetState extends State<OvertimeDetailWidget> {
  late OvertimeDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // createModel requires FlutterFlowModel but OvertimeDetailModel extends BaseViewModel
    _model = OvertimeDetailModel();

    // WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
          backgroundColor: Color(0xFFF6F6F6),
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            automaticallyImplyLeading: false,
            leading: AppIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: FaIcon(
                FontAwesomeIcons.angleLeft,
                color: Theme.of(context).colorScheme.onSurface,
                size: 30.0,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              FFLocalizations.of(context).getText(
                'hx0pjlkj' /* Overtime Detail */,
              ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight:
                        context.headlineMedium?.fontWeight,
                    fontStyle:
                        context.headlineMedium?.fontStyle,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 5.0),
                          child: Container(
                            width: double.infinity,
                            height: 700.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(13.0),
                                bottomRight: Radius.circular(13.0),
                                topLeft: Radius.circular(13.0),
                                topRight: Radius.circular(13.0),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SingleChildScrollView(
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
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 8.0,
                                                                15.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'w9dcts14' /* Overtime */,
                                                      ),
                                                      style:
                                                          Theme.of(context).textTheme.bodyMedium!
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFFF89D27),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!
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
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  15.0,
                                                                  20.0,
                                                                  0.0),
                                                      child: AppButton(
                                                        onPressed: () {
                                                          print(
                                                              'Button pressed ...');
                                                        },
                                                        text: valueOrDefault<
                                                            String>(
                                                          widget
                                                              .overtimedetails
                                                              ?.status,
                                                          'Approved',
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 30.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      24.0,
                                                                      0.0,
                                                                      24.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color:
                                                              Color(0xFFDAE3F3),
                                                          textStyle:
                                                              Theme.of(context).textTheme.titleSmall!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: Theme.of(context).textTheme.titleSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context).textTheme.titleSmall!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(context).colorScheme.surfaceTint,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(context).textTheme.titleSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context).textTheme.titleSmall!
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 3.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      24.0),
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
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 8.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'b8x2jc3d' /* Amount */,
                                                  ),
                                                  style: Theme.of(context).textTheme.bodyMedium!
                                                      .override(
                                                        font: GoogleFonts
                                                            .readexPro(
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            Theme.of(context).textTheme.bodyMedium?.color,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 8.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      widget.overtimedetails
                                                          ?.oTHours,
                                                      '00 hr 00min',
                                                    ),
                                                    style: Theme.of(context).textTheme.bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          color: Theme.of(context).textTheme.bodyMedium?.color,
                                                          fontSize: 10.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
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
                                                alignment: AlignmentDirectional(
                                                    -1.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 8.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'zpf0vrju' /* From  */,
                                                    ),
                                                    style: Theme.of(context).textTheme.bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          color: Theme.of(context).textTheme.bodyMedium?.color,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      functions.changeDateFormat(
                                                          widget
                                                              .overtimedetails
                                                              ?.startDate ?? ''),
                                                      'start date',
                                                    ),
                                                    style: Theme.of(context).textTheme.bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          color: Theme.of(context).textTheme.bodyMedium?.color,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 8.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '8pect1yl' /*  - */,
                                                  ),
                                                  style: Theme.of(context).textTheme.bodyMedium!
                                                      .override(
                                                        font: GoogleFonts
                                                            .readexPro(
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 0.0, 0.0, 8.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    functions.changeDateFormat(
                                                        widget.overtimedetails
                                                            ?.endDate ?? ''),
                                                    'endDate',
                                                  ),
                                                  style: Theme.of(context).textTheme.bodyMedium!
                                                      .override(
                                                        font: GoogleFonts
                                                            .readexPro(
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            Theme.of(context).textTheme.bodyMedium?.color,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context).textTheme.bodyMedium!
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
                                                alignment: AlignmentDirectional(
                                                    -1.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'ed0op15o' /* Note :  */,
                                                    ),
                                                    style: Theme.of(context).textTheme.bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 10.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                valueOrDefault<String>(
                                                  widget.overtimedetails
                                                      ?.purposeOT,
                                                  'note',
                                                ),
                                                style: Theme.of(context).textTheme.bodyMedium!
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          Theme.of(context).textTheme.bodyMedium?.color,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          Theme.of(context).textTheme.bodyMedium!
                                                              .fontWeight,
                                                      fontStyle:
                                                          Theme.of(context).textTheme.bodyMedium!
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'jim6ms4f' /* 1 */,
                                                    ),
                                                    style: Theme.of(context).textTheme.bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          color: Theme.of(context).colorScheme.primary,
                                                          fontSize: 10.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
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
                                                            .fromSTEB(5.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'fkcfthkv' /* attachement */,
                                                      ),
                                                      style:
                                                          Theme.of(context).textTheme.bodyMedium!
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFFF89D27),
                                                                fontSize: 10.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 8.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '2v5xy7n1' /* Request date :  */,
                                                    ),
                                                    style: Theme.of(context).textTheme.bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          color: Theme.of(context).textTheme.bodyMedium?.color,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 8.0, 0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    functions
                                                        .changeRequestedDateFormat(
                                                            widget
                                                                .overtimedetails
                                                                ?.oTRequestedDate ?? ''),
                                                    '11 /03/2025',
                                                  ),
                                                  style: Theme.of(context).textTheme.bodyMedium!
                                                      .override(
                                                        font: GoogleFonts
                                                            .readexPro(
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            Theme.of(context).textTheme.bodyMedium?.color,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Theme.of(context).colorScheme.surface,
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1.0, 1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      8.0, 0.0, 10.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'u50zmrj2' /* Approved by : */,
                                                    ),
                                                    style: Theme.of(context).textTheme.bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          color: Theme.of(context).textTheme.bodyMedium?.color,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        widget.overtimedetails
                                                            ?.approvername,
                                                        'name',
                                                      ),
                                                      style:
                                                          Theme.of(context).textTheme.bodyMedium!
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Theme.of(context).textTheme.bodyMedium?.color,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1.0, 1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      8.0, 10.0, 10.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '3nok0fsj' /* Status : */,
                                                    ),
                                                    style: Theme.of(context).textTheme.bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          color: Theme.of(context).textTheme.bodyMedium?.color,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        widget.overtimedetails
                                                            ?.checkInStatus,
                                                        'status',
                                                      ),
                                                      style:
                                                          Theme.of(context).textTheme.bodyMedium!
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFFFF6A72),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                                fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                -1.0, -1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: Container(
                                                height: 22.0,
                                                decoration: BoxDecoration(
                                                  color: AppColors.bkCheckin,
                                                ),
                                                alignment: AlignmentDirectional(
                                                    -1.0, -1.0),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, 1.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'ywpovmg4' /* Check in */,
                                                        ),
                                                        style:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '9myx1bzy' /* Check out */,
                                                        ),
                                                        style:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1.0, 1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      8.0, 10.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (_model.datePicked ==
                                                          null)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: AppButton(
                                                            onPressed:
                                                                () async {
                                                              await showModalBottomSheet<
                                                                      bool>(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return ScrollConfiguration(
                                                                      behavior:
                                                                          const MaterialScrollBehavior()
                                                                              .copyWith(
                                                                        dragDevices: {
                                                                          PointerDeviceKind
                                                                              .mouse,
                                                                          PointerDeviceKind
                                                                              .touch,
                                                                          PointerDeviceKind
                                                                              .stylus,
                                                                          PointerDeviceKind
                                                                              .unknown
                                                                        },
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            MediaQuery.of(context).size.height /
                                                                                3,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        child:
                                                                            CupertinoDatePicker(
                                                                          mode:
                                                                              CupertinoDatePickerMode.time,
                                                                          minimumDate:
                                                                              DateTime(1900),
                                                                          initialDateTime:
                                                                              getCurrentTimestamp,
                                                                          maximumDate:
                                                                              DateTime(2050),
                                                                          use24hFormat:
                                                                              false,
                                                                          onDateTimeChanged: (newDateTime) =>
                                                                              safeSetState(() {
                                                                            _model.datePicked =
                                                                                newDateTime;
                                                                          }),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'w692xqbb' /* Check-In */,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: 140.0,
                                                              height: 30.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          0.0,
                                                                          24.0,
                                                                          0.0),
                                                              iconAlignment:
                                                                  IconAlignment
                                                                      .start,
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: Color(
                                                                  0xFFF9B052),
                                                              textStyle:
                                                                  Theme.of(context).textTheme.titleSmall!
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight: Theme.of(context).textTheme.titleSmall!
                                                                              .fontWeight,
                                                                          fontStyle: Theme.of(context).textTheme.titleSmall!
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Theme.of(context).colorScheme.surface,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: Theme.of(context).textTheme.titleSmall!
                                                                            .fontWeight,
                                                                        fontStyle: Theme.of(context).textTheme.titleSmall!
                                                                            .fontStyle,
                                                                      ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                          ),
                                                        ),
                                                      Text(
                                                        dateTimeFormat(
                                                          "Hm",
                                                          _model.datePicked,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ),
                                                        style:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 30.0,
                                                    child: VerticalDivider(
                                                      thickness: 2.0,
                                                      color:
                                                          Theme.of(context).colorScheme.surface,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: AppButton(
                                                          onPressed:
                                                              (_model.checkInTime ==
                                                                          null ||
                                                                      _model.checkInTime ==
                                                                          '')
                                                                  ? null
                                                                  : () {
                                                                      print(
                                                                          'Button pressed ...');
                                                                    },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            'zm0uq2hx' /* Check- Out */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width: 140.0,
                                                            height: 30.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        0.0,
                                                                        24.0,
                                                                        0.0),
                                                            iconAlignment:
                                                                IconAlignment
                                                                    .start,
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: Color(
                                                                0xFFF9B052),
                                                            textStyle:
                                                                Theme.of(context).textTheme.titleSmall!
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: Theme.of(context).textTheme.titleSmall!
                                                                            .fontWeight,
                                                                        fontStyle: Theme.of(context).textTheme.titleSmall!
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Theme.of(context).colorScheme.surface,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: Theme.of(context).textTheme.titleSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(context).textTheme.titleSmall!
                                                                          .fontStyle,
                                                                    ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '96a4qg9d' /*   */,
                                                        ),
                                                        style:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'v0tng0dj' /* Total : */,
                                                  ),
                                                  style: Theme.of(context).textTheme.bodyMedium!
                                                      .override(
                                                        font: GoogleFonts
                                                            .readexPro(
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 10.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'a5c0odoe' /*   00 hr  00 min */,
                                                  ),
                                                  style: Theme.of(context).textTheme.bodyMedium!
                                                      .override(
                                                        font: GoogleFonts
                                                            .readexPro(
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontWeight,
                                                        fontStyle:
                                                            Theme.of(context).textTheme.bodyMedium!
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 10.0, 10.0, 10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, -1.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'vseqtb5q' /* Attachment */,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    style: Theme.of(context).textTheme.bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(context).textTheme.bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          color: Theme.of(context).textTheme.bodyMedium?.color,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context).textTheme.bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 0.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      0.0),
                                                        ),
                                                        child: Container(
                                                          width: _model
                                                                  .isDataUploading_uploadDataF93
                                                              ? double.infinity
                                                              : 100.0,
                                                          height: 60.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(context).colorScheme.surface,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                            border: Border.all(
                                                              width: 1.0,
                                                            ),
                                                          ),
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
                                                            onTap: () async {
                                                              // TODO: Implement file upload functionality
                                                              // FlutterFlow-specific file upload methods removed
                                                              // Need to implement: image picker, file upload to server
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text('File upload feature coming soon'),
                                                                ),
                                                              );
                                                              /* REMOVED FlutterFlow code:
                                                              final selectedMedia = await selectMediaWithSourceBottomSheet(...);
                                                              FFUploadedFile, validateFileFormat, GetCheckInImageURLCall
                                                              */
                                                            },
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
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Vector.png',
                                                                    width: 24.0,
                                                                    height:
                                                                        24.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'l8z51luw' /* Attach File */,
                                                                  ),
                                                                  style: Theme.of(context).textTheme.bodyMedium!
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                              .fontWeight,
                                                                          fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Theme.of(context).textTheme.bodyMedium?.color,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: Theme.of(context).textTheme.bodyMedium!
                                                                            .fontWeight,
                                                                        fontStyle: Theme.of(context).textTheme.bodyMedium!
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 80.0,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).colorScheme.surface,
                                                  ),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final oTcheckInImaage = functions
                                                          .leaveAttachmentKHAMethod(
                                                              _model
                                                                  .attachmentModel
                                                                  .toList())
                                                          .toList();

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            oTcheckInImaage
                                                                .length,
                                                        itemBuilder: (context,
                                                            oTcheckInImaageIndex) {
                                                          final oTcheckInImaageItem =
                                                              oTcheckInImaage[
                                                                  oTcheckInImaageIndex];
                                                          return Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: Container(
                                                              width: 80.0,
                                                              height: 80.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(context).colorScheme.surface,
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Stack(
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            15.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                          child:
                                                                              Image.network(
                                                                            getJsonField(
                                                                              {'attachment_file': oTcheckInImaageItem},
                                                                              r'''$.attachment_file''',
                                                                            ).toString(),
                                                                            width:
                                                                                70.0,
                                                                            height:
                                                                                60.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
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
                                                                            _model.removeFromAttachmentModel(getJsonField(
                                                                              {'attachment_file': oTcheckInImaageItem},
                                                                              r'''$.attachment_file''',
                                                                            ).toString());
                                                                            safeSetState(() {});
                                                                          },
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.solidTimesCircle,
                                                                            color:
                                                                                Color(0xFFFD5454),
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ].map((widget) => Padding(
                                                padding: EdgeInsets.only(bottom: 10.0),
                                                child: widget,
                                              )).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 10.0, 10.0, 0.0),
                                      child: AppButton(
                                        onPressed: (_model.datePicked == null)
                                            ? null
                                            : () async {
                                                // TODO: Implement OT check-in API call
                                                // Temporarily disabled due to missing API endpoint
                                                /*
                                                _model.apiResultOtCheckIn =
                                                    await MainGroup
                                                        .oTCheckInMobileCall
                                                        .call(
                                                  theDate: dateTimeFormat(
                                                    "dd/MM/yyyy",
                                                    getCurrentTimestamp,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ),
                                                  clockInTime: _model.datePicked?.toIso8601String() ?? '',
                                                  employeeID:
                                                      context.read<AppState>().employeeID,
                                                  companyID:
                                                      context.read<AppState>().companyID,
                                                  userID: context.read<AppState>().userID,
                                                  attachmentsJson: _model.attachmentModel
                                                      .map((e) => {'attachment_file': e})
                                                      .toList(),
                                                  token: context.read<AppState>().token,
                                                  oTRequestID: widget.oTrequestID ?? 0,
                                                );
                                                */

                                                if ('0' ==
                                                    getJsonField(
                                                      (_model.apiResultOtCheckIn
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$.status''',
                                                    ).toString()) {
                                                  await showDialog(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      return WebViewAware(
                                                        child: AlertDialog(
                                                          title: Text('Alert'),
                                                          content:
                                                              Text(getJsonField(
                                                            (_model.apiResultOtCheckIn
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.message''',
                                                          ).toString()),
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
                                                  // Store clock ID in model instead
                                                  _model.checkInClockID = 0; // TODO: Extract from API response
                                                  safeSetState(() {});

                                                  Navigator.of(context).pushNamed(
                                                      OvertimeWidget.routeName);
                                                }

                                                safeSetState(() {});
                                              },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          'm4k2l3aw' /* Save */,
                                        ),
                                        options: FFButtonOptions(
                                          width: double.infinity,
                                          height: 40.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: Color(0xFFF9B052),
                                          textStyle: Theme.of(context).textTheme.titleSmall!
                                              .override(
                                                font: GoogleFonts.readexPro(
                                                  fontWeight:
                                                      Theme.of(context).textTheme.titleSmall!
                                                          .fontWeight,
                                                  fontStyle:
                                                      Theme.of(context).textTheme.titleSmall!
                                                          .fontStyle,
                                                ),
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    Theme.of(context).textTheme.titleSmall!
                                                        .fontWeight,
                                                fontStyle:
                                                    Theme.of(context).textTheme.titleSmall!
                                                        .fontStyle,
                                              ),
                                          elevation: 3.0,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                    ],
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


