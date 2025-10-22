import 'package:flutter/material.dart';
import '../../domain/entities/overtime_entities.dart';

class OvertimeRequestModel extends OvertimeRequest {
  const OvertimeRequestModel({
    required String id,
    required String employeeId,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required OvertimeType type,
    required String reason,
    required OvertimeStatus status,
    required double hours,
    String? approverNote,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          employeeId: employeeId,
          date: date,
          startTime: startTime,
          endTime: endTime,
          type: type,
          reason: reason,
          status: status,
          hours: hours,
          approverNote: approverNote,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory OvertimeRequestModel.fromJson(Map<String, dynamic> json) {
    return OvertimeRequestModel(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: _timeFromString(json['startTime'] as String),
      endTime: _timeFromString(json['endTime'] as String),
      type: OvertimeType.values.firstWhere(
        (type) => type.toString().split('.').last == json['type'],
      ),
      reason: json['reason'] as String,
      status: OvertimeStatus.values.firstWhere(
        (status) => status.toString().split('.').last == json['status'],
      ),
      hours: (json['hours'] as num).toDouble(),
      approverNote: json['approverNote'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'date': date.toIso8601String(),
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'type': type.toString().split('.').last,
      'reason': reason,
      'status': status.toString().split('.').last,
      'hours': hours,
      if (approverNote != null) 'approverNote': approverNote,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static TimeOfDay _timeFromString(String timeStr) {
    final parts = timeStr.split(':').map(int.parse).toList();
    return TimeOfDay(hour: parts[0], minute: parts[1]);
  }
}

class OvertimeStatsModel extends OvertimeStats {
  const OvertimeStatsModel({
    required int totalRequests,
    required int approvedRequests,
    required int pendingRequests,
    required int rejectedRequests,
    required double totalHours,
    required double approvedHours,
    required double pendingHours,
  }) : super(
          totalRequests: totalRequests,
          approvedRequests: approvedRequests,
          pendingRequests: pendingRequests,
          rejectedRequests: rejectedRequests,
          totalHours: totalHours,
          approvedHours: approvedHours,
          pendingHours: pendingHours,
        );

  factory OvertimeStatsModel.fromJson(Map<String, dynamic> json) {
    return OvertimeStatsModel(
      totalRequests: json['totalRequests'] as int,
      approvedRequests: json['approvedRequests'] as int,
      pendingRequests: json['pendingRequests'] as int,
      rejectedRequests: json['rejectedRequests'] as int,
      totalHours: (json['totalHours'] as num).toDouble(),
      approvedHours: (json['approvedHours'] as num).toDouble(),
      pendingHours: (json['pendingHours'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalRequests': totalRequests,
      'approvedRequests': approvedRequests,
      'pendingRequests': pendingRequests,
      'rejectedRequests': rejectedRequests,
      'totalHours': totalHours,
      'approvedHours': approvedHours,
      'pendingHours': pendingHours,
    };
  }
}