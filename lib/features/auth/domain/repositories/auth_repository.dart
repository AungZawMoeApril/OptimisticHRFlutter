import 'package:dartz/dartz.dart';
import '../entities/auth.dart';

abstract class AuthRepository {
  Future<Either<String, AuthCredentials>> login(String username, String password);
  Future<Either<String, bool>> verifyPinCode(String pinCode);
  Future<Either<String, bool>> createPinCode(String pinCode);
  Future<Either<String, void>> logout();
  Future<Either<String, AuthStatus>> checkAuthStatus();
  Future<Either<String, AuthCredentials>> refreshToken(String token);
  Future<Either<String, void>> saveAuthCredentials(AuthCredentials credentials);
}