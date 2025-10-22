import '../../domain/entities/contact_staff.dart';

class ContactStaffModel extends ContactStaff {
  const ContactStaffModel({
    required String id,
    required String name,
    required String employeeId,
    required String position,
    required String department,
    required String email,
    required String phone,
    String? photoUrl,
  }) : super(
          id: id,
          name: name,
          employeeId: employeeId,
          position: position,
          department: department,
          email: email,
          phone: phone,
          photoUrl: photoUrl,
        );

  factory ContactStaffModel.fromJson(Map<String, dynamic> json) {
    return ContactStaffModel(
      id: json['id'] as String,
      name: json['name'] as String,
      employeeId: json['employeeId'] as String,
      position: json['position'] as String,
      department: json['department'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'employeeId': employeeId,
      'position': position,
      'department': department,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
    };
  }
}