import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:h_r_optimistic_mobile/features/time_attendance/presentation/pages/time_attendance_page.dart';
import 'package:h_r_optimistic_mobile/features/time_attendance/presentation/viewmodels/time_attendance_viewmodel.dart';
import 'package:h_r_optimistic_mobile/features/time_attendance/domain/entities/attendance_record.dart';
import '../viewmodels/time_attendance_viewmodel_test.mocks.dart';

void main() {
  late MockTimeAttendanceRepository mockRepository;
  late TimeAttendanceViewModel viewModel;

  setUp(() {
    mockRepository = MockTimeAttendanceRepository();
    viewModel = TimeAttendanceViewModel(mockRepository);
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: ChangeNotifierProvider<TimeAttendanceViewModel>.value(
        value: viewModel,
        child: const TimeAttendancePage(),
      ),
    );
  }

  group('TimeAttendancePage Widget Tests', () {
    testWidgets('should show loading indicator when busy',
        (WidgetTester tester) async {
      // Arrange
      viewModel.setBusy(true);

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message when error occurs',
        (WidgetTester tester) async {
      // Arrange
      const errorMessage = 'Test Error Message';
      viewModel.setError(errorMessage);

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('should show check-in button when no attendance record exists',
        (WidgetTester tester) async {
      // Arrange
      when(mockRepository.getTodayAttendance(any))
          .thenAnswer((_) async => const Right(null));

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.widgetWithText(ElevatedButton, 'Check In'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Check Out'), findsNothing);
    });

    testWidgets('should show check-out button after check-in',
        (WidgetTester tester) async {
      // Arrange
      final testAttendance = AttendanceRecord(
        id: '1',
        userId: 'test_user',
        date: DateTime.now(),
        checkIn: DateTime.now(),
        status: 'PRESENT',
        createdAt: DateTime.now(),
      );

      when(mockRepository.getTodayAttendance(any))
          .thenAnswer((_) async => Right(testAttendance));

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.widgetWithText(ElevatedButton, 'Check In'), findsNothing);
      expect(find.widgetWithText(ElevatedButton, 'Check Out'), findsOneWidget);
    });

    testWidgets('should handle check-in button tap', (WidgetTester tester) async {
      // Arrange
      when(mockRepository.getTodayAttendance(any))
          .thenAnswer((_) async => const Right(null));
      when(mockRepository.checkIn(
        userId: any,
        location: any,
        latitude: any,
        longitude: any,
      )).thenAnswer((_) async => Right(AttendanceRecord(
            id: '1',
            userId: 'test_user',
            date: DateTime.now(),
            checkIn: DateTime.now(),
            status: 'PRESENT',
            createdAt: DateTime.now(),
          )));

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();
      
      await tester.tap(find.widgetWithText(ElevatedButton, 'Check In'));
      await tester.pump();

      // Assert
      verify(mockRepository.checkIn(
        userId: any,
        location: any,
        latitude: any,
        longitude: any,
      )).called(1);
    });

    testWidgets('should refresh data on pull to refresh',
        (WidgetTester tester) async {
      // Arrange
      when(mockRepository.getTodayAttendance(any))
          .thenAnswer((_) async => const Right(null));

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      await tester.drag(find.byType(RefreshIndicator), const Offset(0, 300));
      await tester.pumpAndSettle();

      // Assert
      verify(mockRepository.getTodayAttendance(any)).called(2); // Initial + refresh
    });

    testWidgets('should show no record message when no attendance exists',
        (WidgetTester tester) async {
      // Arrange
      when(mockRepository.getTodayAttendance(any))
          .thenAnswer((_) async => const Right(null));

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.text('No attendance record for today'), findsOneWidget);
    });

    testWidgets('should show attendance details when record exists',
        (WidgetTester tester) async {
      // Arrange
      final now = DateTime.now();
      final testAttendance = AttendanceRecord(
        id: '1',
        userId: 'test_user',
        date: now,
        checkIn: now,
        status: 'PRESENT',
        createdAt: now,
      );

      when(mockRepository.getTodayAttendance(any))
          .thenAnswer((_) async => Right(testAttendance));

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.text('Today\'s Attendance'), findsOneWidget);
      expect(find.text('PRESENT'), findsOneWidget);
    });
  });
}