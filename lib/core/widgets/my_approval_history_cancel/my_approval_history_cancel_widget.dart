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
import 'my_approval_history_cancel_model.dart';
export 'my_approval_history_cancel_model.dart';

class MyApprovalHistoryCancelWidget extends StatefulWidget {
  const MyApprovalHistoryCancelWidget({
    super.key,
    required this.myApprovalHistoryIndex,
    required this.workflowName,
    required this.wFID,
    required this.reason,
    required this.status,
    required this.requeststatus,
    required this.userID,
    required this.approverOrder,
  });

  final int? myApprovalHistoryIndex;
  final String? workflowName;
  final int? wFID;
  final String? reason;
  final String? status;
  final String? requeststatus;
  final int? userID;
  final int? approverOrder;

  @override
  State<MyApprovalHistoryCancelWidget> createState() =>
      _MyApprovalHistoryCancelWidgetState();
}

class _MyApprovalHistoryCancelWidgetState
    extends State<MyApprovalHistoryCancelWidget> {
  late MyApprovalHistoryCancelModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyApprovalHistoryCancelModel());

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

    return Container(
      width: double.infinity,
      height: 150.0,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
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
                  labelStyle: Theme.of(context).textTheme.$1?.copyWith(
                        font: GoogleFonts.readexPro(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            Theme.of(context).textTheme.labelMedium.fontWeight,
                        fontStyle:
                            Theme.of(context).textTheme.labelMedium.fontStyle,
                      ),
                  hintText: FFLocalizations.of(context).getText(
                    'oj3dujjj' /* Please fll in the reason for c... */,
                  ),
                  hintStyle: Theme.of(context).textTheme.$1?.copyWith(
                        font: GoogleFonts.readexPro(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            Theme.of(context).textTheme.labelMedium.fontWeight,
                        fontStyle:
                            Theme.of(context).textTheme.labelMedium.fontStyle,
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
                  fillColor: Theme.of(context).colorScheme.secondaryBackground,
                ),
                style: Theme.of(context).textTheme.$1?.copyWith(
                      font: GoogleFonts.readexPro(
                        fontWeight:
                            context.textTheme.bodyMedium.fontWeight,
                        fontStyle:
                            context.textTheme.bodyMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          context.textTheme.bodyMedium.fontWeight,
                      fontStyle:
                          context.textTheme.bodyMedium.fontStyle,
                    ),
                maxLines: 3,
                cursorColor: Theme.of(context).colorScheme.primaryText,
                validator: _model.textControllerValidator.asValidator(context),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                  child: AppButton(
                    onPressed: () async {
                      AppState().updateOnloadGetOTandTimeOffHistoryAtIndex(
                        widget.myApprovalHistoryIndex!,
                        (e) => e..cancelFlag = false,
                      );
                      AppState().update(() {});
                    },
                    text: FFLocalizations.of(context).getText(
                      '0otr2w0z' /* Close */,
                    ),
                    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(40.0),
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
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                  child: AppButton(
                    onPressed: (_model.textController.text == '')
                        ? null
                        : () async {
                            _model.apiResultUpdateStatusMyApproval =
                                await MainGroup.updateStatusMyApprovalCall.call(
                              requeststatus: 'Canceled',
                              status: 'Canceled',
                              wFID: widget.wFID,
                              reason: _model.textController.text,
                              userID: widget.userID,
                              approverOrder: widget.approverOrder,
                              token: AppState().token,
                            );

                            if ((_model.apiResultUpdateStatusMyApproval
                                    ?.succeeded ??
                                true)) {
                              _model.apiResultGetOTandTimeOff = await MainGroup
                                  .getOTandTimeOffMobileCall
                                  .call(
                                year: dateTimeFormat(
                                  "yyyy",
                                  getCurrentTimestamp,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                employeeID: AppState().employeeID,
                                companyID: AppState().companyID,
                                token: AppState().token,
                              );

                              if ((_model.apiResultGetOTandTimeOff?.succeeded ??
                                  true)) {
                                AppState()
                                    .onloadGetOTandTimeOff = (getJsonField(
                                  (_model.apiResultGetOTandTimeOff?.jsonBody ??
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
                                  (_model.apiResultGetOTandTimeOff?.jsonBody ??
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
                                            (e.status != 'Waiting Approval') &&
                                            (e.status != 'Draft Request'))
                                        .toList()
                                        .cast<RejectPendingApprovalStruct>();
                                AppState().update(() {});
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        title: Text('Cancelled.'),
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
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        title: Text('Error Cancelling Request'),
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

                              Navigator.pop(context);
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title: Text('Error Cancelling Request'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
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
                      '9i8ptte3' /* Confirm */,
                    ),
                    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(40.0),
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
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                      disabledColor: Theme.of(context).colorScheme.secondaryText,
                      disabledTextColor:
                          Theme.of(context).colorScheme.secondaryBackground,
                    ),
                  ),
                ),
              ),
            ].addToStart(SizedBox(width: 10.0)).addToEnd(SizedBox(width: 10.0)),
          ),
        ],
      ),
    );
  }
}
