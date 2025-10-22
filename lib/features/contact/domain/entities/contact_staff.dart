import 'package:equatable/equatable.dart';

class ContactStaff extends Equatable {
  final String id;
  final String name;
  final String employeeId;
  final String position;
  final String department;
  final String email;
  final String phone;
  final String? photoUrl;

  const ContactStaff({
    required this.id,
    required this.name,
    required this.employeeId,
    required this.position,
    required this.department,
    required this.email,
    required this.phone,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        employeeId,
        position,
        department,
        email,
        phone,
        photoUrl,
      ];
}