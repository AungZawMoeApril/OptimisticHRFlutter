import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// User profile data model
@immutable
class Profile extends Equatable {
  final String firstName;
  final String lastName;
  final String position;
  final String department;
  final String email;
  final String phone;
  final String? imageUrl;

  const Profile({
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.department,
    required this.email,
    required this.phone,
    this.imageUrl,
  });

  String get fullName => '$firstName $lastName'.trim();

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        position,
        department,
        email,
        phone,
        imageUrl,
      ];

  Profile copyWith({
    String? firstName,
    String? lastName,
    String? position,
    String? department,
    String? email,
    String? phone,
    String? imageUrl,
  }) {
    return Profile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      position: position ?? this.position,
      department: department ?? this.department,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'position': position,
      'department': department,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      position: json['position'] as String,
      department: json['department'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}