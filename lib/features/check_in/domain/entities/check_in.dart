class CheckIn {
  final String id;
  final DateTime checkInTime;
  final String location;
  final String userId;
  final String status;

  CheckIn({
    required this.id,
    required this.checkInTime,
    required this.location,
    required this.userId,
    required this.status,
  });
}