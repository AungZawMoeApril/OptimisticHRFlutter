import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import 'my_approval_history_cancel_widget.dart'
    show MyApprovalHistoryCancelWidget;
import 'package:flutter/material.dart';

class MyApprovalHistoryCancelModel
    extends FlutterFlowModel<MyApprovalHistoryCancelWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (UpdateStatusMyApproval)] action in Button widget.
  ApiCallResponse? apiResultUpdateStatusMyApproval;
  // Stores action output result for [Backend Call - API (GetOTandTimeOffMobile)] action in Button widget.
  ApiCallResponse? apiResultGetOTandTimeOff;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
