import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:h_r_optimistic_mobile/core/error/failures.dart';
import 'package:h_r_optimistic_mobile/features/overtime/domain/repositories/overtime_repository.dart';
import 'package:h_r_optimistic_mobile/features/overtime/presentation/viewmodels/overtime_viewmodel.dart';
import 'package:h_r_optimistic_mobile/features/overtime/domain/entities/overtime_request.dart';

@GenerateNiceMocks([MockSpec<OvertimeRepository>()])
import 'overtime_viewmodel_test.mocks.dart';

void main() {
  late OvertimeViewModel viewModel;
  late MockOvertimeRepository mockRepository;

  setUp(() {
    mockRepository = MockOvertimeRepository();
    viewModel = OvertimeViewModel(mockRepository);
  });

  group('OvertimeViewModel Tests', () {
    final testUserId = 'test_user_id';
    final testRequest = OvertimeRequest(
      id: '1',
      userId: testUserId,
      employeeName: 'Test User',
      requestDate: DateTime.now(),
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 2)),
      reason: 'Test reason',
      status: 'PENDING',
      createdAt: DateTime.now(),
    );

    test('loadOvertimeRequests success should update requests list', () async {
      // Arrange
      when(mockRepository.getOvertimeRequests(
        userId: testUserId,
        startDate: any,
        endDate: any,
      )).thenAnswer((_) async => Right([testRequest]));

      // Act
      await viewModel.loadOvertimeRequests(testUserId);

      // Assert
      expect(viewModel.overtimeRequests.length, equals(1));
      expect(viewModel.overtimeRequests.first, equals(testRequest));
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.isBusy, isFalse);
      verify(mockRepository.getOvertimeRequests(
        userId: testUserId,
        startDate: any,
        endDate: any,
      )).called(1);
    });

    test('loadOvertimeRequests failure should set error message', () async {
      // Arrange
      const errorMessage = 'Failed to load requests';
      when(mockRepository.getOvertimeRequests(
        userId: testUserId,
        startDate: any,
        endDate: any,
      )).thenAnswer((_) async => Left(ServerFailure(errorMessage)));

      // Act
      await viewModel.loadOvertimeRequests(testUserId);

      // Assert
      expect(viewModel.overtimeRequests, isEmpty);
      expect(viewModel.errorMessage, equals(errorMessage));
      expect(viewModel.isBusy, isFalse);
    });

    test('createOvertimeRequest success should add request to list', () async {
      // Arrange
      when(mockRepository.createOvertimeRequest(
        userId: testUserId,
        startTime: any,
        endTime: any,
        reason: 'Test reason',
      )).thenAnswer((_) async => Right(testRequest));

      // Act
      await viewModel.createOvertimeRequest(
        userId: testUserId,
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        reason: 'Test reason',
      );

      // Assert
      expect(viewModel.overtimeRequests.length, equals(1));
      expect(viewModel.overtimeRequests.first, equals(testRequest));
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.isBusy, isFalse);
    });

    test('deleteOvertimeRequest success should remove request from list', () async {
      // Arrange
      viewModel.overtimeRequests = [testRequest];
      when(mockRepository.deleteOvertimeRequest(testRequest.id))
          .thenAnswer((_) async => const Right(true));

      // Act
      await viewModel.deleteOvertimeRequest(testRequest.id);

      // Assert
      expect(viewModel.overtimeRequests, isEmpty);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.isBusy, isFalse);
    });

    test('updateDateRange should update selected dates', () {
      // Arrange
      final newStart = DateTime.now();
      final newEnd = DateTime.now().add(const Duration(days: 7));

      // Act
      viewModel.updateDateRange(newStart, newEnd);

      // Assert
      expect(viewModel.selectedStartDate, equals(newStart));
      expect(viewModel.selectedEndDate, equals(newEnd));
    });
  });
}