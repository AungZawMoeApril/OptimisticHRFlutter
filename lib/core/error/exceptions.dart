/// Exception thrown when there is a failure with the server.
class ServerException implements Exception {
  final String? message;
  ServerException([this.message]);
}

/// Exception thrown when there is a failure with network connectivity.
class NetworkException implements Exception {
  final String? message;
  NetworkException([this.message]);
}

/// Exception thrown when there is a cache operation failure.
class CacheException implements Exception {
  final String? message;
  CacheException([this.message]);
}

/// Exception thrown when there is an authentication failure.
class AuthenticationException implements Exception {
  final String? message;
  AuthenticationException([this.message]);
}

/// Exception thrown when there is a validation failure.
class ValidationException implements Exception {
  final String? message;
  ValidationException([this.message]);
}

/// Exception thrown when a resource is not found.
class NotFoundException implements Exception {
  final String? message;
  NotFoundException([this.message]);
}