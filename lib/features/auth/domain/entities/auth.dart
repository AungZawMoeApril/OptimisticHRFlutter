import 'package:equatable/equatable.dart';

class AuthCredentials extends Equatable {
  final String companyId;
  final String employeeId;
  final String token;
  final String? timeZoneOffset;

  const AuthCredentials({
    required this.companyId,
    required this.employeeId,
    required this.token,
    this.timeZoneOffset,
  });

  @override
  List<Object?> get props => [companyId, employeeId, token, timeZoneOffset];
}

class AuthStatus extends Equatable {
  final bool isAuthenticated;
  final bool isPinCodeVerified;
  final String? error;

  const AuthStatus({
    this.isAuthenticated = false,
    this.isPinCodeVerified = false,
    this.error,
  });

  AuthStatus copyWith({
    bool? isAuthenticated,
    bool? isPinCodeVerified,
    String? error,
  }) {
    return AuthStatus(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isPinCodeVerified: isPinCodeVerified ?? this.isPinCodeVerified,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, isPinCodeVerified, error];
}