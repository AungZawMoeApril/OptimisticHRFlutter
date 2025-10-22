import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum OvertimeStatus {
  pending,
  approved,
  rejected,
  cancelled,
}

enum OvertimeType {
  weekday,
  weekend,
  holiday,
}

class OvertimeRequest extends Equatable {
  final String id;
  final String employeeId;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final OvertimeType type;
  final String reason;
  final OvertimeStatus status;
  final double hours;
  final String? approverNote;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OvertimeRequest({
    required this.id,
    required this.employeeId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.reason,
    required this.status,
    required this.hours,
    this.approverNote,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isPending => status == OvertimeStatus.pending;
  bool get isApproved => status == OvertimeStatus.approved;
  bool get isRejected => status == OvertimeStatus.rejected;
  bool get isCancelled => status == OvertimeStatus.cancelled;

  @override
  List<Object?> get props => [
        id,
        employeeId,
        date,
        startTime,
        endTime,
        type,
        reason,
        status,
        hours,
        approverNote,
        createdAt,
        updatedAt,
      ];
}

class OvertimeStats extends Equatable {
  final int totalRequests;
  final int approvedRequests;
  final int pendingRequests;
  final int rejectedRequests;
  final double totalHours;
  final double approvedHours;
  final double pendingHours;

  const OvertimeStats({
    required this.totalRequests,
    required this.approvedRequests,
    required this.pendingRequests,
    required this.rejectedRequests,
    required this.totalHours,
    required this.approvedHours,
    required this.pendingHours,
  });

  @override
  List<Object?> get props => [
        totalRequests,
        approvedRequests,
        pendingRequests,
        rejectedRequests,
        totalHours,
        approvedHours,
        pendingHours,
      ];
}