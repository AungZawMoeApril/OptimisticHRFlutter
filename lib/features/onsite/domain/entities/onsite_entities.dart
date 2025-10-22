import 'package:flutter/material.dart';

enum OnsiteStatus {
  pending,
  approved,
  rejected,
  cancelled,
}

enum OnsiteType {
  client,
  project,
  training,
  other,
}

class OnsiteRequest {
  final String id;
  final String employeeId;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final OnsiteType type;
  final String location;
  final String reason;
  final OnsiteStatus status;
  final String? approverNote;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OnsiteRequest({
    required this.id,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.location,
    required this.reason,
    required this.status,
    this.approverNote,
    required this.createdAt,
    required this.updatedAt,
  });

  int get durationInDays => endDate.difference(startDate).inDays + 1;
}

class OnsiteStats {
  final int totalRequests;
  final int approvedRequests;
  final int pendingRequests;
  final int rejectedRequests;
  final int totalDays;
  final int approvedDays;
  final int pendingDays;

  const OnsiteStats({
    required this.totalRequests,
    required this.approvedRequests,
    required this.pendingRequests,
    required this.rejectedRequests,
    required this.totalDays,
    required this.approvedDays,
    required this.pendingDays,
  });
}