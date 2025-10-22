import 'package:flutter/material.dart';
import '../models/leave_balance.dart';
import '../models/uploaded_file.dart';

class LeaveEditState extends ChangeNotifier {
  int? selectedLeaveTypeId;
  bool isAllDay = true;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? halfDayDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String description = '';
  List<String> attachments = [];
  double balance = 0;
  double availableDay = 0;

  void updateLeaveType(int id, List<LeaveType> leaveTypes) {
    selectedLeaveTypeId = id;
    final leaveType = leaveTypes.firstWhere((lt) => lt.timeOffId == id);
    balance = leaveType.leaveDaysLeft;
    availableDay = leaveType.leaveDaysLeft;
    notifyListeners();
  }

  void toggleDayType() {
    isAllDay = !isAllDay;
    notifyListeners();
  }

  void updateStartDate(DateTime date) {
    startDate = date;
    if (endDate == null || date.isAfter(endDate!)) {
      endDate = date;
    }
    notifyListeners();
  }

  void updateEndDate(DateTime date) {
    if (startDate != null && !date.isBefore(startDate!)) {
      endDate = date;
      notifyListeners();
    }
  }

  void updateHalfDayDate(DateTime date) {
    halfDayDate = date;
    notifyListeners();
  }

  void updateStartTime(TimeOfDay time) {
    startTime = time;
    if (endTime == null) {
      endTime = TimeOfDay(hour: time.hour + 1, minute: time.minute);
    }
    notifyListeners();
  }

  void updateEndTime(TimeOfDay time) {
    if (startTime != null && 
        (time.hour > startTime!.hour || 
        (time.hour == startTime!.hour && time.minute > startTime!.minute))) {
      endTime = time;
      notifyListeners();
    }
  }

  void updateDescription(String text) {
    description = text;
    notifyListeners();
  }

  void addAttachment(String url) {
    attachments.add(url);
    notifyListeners();
  }

  void removeAttachment(String url) {
    attachments.remove(url);
    notifyListeners();
  }
}