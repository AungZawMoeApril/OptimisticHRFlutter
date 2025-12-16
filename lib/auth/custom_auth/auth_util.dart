import '/backend/schema/structs/index.dart';
import 'custom_auth_manager.dart';

export 'custom_auth_manager.dart';

final _authManager = CustomAuthManager();
CustomAuthManager get authManager => _authManager;

String get currentUserUid => authManager.currentUser?.uid ?? '';
String? get currentAuthenticationToken => authManager.currentUser?.uid; // Stub - use uid as token
String? get currentAuthRefreshToken => authManager.currentUser?.uid; // Stub
DateTime? get currentAuthTokenExpiration => DateTime.now().add(const Duration(days: 1)); // Stub
UserStruct? get currentUserData => authManager.currentUser?.userData;
