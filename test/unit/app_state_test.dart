import 'package:flutter_test/flutter_test.dart';
import 'package:hr_app/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AppState Tests', () {
    late AppState appState;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      appState = AppState();
      await appState.initializeApp();
    });

    test('Initial state is correct', () {
      expect(appState.isLoggedIn, false);
      expect(appState.employeeID, 0);
      expect(appState.token, isEmpty);
      expect(appState.locale, isNotNull);
    });

    test('Login updates state correctly', () async {
      await appState.login(
        employeeId: 123,
        token: 'test-token',
        name: 'Test User',
        email: 'test@example.com',
      );

      expect(appState.isLoggedIn, true);
      expect(appState.employeeID, 123);
      expect(appState.token, 'test-token');
      expect(appState.userName, 'Test User');
      expect(appState.userEmail, 'test@example.com');
    });

    test('Logout clears state correctly', () async {
      // First login
      await appState.login(
        employeeId: 123,
        token: 'test-token',
        name: 'Test User',
        email: 'test@example.com',
      );

      // Then logout
      await appState.logout();

      expect(appState.isLoggedIn, false);
      expect(appState.employeeID, 0);
      expect(appState.token, isEmpty);
      expect(appState.userName, isEmpty);
      expect(appState.userEmail, isEmpty);
    });

    test('Update locale changes language correctly', () async {
      await appState.updateLocale('my');
      expect(appState.locale.languageCode, 'my');

      await appState.updateLocale('en');
      expect(appState.locale.languageCode, 'en');
    });

    test('Update theme changes theme mode correctly', () {
      appState.updateThemeMode(isDark: true);
      expect(appState.isDarkMode, true);

      appState.updateThemeMode(isDark: false);
      expect(appState.isDarkMode, false);
    });

    test('State persists after app restart', () async {
      // Login and set some state
      await appState.login(
        employeeId: 123,
        token: 'test-token',
        name: 'Test User',
        email: 'test@example.com',
      );
      await appState.updateLocale('my');
      appState.updateThemeMode(isDark: true);

      // Create new instance to simulate app restart
      final newAppState = AppState();
      await newAppState.initializeApp();

      // Verify state is restored
      expect(newAppState.isLoggedIn, true);
      expect(newAppState.employeeID, 123);
      expect(newAppState.token, 'test-token');
      expect(newAppState.userName, 'Test User');
      expect(newAppState.userEmail, 'test@example.com');
      expect(newAppState.locale.languageCode, 'my');
      expect(newAppState.isDarkMode, true);
    });
  });
}