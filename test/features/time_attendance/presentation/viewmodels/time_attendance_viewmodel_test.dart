import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:h_r_optimistic_mobile/core/error/failures.dart';
import 'package:h_r_optimistic_mobile/features/time_attendance/domain/repositories/time_attendance_repository.dart';
import 'package:h_r_optimistic_mobile/features/time_attendance/presentation/viewmodels/time_attendance_viewmodel.dart';
import 'package:h_r_optimistic_mobile/features/time_attendance/domain/entities/attendance_record.dart';

@GenerateNiceMocks([MockSpec<TimeAttendanceRepository>()])
import 'time_attendance_viewmodel_test.mocks.dart';

void main() {
  late TimeAttendanceViewModel viewModel;
  late MockTimeAttendanceRepository mockRepository;

  setUp(() {
    mockRepository = MockTimeAttendanceRepository();
    viewModel = TimeAttendanceViewModel(mockRepository);
  });

  group('TimeAttendanceViewModel Tests', () {
    final testUserId = 'test_user_id';
    final testAttendance = AttendanceRecord(
      id: '1',
      userId: testUserId,
      date: DateTime.now(),
      checkIn: DateTime.now(),
      status: 'PRESENT',
      createdAt: DateTime.now(),
    );

    test('loadTodayAttendance success should update attendance record', () async {
      // Arrange
      when(mockRepository.getTodayAttendance(testUserId))
          .thenAnswer((_) async => Right(testAttendance));

      // Act
      await viewModel.loadTodayAttendance(testUserId);

      // Assert
      expect(viewModel.todayAttendance, equals(testAttendance));
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.isBusy, isFalse);
      verify(mockRepository.getTodayAttendance(testUserId)).called(1);
    });

    test('loadTodayAttendance failure should set error message', () async {
      // Arrange
      final failure = ServerFailure();
      when(mockRepository.getTodayAttendance(testUserId))
          .thenAnswer((_) async => Left(failure));

      // Act
      await viewModel.loadTodayAttendance(testUserId);

      // Assert
      expect(viewModel.todayAttendance, isNull);
      expect(viewModel.errorMessage, equals(failure.message));
      expect(viewModel.isBusy, isFalse);
      verify(mockRepository.getTodayAttendance(testUserId)).called(1);
    });

    test('checkIn without location should show error', () async {
      // Arrange
      viewModel.currentPosition = null;

      // Act
      await viewModel.checkIn(testUserId);

      // Assert
      expect(viewModel.todayAttendance, isNull);
      expect(viewModel.errorMessage, 'Please enable location services and try again.');
      expect(viewModel.isBusy, isFalse);
    });

    test('should handle network failure', () async {
      // Arrange
      when(mockRepository.getTodayAttendance(testUserId))
          .thenAnswer((_) async => Left(NetworkFailure()));

      // Act
      await viewModel.loadTodayAttendance(testUserId);

      // Assert
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.isBusy, isFalse);
    });
  });
}