import '/backend/api_requests/api_calls.dart';
import '/core/utils/app_utils.dart';
import 'leave_page_widget.dart' show LeavePageWidget;
import 'package:flutter/material.dart';

class LeavePageModel extends FlutterFlowModel<LeavePageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex => tabBarController != null ? tabBarController!.index : 0;

  // Stores action output result for [Backend Call - API (getTimeOffRequestByCompanyIdPagination)] action in LeavePage widget.
  ApiCallResponse? apiResutleaveList;

  // State field(s) for leave list
  List<dynamic> allLeaveListView = [];
  List<dynamic> todayLeaveList = [];
  List<dynamic> historyLeaveList = [];

  // State field(s) for leave type filter
  dynamic leaveTypeID = '';
  String? leavedayCount;

  @override
  void initState(BuildContext context) {
    // Initialize any required state
  }

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
