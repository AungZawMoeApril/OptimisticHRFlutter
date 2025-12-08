import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get message;

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  @override
  String get message => 'Server error occurred. Please try again.';
}

class CacheFailure extends Failure {
  @override
  String get message => 'Failed to load data from cache.';
}

class NetworkFailure extends Failure {
  @override
  String get message => 'No internet connection. Please check your network.';
}

class UnauthorizedFailure extends Failure {
  @override
  String get message => 'Unauthorized access. Please login again.';
}

class ValidationFailure extends Failure {
  final String _message;

  ValidationFailure(this._message);

  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}
