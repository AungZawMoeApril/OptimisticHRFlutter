import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:h_r_optimistic_mobile/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Time Attendance Flow Test', () {
    testWidgets('Complete attendance flow test', (tester) async {
      // Initialize the app
      app.main();
      await tester.pumpAndSettle();

      // Login flow (assuming we have a login page)
      await _login(tester);

      // Navigate to Time Attendance page
      await _navigateToTimeAttendance(tester);

      // Check In flow
      await _performCheckIn(tester);

      // Wait some time (simulating work day)
      await Future.delayed(const Duration(seconds: 2));

      // Check Out flow
      await _performCheckOut(tester);

      // Verify attendance record
      await _verifyAttendanceRecord(tester);
    });
  });
}

Future<void> _login(WidgetTester tester) async {
  // Find login fields
  final emailField = find.byKey(const Key('email_field'));
  final passwordField = find.byKey(const Key('password_field'));
  final loginButton = find.byKey(const Key('login_button'));

  // Enter credentials
  await tester.enterText(emailField, 'test@example.com');
  await tester.enterText(passwordField, 'password123');
  await tester.pumpAndSettle();

  // Tap login button
  await tester.tap(loginButton);
  await tester.pumpAndSettle();

  // Verify successful login
  expect(find.text('Home'), findsOneWidget);
}

Future<void> _navigateToTimeAttendance(WidgetTester tester) async {
  // Find and tap time attendance navigation item
  final timeAttendanceNav = find.byKey(const Key('time_attendance_nav'));
  await tester.tap(timeAttendanceNav);
  await tester.pumpAndSettle();

  // Verify navigation
  expect(find.text('Time Attendance'), findsOneWidget);
}

Future<void> _performCheckIn(WidgetTester tester) async {
  // Find check-in button
  final checkInButton = find.widgetWithText(ElevatedButton, 'Check In');
  expect(checkInButton, findsOneWidget);

  // Tap check-in button
  await tester.tap(checkInButton);
  await tester.pumpAndSettle();

  // Handle camera permission dialog if appears
  final permitButton = find.text('Allow');
  if (await tester.pumpAndSettle().then((_) => permitButton.evaluate().isNotEmpty)) {
    await tester.tap(permitButton);
    await tester.pumpAndSettle();
  }

  // Verify check-in success
  expect(find.text('Check-in successful'), findsOneWidget);
}

Future<void> _performCheckOut(WidgetTester tester) async {
  // Find check-out button
  final checkOutButton = find.widgetWithText(ElevatedButton, 'Check Out');
  expect(checkOutButton, findsOneWidget);

  // Tap check-out button
  await tester.tap(checkOutButton);
  await tester.pumpAndSettle();

  // Handle camera permission dialog if appears
  final permitButton = find.text('Allow');
  if (await tester.pumpAndSettle().then((_) => permitButton.evaluate().isNotEmpty)) {
    await tester.tap(permitButton);
    await tester.pumpAndSettle();
  }

  // Verify check-out success
  expect(find.text('Check-out successful'), findsOneWidget);
}

Future<void> _verifyAttendanceRecord(WidgetTester tester) async {
  // Verify attendance card shows both check-in and check-out times
  expect(find.text('Today\'s Attendance'), findsOneWidget);
  expect(find.text('Check In'), findsOneWidget);
  expect(find.text('Check Out'), findsOneWidget);
  
  // Verify status
  expect(find.text('PRESENT'), findsOneWidget);
}