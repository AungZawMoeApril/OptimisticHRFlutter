import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import 'package:hr_app/core/utils/form_field_controller.dart';
import '/index.dart';
import 'overtime_widget.dart' show OvertimeWidget;
import 'package:flutter/material.dart';

class $1Model extends BaseViewModel {
  ///  Local state fields for this page.

  List<dynamic> overTimeHistory = [];
  void addToOverTimeHistory(dynamic item) => overTimeHistory.add(item);
  void removeFromOverTimeHistory(dynamic item) => overTimeHistory.remove(item);
  void removeAtIndexFromOverTimeHistory(int index) =>
      overTimeHistory.removeAt(index);
  void insertAtIndexInOverTimeHistory(int index, dynamic item) =>
      overTimeHistory.insert(index, item);
  void updateOverTimeHistoryAtIndex(int index, Function(dynamic) updateFn) =>
      overTimeHistory[index] = updateFn(overTimeHistory[index]);

  List<dynamic> overtimeStatusAllData = [];
  void addToOvertimeStatusAllData(dynamic item) =>
      overtimeStatusAllData.add(item);
  void removeFromOvertimeStatusAllData(dynamic item) =>
      overtimeStatusAllData.remove(item);
  void removeAtIndexFromOvertimeStatusAllData(int index) =>
      overtimeStatusAllData.removeAt(index);
  void insertAtIndexInOvertimeStatusAllData(int index, dynamic item) =>
      overtimeStatusAllData.insert(index, item);
  void updateOvertimeStatusAllDataAtIndex(
          int index, Function(dynamic) updateFn) =>
      overtimeStatusAllData[index] = updateFn(overtimeStatusAllData[index]);

  String? yeardata;

  String? monthData;

  List<dynamic> overtimeApprovedTab = [];
  void addToOvertimeApprovedTab(dynamic item) => overtimeApprovedTab.add(item);
  void removeFromOvertimeApprovedTab(dynamic item) =>
      overtimeApprovedTab.remove(item);
  void removeAtIndexFromOvertimeApprovedTab(int index) =>
      overtimeApprovedTab.removeAt(index);
  void insertAtIndexInOvertimeApprovedTab(int index, dynamic item) =>
      overtimeApprovedTab.insert(index, item);
  void updateOvertimeApprovedTabAtIndex(
          int index, Function(dynamic) updateFn) =>
      overtimeApprovedTab[index] = updateFn(overtimeApprovedTab[index]);

  List<dynamic> overtimePendingTab = [];
  void addToOvertimePendingTab(dynamic item) => overtimePendingTab.add(item);
  void removeFromOvertimePendingTab(dynamic item) =>
      overtimePendingTab.remove(item);
  void removeAtIndexFromOvertimePendingTab(int index) =>
      overtimePendingTab.removeAt(index);
  void insertAtIndexInOvertimePendingTab(int index, dynamic item) =>
      overtimePendingTab.insert(index, item);
  void updateOvertimePendingTabAtIndex(int index, Function(dynamic) updateFn) =>
      overtimePendingTab[index] = updateFn(overtimePendingTab[index]);

  int? timeZoneOffsetSeconds;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetCurrentOTMobile)] action in Overtime widget.
  ApiCallResponse? apiResultCurrentOTime;
  // Stores action output result for [Backend Call - API (apiOvertimeHistory POST)] action in Overtime widget.
  ApiCallResponse? apiResulHistory;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Backend Call - API (GetOTRequestByStatusMobile)] action in Row widget.
  ApiCallResponse? apiResultftp;
  // Stores action output result for [Backend Call - API (GetOTRequestByStatusMobile)] action in Tab widget.
  ApiCallResponse? apiResulOTPendingList;
  // Stores action output result for [Backend Call - API (GetOTRequestByStatusMobile)] action in Row widget.
  ApiCallResponse? apiResulOTPending;
  // Stores action output result for [Backend Call - API (GetOTRequestByStatusMobile)] action in Row widget.
  ApiCallResponse? apiHistoryYearResult;
  // State field(s) for OvertimeStatus widget.
  String? overtimeStatusValue;
  FormFieldController<String>? overtimeStatusValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
