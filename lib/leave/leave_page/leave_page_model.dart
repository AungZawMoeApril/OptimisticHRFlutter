import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import '/index.dart';
import 'leave_page_widget.dart' show LeavePageWidget;
import 'package:flutter/material.dart';

class LeavePageModel extends BaseViewModel<LeavePageWidget> {
  ///  Local state fields for this page.

  int? leaveTypeID = 0;

  List<dynamic> allLeaveListView = [];
  void addToAllLeaveListView(dynamic item) => allLeaveListView.add(item);
  void removeFromAllLeaveListView(dynamic item) =>
      allLeaveListView.remove(item);
  void removeAtIndexFromAllLeaveListView(int index) =>
      allLeaveListView.removeAt(index);
  void insertAtIndexInAllLeaveListView(int index, dynamic item) =>
      allLeaveListView.insert(index, item);
  void updateAllLeaveListViewAtIndex(int index, Function(dynamic) updateFn) =>
      allLeaveListView[index] = updateFn(allLeaveListView[index]);

  String? leavedayCount;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetTimeOffRequestByCompanyIdPagination)] action in LeavePage widget.
  ApiCallResponse? apiResutleaveList;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
