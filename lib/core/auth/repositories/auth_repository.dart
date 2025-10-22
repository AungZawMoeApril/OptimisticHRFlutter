import '../models/token_pair.dart';

abstract class IAuthRepository {
  /// Get the current token pair from storage
  Future<TokenPair?> getTokens();

  /// Save token pair to storage
  Future<void> saveTokens(TokenPair tokens);

  /// Clear stored tokens
  Future<void> clearTokens();

  /// Refresh the access token using the refresh token
  Future<TokenPair> refreshTokens(String refreshToken);

  /// Check if the current tokens exist and are valid
  Future<bool> hasValidTokens();
}