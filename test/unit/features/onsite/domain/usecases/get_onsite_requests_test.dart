import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter/material.dart';
import 'package:h_r_optimistic_mobile/features/onsite/domain/entities/onsite_entities.dart';
import 'package:h_r_optimistic_mobile/features/onsite/domain/repositories/onsite_repository.dart';
import 'package:h_r_optimistic_mobile/features/onsite/domain/usecases/onsite_usecases.dart';

@GenerateNiceMocks([MockSpec<OnsiteRepository>()])
import 'get_onsite_requests_test.mocks.dart';

void main() {
  late MockOnsiteRepository mockRepository;
  late GetOnsiteRequests useCase;

  setUp(() {
    mockRepository = MockOnsiteRepository();
    useCase = GetOnsiteRequests(mockRepository);
  });

  final testEmployeeId = 'test_employee_id';
  final testRequests = [
    OnsiteRequest(
      id: '1',
      employeeId: testEmployeeId,
      startDate: DateTime(2025, 10, 14),
      endDate: DateTime(2025, 10, 14),
      startTime: const TimeOfDay(hour: 9, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 0),
      type: OnsiteType.client,
      location: 'Client Office',
      reason: 'Client Meeting',
      status: OnsiteStatus.pending,
      createdAt: DateTime(2025, 10, 13),
      updatedAt: DateTime(2025, 10, 13),
    ),
  ];

  test(
    'should get list of onsite requests for the employee',
    () async {
      // arrange
      when(mockRepository.getOnsiteRequests(testEmployeeId))
          .thenAnswer((_) async => testRequests);

      // act
      final result = await useCase(testEmployeeId);

      // assert
      expect(result, equals(testRequests));
      verify(mockRepository.getOnsiteRequests(testEmployeeId));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}