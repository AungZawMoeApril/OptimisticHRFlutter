import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import 'approval_reject_figma_design_widget.dart'
    show ApprovalRejectFigmaDesignWidget;
import 'package:flutter/material.dart';

class ApprovalRejectFigmaDesignModel
    extends BaseViewModel<ApprovalRejectFigmaDesignWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (UpdateStatusMyApproval)] action in Button widget.
  ApiCallResponse? apiResultw10;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
