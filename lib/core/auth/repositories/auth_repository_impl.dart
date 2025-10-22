import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/token_pair.dart';
import 'auth_repository.dart';
import '../../storage/storage_service.dart';
import '../../storage/boxes.dart';
import '../../network/api_client.dart';

class AuthRepository implements IAuthRepository {
  final IStorageService _storage;
  final ApiClient _apiClient;
  static const String _tokenKey = 'auth_tokens';

  AuthRepository(this._storage, this._apiClient);

  @override
  Future<TokenPair?> getTokens() async {
    try {
      final tokensJson = await _storage.getValue<String>(Boxes.auth, _tokenKey);
      if (tokensJson == null) return null;
      
      return TokenPair.fromJson(json.decode(tokensJson));
    } catch (e) {
      print('Error getting tokens: $e');
      return null;
    }
  }

  @override
  Future<void> saveTokens(TokenPair tokens) async {
    try {
      await _storage.setValue(
        Boxes.auth,
        _tokenKey,
        json.encode(tokens.toJson()),
      );
    } catch (e) {
      print('Error saving tokens: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearTokens() async {
    try {
      await _storage.removeValue(Boxes.auth, _tokenKey);
    } catch (e) {
      print('Error clearing tokens: $e');
      rethrow;
    }
  }

  @override
  Future<TokenPair> refreshTokens(String refreshToken) async {
    try {
      final response = await _apiClient.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final tokens = TokenPair(
        accessToken: response.data['accessToken'],
        refreshToken: response.data['refreshToken'],
        expiresAt: DateTime.now().add(
          Duration(seconds: response.data['expiresIn']),
        ),
      );

      await saveTokens(tokens);
      return tokens;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await clearTokens();
      }
      rethrow;
    } catch (e) {
      print('Error refreshing tokens: $e');
      rethrow;
    }
  }

  @override
  Future<bool> hasValidTokens() async {
    try {
      final tokens = await getTokens();
      if (tokens == null) return false;
      
      // If token is expired or will expire in next 5 minutes
      final expirationBuffer = DateTime.now().add(Duration(minutes: 5));
      return expirationBuffer.isBefore(tokens.expiresAt);
    } catch (e) {
      print('Error checking token validity: $e');
      return false;
    }
  }
}