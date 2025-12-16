import 'package:dartz/dartz.dart';
import '../entities/auth.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<String, AuthCredentials>> execute(String username, String password) {
    return _repository.login(username, password);
  }
}

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<String, void>> execute() {
    return _repository.logout();
  }
}

class RefreshTokenUseCase {
  final AuthRepository _repository;

  RefreshTokenUseCase(this._repository);

  Future<Either<String, AuthCredentials>> execute(String token) {
    return _repository.refreshToken(token);
  }
}

class VerifyTokenUseCase {
  final AuthRepository _repository;

  VerifyTokenUseCase(this._repository);

  Future<Either<String, AuthStatus>> execute() {
    return _repository.checkAuthStatus();
  }
}
