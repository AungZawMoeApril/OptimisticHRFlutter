import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<AuthResponse> execute(String username, String password) {
    return _repository.login(
      AuthCredentials(username: username, password: password),
    );
  }
}

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> execute() {
    return _repository.logout();
  }
}

class RefreshTokenUseCase {
  final AuthRepository _repository;

  RefreshTokenUseCase(this._repository);

  Future<AuthResponse> execute(String token) {
    return _repository.refreshToken(token);
  }
}

class VerifyTokenUseCase {
  final AuthRepository _repository;

  VerifyTokenUseCase(this._repository);

  Future<bool> execute(String token) {
    return _repository.verifyToken(token);
  }
}