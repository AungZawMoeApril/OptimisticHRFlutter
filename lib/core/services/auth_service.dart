import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../providers/app_state_provider.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';

  Future<void> initialize() async {
    // Initialize any auth-related services
    await _storage.read(key: _tokenKey);
  }

  Future<bool> login(String username, String password) async {
    try {
      // TODO: Implement actual login API call
      const mockToken = 'mock_token';
      const mockUserId = 'mock_user_id';

      // Store credentials securely
      await _storage.write(key: _tokenKey, value: mockToken);
      await _storage.write(key: _userIdKey, value: mockUserId);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }
}