import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import 'my_approval_pending_reject_widget.dart'
    show MyApprovalPendingRejectWidget;
import 'package:flutter/material.dart';

class MyApprovalPendingRejectModel
    extends BaseViewModel<MyApprovalPendingRejectWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (UpdateStatusMyApproval)] action in Button widget.
  ApiCallResponse? apiResultRejectPendingApproval;
  // Stores action output result for [Backend Call - API (GetOTandTimeOff)] action in Button widget.
  ApiCallResponse? apiResultGetOTandTimeOff;
  // Stores action output result for [Backend Call - API (AddNotificationInfoMob)] action in Button widget.
  ApiCallResponse? addNotificationInfoMobAPIresult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
