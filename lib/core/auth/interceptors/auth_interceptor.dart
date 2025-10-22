import 'dart:io';
import 'package:dio/dio.dart';
import '../repositories/auth_repository.dart';

class AuthInterceptor extends QueuedInterceptor {
  final IAuthRepository _authRepository;
  final Dio _dio;
  bool _isRefreshing = false;
  final _queue = <QueuedRequest>[];

  AuthInterceptor(this._authRepository, this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth header for refresh token requests
    if (options.path.contains('/auth/refresh')) {
      return handler.next(options);
    }

    try {
      final tokens = await _authRepository.getTokens();
      if (tokens == null) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'No authentication tokens found',
            type: DioExceptionType.unknown,
          ),
        );
      }

      // Check if token needs refresh
      if (tokens.isExpired) {
        final request = QueuedRequest(options, RequestHandlerWrapper(handler));
        await _queueRequest(request);
        return;
      }

      // Add auth header
      options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
      return handler.next(options);
    } catch (e) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: e.toString(),
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final options = err.requestOptions;

    // If error is not 401 or is a refresh token request, continue with error
    if (statusCode != 401 || options.path.contains('/auth/refresh')) {
      return handler.next(err);
    }

    // Queue failed request
    final request = QueuedRequest(options, handler as Handler);
    await _queueRequest(request);
  }

  Future<void> _queueRequest(QueuedRequest request) async {
    _queue.add(request);
    
    if (!_isRefreshing) {
      await _refreshTokenAndProcessQueue();
    }
  }

  Future<void> _refreshTokenAndProcessQueue() async {
    _isRefreshing = true;

    try {
      final oldTokens = await _authRepository.getTokens();
      if (oldTokens == null) {
        _rejectQueue('No refresh token available');
        return;
      }

      // Refresh tokens
      await _authRepository.refreshTokens(oldTokens.refreshToken);

      // Process queued requests
      await _processQueue();
    } catch (e) {
      _rejectQueue('Token refresh failed: $e');
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _processQueue() async {
    final tokens = await _authRepository.getTokens();
    if (tokens == null) {
      _rejectQueue('No tokens available after refresh');
      return;
    }

    // Copy and clear queue
    final requests = List<QueuedRequest>.from(_queue);
    _queue.clear();

    // Process each request
    for (var request in requests) {
      try {
        request.options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
        final response = await _dio.fetch(request.options);
        request.handler.resolve(response);
      } catch (e) {
        request.handler.reject(
          DioException(
            requestOptions: request.options,
            error: e.toString(),
            type: DioExceptionType.unknown,
          ),
        );
      }
    }
  }

  void _rejectQueue(String message) {
    final requests = List<QueuedRequest>.from(_queue);
    _queue.clear();

    for (var request in requests) {
      request.handler.reject(
        DioException(
          requestOptions: request.options,
          error: message,
          type: DioExceptionType.unknown,
        ),
      );
    }
  }
}

class QueuedRequest {
  final RequestOptions options;
  final Handler handler;

  QueuedRequest(this.options, this.handler);
}

abstract class Handler {
  void reject(DioException err);
  void resolve(Response response);
}

class RequestHandlerWrapper implements Handler {
  final RequestInterceptorHandler handler;
  RequestHandlerWrapper(this.handler);

  @override
  void reject(DioException err) => handler.reject(err);
  
  @override
  void resolve(Response response) => handler.resolve(response);
}

class ErrorHandlerWrapper implements Handler {
  final ErrorInterceptorHandler handler;
  ErrorHandlerWrapper(this.handler);

  @override
  void reject(DioException err) => handler.next(err);
  
  @override
  void resolve(Response response) => handler.resolve(response);
}