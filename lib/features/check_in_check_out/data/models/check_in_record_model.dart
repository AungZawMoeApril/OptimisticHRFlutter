import '../../domain/entities/check_in_record.dart';

class CheckInRecordModel extends CheckInRecord {
  const CheckInRecordModel({
    required String id,
    required String employeeId,
    required DateTime checkInTime,
    DateTime? checkOutTime,
    required String location,
    required double latitude,
    required double longitude,
    required String status,
    String? notes,
  }) : super(
          id: id,
          employeeId: employeeId,
          checkInTime: checkInTime,
          checkOutTime: checkOutTime,
          location: location,
          latitude: latitude,
          longitude: longitude,
          status: status,
          notes: notes,
        );

  factory CheckInRecordModel.fromJson(Map<String, dynamic> json) {
    return CheckInRecordModel(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      checkInTime: DateTime.parse(json['checkInTime'] as String),
      checkOutTime: json['checkOutTime'] != null
          ? DateTime.parse(json['checkOutTime'] as String)
          : null,
      location: json['location'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      status: json['status'] as String,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'checkInTime': checkInTime.toIso8601String(),
      if (checkOutTime != null) 'checkOutTime': checkOutTime!.toIso8601String(),
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      if (notes != null) 'notes': notes,
    };
  }
}