import '../../domain/entities/attendance_status.dart';

class AttendanceStatusModel extends AttendanceStatus {
  AttendanceStatusModel({
    required String clockInTime,
    required String clockOutTime,
    required String shiftStartTime,
    required String shiftEndTime,
    required String timeType,
    required bool canCheckIn,
    required bool approve,
  }) : super(
          clockInTime: clockInTime,
          clockOutTime: clockOutTime,
          shiftStartTime: shiftStartTime,
          shiftEndTime: shiftEndTime,
          timeType: timeType,
          canCheckIn: canCheckIn,
          approve: approve,
        );

  factory AttendanceStatusModel.fromJson(Map<String, dynamic> json) {
    return AttendanceStatusModel(
      clockInTime: json['latestCheckIN'] ?? '-',
      clockOutTime: json['lastestCheckOut'] ?? '-',
      shiftStartTime: json['startTime'] ?? '',
      shiftEndTime: json['endTime'] ?? '',
      timeType: json['timeType'] ?? 'Regular',
      canCheckIn: json['latestCheckIN'] == '-' || json['lastestCheckOut'] != '-',
      approve: json['approve'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latestCheckIN': clockInTime,
      'lastestCheckOut': clockOutTime,
      'startTime': shiftStartTime,
      'endTime': shiftEndTime,
      'timeType': timeType,
      'approve': approve,
    };
  }
}