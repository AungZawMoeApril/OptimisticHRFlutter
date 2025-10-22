import '../../domain/entities/auth.dart';

class AuthCredentialsModel extends AuthCredentials {
  const AuthCredentialsModel({
    required String companyId,
    required String employeeId,
    required String token,
    String? timeZoneOffset,
  }) : super(
          companyId: companyId,
          employeeId: employeeId,
          token: token,
          timeZoneOffset: timeZoneOffset,
        );

  factory AuthCredentialsModel.fromJson(Map<String, dynamic> json) {
    return AuthCredentialsModel(
      companyId: json['companyId'] as String,
      employeeId: json['employeeId'] as String,
      token: json['token'] as String,
      timeZoneOffset: json['timeZoneOffset'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'employeeId': employeeId,
      'token': token,
      'timeZoneOffset': timeZoneOffset,
    };
  }
}