import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import '/index.dart';
import 'on_site_widget.dart' show OnSiteWidget;
import 'package:flutter/material.dart';

class $1Model extends BaseViewModel {
  ///  Local state fields for this page.

  List<dynamic> onSiteListView = [];
  void addToOnSiteListView(dynamic item) => onSiteListView.add(item);
  void removeFromOnSiteListView(dynamic item) => onSiteListView.remove(item);
  void removeAtIndexFromOnSiteListView(int index) =>
      onSiteListView.removeAt(index);
  void insertAtIndexInOnSiteListView(int index, dynamic item) =>
      onSiteListView.insert(index, item);
  void updateOnSiteListViewAtIndex(int index, Function(dynamic) updateFn) =>
      onSiteListView[index] = updateFn(onSiteListView[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetTimeAttendanceListMobile)] action in OnSite widget.
  ApiCallResponse? apiResultGetALl;
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
