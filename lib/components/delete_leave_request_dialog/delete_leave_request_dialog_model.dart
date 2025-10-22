import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import 'delete_leave_request_dialog_widget.dart'
    show DeleteLeaveRequestDialogWidget;
import 'package:flutter/material.dart';

class DeleteLeaveRequestDialogModel
    extends FlutterFlowModel<DeleteLeaveRequestDialogWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (DeleteTimeOff)] action in Button widget.
  ApiCallResponse? apiResultbxb;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
