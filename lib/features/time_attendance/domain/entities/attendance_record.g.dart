// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceRecordImpl _$$AttendanceRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceRecordImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      checkIn: DateTime.parse(json['checkIn'] as String),
      checkOut: json['checkOut'] == null
          ? null
          : DateTime.parse(json['checkOut'] as String),
      status: json['status'] as String,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      checkInImage: json['checkInImage'] as String?,
      checkOutImage: json['checkOutImage'] as String?,
      isOvertime: json['isOvertime'] as bool? ?? false,
      isOnSite: json['isOnSite'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AttendanceRecordImplToJson(
        _$AttendanceRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'date': instance.date.toIso8601String(),
      'checkIn': instance.checkIn.toIso8601String(),
      'checkOut': instance.checkOut?.toIso8601String(),
      'status': instance.status,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'notes': instance.notes,
      'checkInImage': instance.checkInImage,
      'checkOutImage': instance.checkOutImage,
      'isOvertime': instance.isOvertime,
      'isOnSite': instance.isOnSite,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
