class CheckOut {
  final String id;
  final DateTime checkOutTime;
  final String location;
  final String userId;
  final String status;

  CheckOut({
    required this.id,
    required this.checkOutTime,
    required this.location,
    required this.userId,
    required this.status,
  });
}