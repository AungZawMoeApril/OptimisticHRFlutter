import 'package:flutter/material.dart';
import '../../domain/entities/onsite_entities.dart';

class OnsiteRequestModel extends OnsiteRequest {
  const OnsiteRequestModel({
    required String id,
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required OnsiteType type,
    required String location,
    required String reason,
    required OnsiteStatus status,
    String? approverNote,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          employeeId: employeeId,
          startDate: startDate,
          endDate: endDate,
          startTime: startTime,
          endTime: endTime,
          type: type,
          location: location,
          reason: reason,
          status: status,
          approverNote: approverNote,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory OnsiteRequestModel.fromJson(Map<String, dynamic> json) {
    return OnsiteRequestModel(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      startTime: _timeFromString(json['startTime'] as String),
      endTime: _timeFromString(json['endTime'] as String),
      type: OnsiteType.values.firstWhere(
        (type) => type.toString().split('.').last == json['type'],
      ),
      location: json['location'] as String,
      reason: json['reason'] as String,
      status: OnsiteStatus.values.firstWhere(
        (status) => status.toString().split('.').last == json['status'],
      ),
      approverNote: json['approverNote'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'type': type.toString().split('.').last,
      'location': location,
      'reason': reason,
      'status': status.toString().split('.').last,
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

class OnsiteStatsModel extends OnsiteStats {
  const OnsiteStatsModel({
    required int totalRequests,
    required int approvedRequests,
    required int pendingRequests,
    required int rejectedRequests,
    required int totalDays,
    required int approvedDays,
    required int pendingDays,
  }) : super(
          totalRequests: totalRequests,
          approvedRequests: approvedRequests,
          pendingRequests: pendingRequests,
          rejectedRequests: rejectedRequests,
          totalDays: totalDays,
          approvedDays: approvedDays,
          pendingDays: pendingDays,
        );

  factory OnsiteStatsModel.fromJson(Map<String, dynamic> json) {
    return OnsiteStatsModel(
      totalRequests: json['totalRequests'] as int,
      approvedRequests: json['approvedRequests'] as int,
      pendingRequests: json['pendingRequests'] as int,
      rejectedRequests: json['rejectedRequests'] as int,
      totalDays: json['totalDays'] as int,
      approvedDays: json['approvedDays'] as int,
      pendingDays: json['pendingDays'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalRequests': totalRequests,
      'approvedRequests': approvedRequests,
      'pendingRequests': pendingRequests,
      'rejectedRequests': rejectedRequests,
      'totalDays': totalDays,
      'approvedDays': approvedDays,
      'pendingDays': pendingDays,
    };
  }
}