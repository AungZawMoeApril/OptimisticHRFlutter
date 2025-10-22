import 'package:flutter/material.dart';
import '/backend/api_requests/api_calls.dart';

class TimeAttendanceModel extends ChangeNotifier {
  List<dynamic> calendarList = [];
  ApiCallResponse? apiResultCalendarList;
  List<dynamic> selectedItems = [];

  void updateCalendarList(List<dynamic> newList) {
    calendarList = newList;
    notifyListeners();
  }

  void updateSelectedItems(List<dynamic> items) {
    selectedItems = items;
    notifyListeners();
  }

  void setApiResult(ApiCallResponse response) {
    apiResultCalendarList = response;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}