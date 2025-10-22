import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_model.dart';
import '../../../../backend/api_requests/api_calls.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final storage = const FlutterSecureStorage();

  AuthRepositoryImpl({
    required this.dio,
  });

  @override
  Future<Either<String, AuthCredentials>> login(String username, String password) async {
    try {
      final result = await MainGroup.loginCall.call(
        username: username,
        password: password,
      );

      if (result.succeeded && MainGroup.loginCall.status(result.jsonBody) == 0) {
        final credentials = AuthCredentialsModel(
          companyId: MainGroup.loginCall.companyId(result.jsonBody)!,
          employeeId: MainGroup.loginCall.employeeId(result.jsonBody)!,
          token: MainGroup.loginCall.token(result.jsonBody)!,
          timeZoneOffset: DateTime.now().timeZoneOffset.inHours.toString(),
        );

        await saveAuthCredentials(credentials);
        return Right(credentials);
      } else {
        return Left(MainGroup.loginCall.message(result.jsonBody) ?? 'Login failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> verifyPinCode(String pinCode) async {
    try {
      final storedPinCode = await storage.read(key: 'pin_code');
      return Right(storedPinCode == pinCode);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> createPinCode(String pinCode) async {
    try {
      await storage.write(key: 'pin_code', value: pinCode);
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      await storage.deleteAll();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AuthStatus>> checkAuthStatus() async {
    try {
      final token = await storage.read(key: 'token');
      final pinCode = await storage.read(key: 'pin_code');

      if (token == null) {
        return Right(AuthStatus());
      }

      final result = await MainGroup.tokenValidationCall.call(token: token);

      if (result.succeeded && MainGroup.tokenValidationCall.status(result.jsonBody) == 0) {
        return Right(AuthStatus(
          isAuthenticated: true,
          isPinCodeVerified: pinCode != null,
        ));
      } else {
        return Right(AuthStatus());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AuthCredentials>> refreshToken(String token) async {
    try {
      final result = await MainGroup.tokenRefreshCall.call(token: token);

      if (result.succeeded && MainGroup.tokenRefreshCall.status(result.jsonBody) == 0) {
        final credentials = AuthCredentialsModel(
          companyId: MainGroup.tokenRefreshCall.companyId(result.jsonBody)!,
          employeeId: MainGroup.tokenRefreshCall.employeeId(result.jsonBody)!,
          token: MainGroup.tokenRefreshCall.newToken(result.jsonBody)!,
          timeZoneOffset: DateTime.now().timeZoneOffset.inHours.toString(),
        );

        await saveAuthCredentials(credentials);
        return Right(credentials);
      } else {
        return Left(MainGroup.tokenRefreshCall.message(result.jsonBody) ?? 'Token refresh failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> saveAuthCredentials(AuthCredentials credentials) async {
    try {
      await storage.write(key: 'token', value: credentials.token);
      await storage.write(key: 'company_id', value: credentials.companyId);
      await storage.write(key: 'employee_id', value: credentials.employeeId);
      await storage.write(key: 'timezone_offset', value: credentials.timeZoneOffset);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
  }
}