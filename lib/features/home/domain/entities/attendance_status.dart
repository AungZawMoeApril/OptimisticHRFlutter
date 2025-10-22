class AttendanceStatus {
  final String clockInTime;
  final String clockOutTime;
  final String shiftStartTime;
  final String shiftEndTime;
  final String timeType;
  final bool canCheckIn;
  final bool approve;

  AttendanceStatus({
    required this.clockInTime,
    required this.clockOutTime,
    required this.shiftStartTime,
    required this.shiftEndTime,
    required this.timeType,
    required this.canCheckIn,
    required this.approve,
  });
}