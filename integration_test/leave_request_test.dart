import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hr_app/main.dart' as app;
import 'package:hr_app/leave/leave_request/leave_request_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Leave Request Flow Test', () {
    testWidgets('Complete leave request flow', (tester) async {
      // Initialize the app
      app.main();
      await tester.pumpAndSettle();

      // Login (assuming we're starting from login screen)
      await _login(tester);

      // Navigate to leave request
      await _navigateToLeaveRequest(tester);

      // Fill leave request form
      await _fillLeaveRequestForm(tester);

      // Submit request and verify
      await _submitAndVerifyRequest(tester);
    });
  });
}

Future<void> _login(WidgetTester tester) async {
  // Find and fill login fields
  await tester.enterText(find.byKey(const Key('email_field')), 'test@example.com');
  await tester.enterText(find.byKey(const Key('password_field')), 'password123');
  
  // Tap login button
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle();
  
  // Verify we're on the home screen
  expect(find.text('Welcome'), findsOneWidget);
}

Future<void> _navigateToLeaveRequest(WidgetTester tester) async {
  // Open menu and navigate to leave request
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
  
  await tester.tap(find.text('Leave Request'));
  await tester.pumpAndSettle();
  
  // Verify we're on the leave request screen
  expect(find.byType(LeaveRequestWidget), findsOneWidget);
}

Future<void> _fillLeaveRequestForm(WidgetTester tester) async {
  // Select leave type
  await tester.tap(find.byKey(const Key('leave_type_dropdown')));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Annual Leave'));
  await tester.pumpAndSettle();

  // Select dates
  await tester.tap(find.byKey(const Key('start_date')));
  await tester.pumpAndSettle();
  // Select a date from the date picker
  await tester.tap(find.text('15'));
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();

  // Fill reason
  await tester.enterText(
    find.byKey(const Key('reason_field')),
    'Taking some time off for vacation',
  );
  await tester.pumpAndSettle();
}

Future<void> _submitAndVerifyRequest(WidgetTester tester) async {
  // Submit the request
  await tester.tap(find.text('Submit'));
  await tester.pumpAndSettle();

  // Verify success message
  expect(find.text('Leave request submitted successfully'), findsOneWidget);

  // Verify request appears in leave history
  await tester.tap(find.text('Leave History'));
  await tester.pumpAndSettle();
  
  expect(find.text('Annual Leave'), findsOneWidget);
  expect(find.text('Pending'), findsOneWidget);
}