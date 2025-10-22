import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import 'delete_o_t_request_dialog_widget.dart' show DeleteOTRequestDialogWidget;
import 'package:flutter/material.dart';

class DeleteOTRequestDialogModel
    extends FlutterFlowModel<DeleteOTRequestDialogWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (DeleteOTRequests)] action in Button widget.
  ApiCallResponse? apiResultDeleteOT;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
