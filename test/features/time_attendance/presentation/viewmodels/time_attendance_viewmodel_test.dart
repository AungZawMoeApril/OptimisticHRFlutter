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

    group('Edge Cases -', () {
      test('should handle network timeout', () async {
        // Arrange
        when(mockRepository.getTodayAttendance(testUserId))
            .thenAnswer((_) async {
          await Future.delayed(const Duration(seconds: 31)); // Simulate timeout
          return Right(testAttendance);
        });

        // Act
        await viewModel.loadTodayAttendance(testUserId);

        // Assert
        expect(viewModel.errorMessage, contains('timeout'));
        expect(viewModel.isBusy, isFalse);
      });

      test('should handle concurrent check-in attempts', () async {
        // Arrange
        bool firstCall = true;
        when(mockRepository.checkIn(
          userId: testUserId,
          location: any,
          latitude: any,
          longitude: any,
        )).thenAnswer((_) async {
          if (firstCall) {
            firstCall = false;
            return Right(testAttendance);
          }
          return Left(ServerFailure('Duplicate check-in attempt'));
        });

        viewModel.currentPosition = MockPosition(1.0, 1.0);

        // Act
        final future1 = viewModel.checkIn(testUserId);
        final future2 = viewModel.checkIn(testUserId);

        // Assert
        await Future.wait([future1, future2]);
        verify(mockRepository.checkIn(
          userId: testUserId,
          location: any,
          latitude: any,
          longitude: any,
        )).called(2);
        expect(viewModel.errorMessage, contains('Duplicate'));
      });

      test('should handle offline mode', () async {
        // Arrange
        when(mockRepository.getTodayAttendance(testUserId))
            .thenAnswer((_) async => Left(NetworkFailure('No internet connection')));

        // Act
        await viewModel.loadTodayAttendance(testUserId);

        // Assert
        expect(viewModel.errorMessage, contains('internet'));
        expect(viewModel.isBusy, isFalse);
      });

      test('should handle invalid GPS coordinates', () async {
        // Arrange
        viewModel.currentPosition = MockPosition(91.0, 181.0); // Invalid coordinates

        // Act
        await viewModel.checkIn(testUserId);

        // Assert
        expect(viewModel.errorMessage, contains('Invalid location'));
        verifyNever(mockRepository.checkIn(
          userId: any,
          location: any,
          latitude: any,
          longitude: any,
        ));
      });

      test('should handle rapid consecutive requests', () async {
        // Arrange
        int callCount = 0;
        when(mockRepository.getTodayAttendance(testUserId))
            .thenAnswer((_) async {
          callCount++;
          await Future.delayed(const Duration(milliseconds: 100));
          return Right(testAttendance.copyWith(id: callCount.toString()));
        });

        // Act
        final futures = List.generate(
          5,
          (_) => viewModel.loadTodayAttendance(testUserId),
        );
        await Future.wait(futures);

        // Assert
        verify(mockRepository.getTodayAttendance(testUserId)).called(5);
        expect(viewModel.todayAttendance?.id, equals('5')); // Last request wins
      });
    });

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
      final failure = ServerFailure('Failed to load attendance');
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

    test('checkIn success should update attendance record', () async {
      // Arrange
      const location = 'Test Location';
      const latitude = 1.0;
      const longitude = 1.0;

      when(mockRepository.checkIn(
        userId: testUserId,
        location: location,
        latitude: latitude,
        longitude: longitude,
        checkInImage: null,
      )).thenAnswer((_) async => Right(testAttendance));

      // Act
      viewModel.currentPosition = MockPosition(latitude, longitude);
      await viewModel.checkIn(testUserId);

      // Assert
      expect(viewModel.todayAttendance, equals(testAttendance));
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.isBusy, isFalse);
      verify(mockRepository.checkIn(
        userId: testUserId,
        location: anyNamed('location'),
        latitude: latitude,
        longitude: longitude,
        checkInImage: null,
      )).called(1);
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
      verifyNever(mockRepository.checkIn(
        userId: anyNamed('userId'),
        location: anyNamed('location'),
        latitude: anyNamed('latitude'),
        longitude: anyNamed('longitude'),
      ));
    });
  });
}

class MockPosition {
  final double latitude;
  final double longitude;

  MockPosition(this.latitude, this.longitude);
}