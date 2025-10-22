import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_record.freezed.dart';
part 'attendance_record.g.dart';

@freezed
class AttendanceRecord with _$AttendanceRecord {
  const factory AttendanceRecord({
    required String id,
    required String userId,
    required DateTime date,
    required DateTime checkIn,
    DateTime? checkOut,
    required String status, // 'PRESENT', 'ABSENT', 'LATE', 'EARLY_LEAVE'
    String? location,
    double? latitude,
    double? longitude,
    String? notes,
    String? checkInImage,
    String? checkOutImage,
    @Default(false) bool isOvertime,
    @Default(false) bool isOnSite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AttendanceRecord;

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordFromJson(json);
}