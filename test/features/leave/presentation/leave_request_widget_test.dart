import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/app_state.dart';
import 'package:hr_app/core/theme/theme_extensions.dart';
import 'package:hr_app/leave/leave_request/leave_request_widget.dart';

class MockAppState extends Mock implements AppState {
  @override
  String get companyID => '1';
  
  @override
  String get employeeID => '1';
  
  @override
  String get token => 'test_token';
}

void main() {
  late MockAppState mockAppState;

  setUp(() {
    mockAppState = MockAppState();
  });

  testWidgets('LeaveRequestWidget UI elements test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AppState>.value(value: mockAppState),
        ],
        child: MaterialApp(
          home: LeaveRequestWidget(),
          theme: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Color(0xFFF89D27),
              secondary: Color(0xFF58585A),
              background: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF58585A),
              onSurfaceVariant: Color(0xFF58585A),
            ),
          ),
        ),
      ),
    );

    // Verify that initial UI elements are rendered
    expect(find.text('Leave Request'), findsOneWidget);
    expect(find.text('All Day'), findsOneWidget);
    expect(find.text('Half Day'), findsOneWidget);

    // Test tapping the Half Day button
    await tester.tap(find.text('Half Day'));
    await tester.pumpAndSettle();

    // Verify that date/time pickers become visible
    expect(find.text('Date'), findsOneWidget);
    expect(find.text('Start Time'), findsOneWidget);
    expect(find.text('End Time'), findsOneWidget);

    // Test tapping the All Day button
    await tester.tap(find.text('All Day'));
    await tester.pumpAndSettle();

    // Verify that start/end date fields become visible
    expect(find.text('Start Date'), findsOneWidget);
    expect(find.text('End Date'), findsOneWidget);
  });

  testWidgets('Leave Request date and time selection test',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AppState>.value(value: mockAppState),
        ],
        child: MaterialApp(
          home: LeaveRequestWidget(),
          theme: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Color(0xFFF89D27),
              secondary: Color(0xFF58585A),
              background: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF58585A),
              onSurfaceVariant: Color(0xFF58585A),
            ),
          ),
        ),
      ),
    );

    // Test opening the date picker
    await tester.tap(find.byIcon(Icons.calendar_month).first);
    await tester.pumpAndSettle();
    
    // Verify date picker is shown
    expect(find.byType(DatePickerDialog), findsOneWidget);

    // Close the date picker by tapping outside
    await tester.tapAt(const Offset(0, 0));
    await tester.pumpAndSettle();

    // Switch to half day mode
    await tester.tap(find.text('Half Day'));
    await tester.pumpAndSettle();

    // Test opening the time picker
    await tester.tap(find.byIcon(Icons.alarm).first);
    await tester.pumpAndSettle();

    // Verify time picker is shown
    expect(find.byType(TimePickerDialog), findsOneWidget);
  });
}