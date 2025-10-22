import 'package:flutter/material.dart';

class HomeData {
  final String employeeId;
  final String companyId;
  final TimeOfDay? shiftStartTime;
  final TimeOfDay? shiftEndTime;
  final String clockInTime;
  final String clockOutTime;
  final String timeType;
  final bool approve;
  final int timezoneOffset;

  HomeData({
    required this.employeeId,
    required this.companyId,
    this.shiftStartTime,
    this.shiftEndTime,
    this.clockInTime = '-',
    this.clockOutTime = '-',
    this.timeType = 'Regular',
    this.approve = false,
    this.timezoneOffset = 0,
  });
}