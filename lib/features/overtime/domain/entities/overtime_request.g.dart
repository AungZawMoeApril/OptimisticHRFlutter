// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overtime_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OvertimeRequestImpl _$$OvertimeRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OvertimeRequestImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      employeeName: json['employeeName'] as String,
      requestDate: DateTime.parse(json['requestDate'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      reason: json['reason'] as String,
      status: json['status'] as String,
      approverNote: json['approverNote'] as String?,
      approverId: json['approverId'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$OvertimeRequestImplToJson(
        _$OvertimeRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'employeeName': instance.employeeName,
      'requestDate': instance.requestDate.toIso8601String(),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'reason': instance.reason,
      'status': instance.status,
      'approverNote': instance.approverNote,
      'approverId': instance.approverId,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
