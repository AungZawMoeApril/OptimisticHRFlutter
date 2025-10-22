abstract class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class BadRequestException extends ApiException {
  BadRequestException([String message = 'Bad Request']) : super(message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([String message = 'Unauthorized']) : super(message);
}

class ForbiddenException extends ApiException {
  ForbiddenException([String message = 'Forbidden']) : super(message);
}

class NotFoundException extends ApiException {
  NotFoundException([String message = 'Not Found']) : super(message);
}

class ConflictException extends ApiException {
  ConflictException([String message = 'Conflict']) : super(message);
}

class UnprocessableEntityException extends ApiException {
  UnprocessableEntityException([String message = 'Unprocessable Entity'])
      : super(message);
}

class ServerException extends ApiException {
  ServerException([String message = 'Server Error']) : super(message);
}

class TimeoutException extends ApiException {
  TimeoutException([String message = 'Connection Timeout']) : super(message);
}

class NetworkException extends ApiException {
  NetworkException([String message = 'Network Error']) : super(message);
}
