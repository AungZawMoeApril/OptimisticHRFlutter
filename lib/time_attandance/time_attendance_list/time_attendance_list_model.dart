import 'package:flutter/material.dart';
import '../../../core/api/api_client.dart';

class TimeAttendanceListModel {
  List<TimeAttendanceList> monthViewTimeAttendance = [];
  TabController? tabBarController;
  bool isDataUploading = false;

  void dispose() {
    tabBarController?.dispose();
  }

  void addToMonthViewTimeAttendance(TimeAttendanceList item) =>
      monthViewTimeAttendance.add(item);
  void removeFromMonthViewTimeAttendance(TimeAttendanceList item) =>
      monthViewTimeAttendance.remove(item);
  void removeAtIndexFromMonthViewTimeAttendance(int index) =>
      monthViewTimeAttendance.removeAt(index);
  void insertAtIndexInMonthViewTimeAttendance(int index, TimeAttendanceList item) =>
      monthViewTimeAttendance.insert(index, item);
  void updateMonthViewTimeAttendanceAtIndex(
          int index, TimeAttendanceList Function(TimeAttendanceList) updateFn) =>
      monthViewTimeAttendance[index] = updateFn(monthViewTimeAttendance[index]);

  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;
}
