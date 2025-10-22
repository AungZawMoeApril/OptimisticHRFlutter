import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import 'my_approval_pending_approve_widget.dart'
    show MyApprovalPendingApproveWidget;
import 'package:flutter/material.dart';

class MyApprovalPendingApproveModel
    extends FlutterFlowModel<MyApprovalPendingApproveWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (UpdateStatusMyApproval)] action in Button widget.
  ApiCallResponse? apiResultUpdateStatus;
  // Stores action output result for [Backend Call - API (GetOTandTimeOffMobile)] action in Button widget.
  ApiCallResponse? apiResultGetOTandTimeOff;
  // Stores action output result for [Backend Call - API (AddNotificationInfoMob)] action in Button widget.
  ApiCallResponse? addNotificationInfoMobAPI;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
