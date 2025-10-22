// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveRequestImpl _$$LeaveRequestImplFromJson(Map<String, dynamic> json) =>
    _$LeaveRequestImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      employeeName: json['employeeName'] as String,
      leaveType: json['leaveType'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      duration: (json['duration'] as num).toDouble(),
      reason: json['reason'] as String,
      status: json['status'] as String,
      approverNote: json['approverNote'] as String?,
      approverId: json['approverId'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      attachmentUrl: json['attachmentUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LeaveRequestImplToJson(_$LeaveRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'employeeName': instance.employeeName,
      'leaveType': instance.leaveType,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'duration': instance.duration,
      'reason': instance.reason,
      'status': instance.status,
      'approverNote': instance.approverNote,
      'approverId': instance.approverId,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'attachmentUrl': instance.attachmentUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
