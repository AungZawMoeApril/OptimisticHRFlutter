import '../core/widgets/app_widgets.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import '../core/widgets/app_button.dart';;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'my_approval_pending_reject_model.dart';
export 'my_approval_pending_reject_model.dart';

class MyApprovalPendingRejectWidget extends StatefulWidget {
  const MyApprovalPendingRejectWidget({
    super.key,
    required this.workFlowName,
    required this.workFlowID,
    required this.approverPrder,
    required this.taskType,
  });

  final String? workFlowName;
  final int? workFlowID;
  final int? approverPrder;
  final String? taskType;

  @override
  State<MyApprovalPendingRejectWidget> createState() =>
      _MyApprovalPendingRejectWidgetState();
}

class _MyApprovalPendingRejectWidgetState
    extends State<MyApprovalPendingRejectWidget> {
  late MyApprovalPendingRejectModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyApprovalPendingRejectModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 330.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 7.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                -2.0,
              ),
            )
          ],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '2ov5tgs7' /* Please fill in the reason for ... */,
                    ),
                    style: Theme.of(context).textTheme.$1?.copyWith(
                          font: GoogleFonts.outfit(
                            fontWeight: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontStyle,
                          ),
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontStyle,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _model.textController,
                    focusNode: _model.textFieldFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.textController',
                      Duration(milliseconds: 0),
                      () => safeSetState(() {}),
                    ),
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle:
                          Theme.of(context).textTheme.$1?.copyWith(
                                font: GoogleFonts.readexPro(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                      hintText: FFLocalizations.of(context).getText(
                        'ky53usv9' /* Please fll in the reason for r... */,
                      ),
                      hintStyle:
                          Theme.of(context).textTheme.$1?.copyWith(
                                font: GoogleFonts.readexPro(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFD9D9D9),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.secondaryBackground,
                    ),
                    style: Theme.of(context).textTheme.$1?.copyWith(
                          font: GoogleFonts.readexPro(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              context.textTheme.bodyMedium.fontStyle,
                        ),
                    maxLines: 4,
                    cursorColor: Theme.of(context).colorScheme.primaryText,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
                color: Color(0xFFAFBCC7),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 10.0),
                    child: AppButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: FFLocalizations.of(context).getText(
                        '29ltmw70' /* Close */,
                      ),
                      style: ElevatedButton.styleFrom(
      minimumSize: Size(140.0, 40.0),
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
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Theme.of(context).colorScheme.secondaryBackground,
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
                              color: Theme.of(context).colorScheme.secondaryText,
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
                          color: Color(0xFFD9D9D9),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 18.0, 10.0),
                    child: AppButton(
                      onPressed: (_model.textController.text == '')
                          ? null
                          : () async {
                              _model.apiResultRejectPendingApproval =
                                  await MainGroup.updateStatusMyApprovalCall
                                      .call(
                                reason: _model.textController.text,
                                requeststatus: widget.workFlowName,
                                status: 'Denied',
                                wFID: widget.workFlowID,
                                userID: AppState().userID,
                                approverOrder: widget.approverPrder,
                                token: AppState().token,
                              );

                              if (MainGroup.updateStatusMyApprovalCall.status(
                                    (_model.apiResultRejectPendingApproval
                                            ?.jsonBody ??
                                        ''),
                                  ) ==
                                  0) {
                                _model.apiResultGetOTandTimeOff =
                                    await MainGroup.getOTandTimeOffCall.call(
                                  companyIDMain: AppState().companyID,
                                  employeeIDMain: AppState().employeeID,
                                  token: AppState().token,
                                );

                                if ((_model
                                        .apiResultGetOTandTimeOff?.succeeded ??
                                    true)) {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          title: Text('Rejected.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  AppState()
                                      .onloadGetOTandTimeOff = (getJsonField(
                                    (_model.apiResultGetOTandTimeOff
                                            ?.jsonBody ??
                                        ''),
                                    r'''$.data''',
                                    true,
                                  )!
                                              .toList()
                                              .map<RejectPendingApprovalStruct?>(
                                                  RejectPendingApprovalStruct
                                                      .maybeFromMap)
                                              .toList()
                                          as Iterable<
                                              RejectPendingApprovalStruct?>)
                                      .withoutNulls
                                      .where(
                                          (e) => e.status == 'Waiting Approval')
                                      .toList()
                                      .cast<RejectPendingApprovalStruct>();
                                  AppState().onloadGetOTandTimeOffHistory =
                                      (getJsonField(
                                    (_model.apiResultGetOTandTimeOff
                                            ?.jsonBody ??
                                        ''),
                                    r'''$.data''',
                                    true,
                                  )!
                                                  .toList()
                                                  .map<RejectPendingApprovalStruct?>(
                                                      RejectPendingApprovalStruct
                                                          .maybeFromMap)
                                                  .toList()
                                              as Iterable<
                                                  RejectPendingApprovalStruct?>)
                                          .withoutNulls
                                          .where((e) =>
                                              (e.status !=
                                                  'Waiting Approval') &&
                                              (e.status != 'Draft Request'))
                                          .toList()
                                          .cast<RejectPendingApprovalStruct>();
                                  AppState().update(() {});
                                  _model.addNotificationInfoMobAPIresult =
                                      await MainGroup.addNotificationInfoMobCall
                                          .call(
                                    wFID: widget.workFlowID,
                                    senderID: AppState().employeeID,
                                    recipientID: 0,
                                    seen: false,
                                    description: widget.taskType == 'OT'
                                        ? 'rejected your OT request'
                                        : 'rejected your Time Off request',
                                    delicated: false,
                                    token: AppState().token,
                                  );
                                }
                                Navigator.pop(context);
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        title: Text('Reject Fail !'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }

                              safeSetState(() {});
                            },
                      text: FFLocalizations.of(context).getText(
                        'odcigpr7' /* Comfirm */,
                      ),
                      style: ElevatedButton.styleFrom(
      minimumSize: Size(140.0, 40.0),
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
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                        disabledColor:
                            Theme.of(context).colorScheme.secondaryText,
                        disabledTextColor:
                            Theme.of(context).colorScheme.secondaryBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
