import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:h_r_optimistic_mobile/features/onsite/data/repositories/onsite_repository_impl.dart';
import 'package:h_r_optimistic_mobile/features/onsite/data/datasources/onsite_local_data_source.dart';
import 'package:h_r_optimistic_mobile/features/onsite/domain/entities/onsite_entities.dart';
import 'package:h_r_optimistic_mobile/core/network/api_endpoints.dart';
import 'package:h_r_optimistic_mobile/core/error/exceptions.dart';
import 'package:h_r_optimistic_mobile/core/network/network_info.dart';

@GenerateNiceMocks([
  MockSpec<http.Client>(),
  MockSpec<NetworkInfo>(),
  MockSpec<OnsiteLocalDataSource>(),
])
import 'onsite_repository_impl_test.mocks.dart';

void main() {
  late OnsiteRepositoryImpl repository;
  late MockClient mockHttpClient;
  late MockNetworkInfo mockNetworkInfo;
  late MockOnsiteLocalDataSource mockLocalDataSource;

  setUp(() {
    mockHttpClient = MockClient();
    mockNetworkInfo = MockNetworkInfo();
    mockLocalDataSource = MockOnsiteLocalDataSource();
    repository = OnsiteRepositoryImpl(
      client: mockHttpClient,
      networkInfo: mockNetworkInfo,
      localDataSource: mockLocalDataSource,
    );
  });

  group('getOnsiteRequests', () {
    final testEmployeeId = 'test_employee_id';
    final testUrl = '${ApiEndpoints.baseUrl}${ApiEndpoints.onsiteByEmployee.replaceAll('{employeeId}', testEmployeeId)}';

    test('should return list of onsite requests when response is successful', () async {
      // arrange
      const testJsonResponse = '''
      [
        {
          "id": "1",
          "employeeId": "test_employee_id",
          "startDate": "2025-10-14T00:00:00.000Z",
          "endDate": "2025-10-14T00:00:00.000Z",
          "startTime": "09:00",
          "endTime": "17:00",
          "type": "client",
          "location": "Client Office",
          "reason": "Client Meeting",
          "status": "pending",
          "createdAt": "2025-10-13T00:00:00.000Z",
          "updatedAt": "2025-10-13T00:00:00.000Z"
        }
      ]
      ''';

      when(mockHttpClient.get(Uri.parse(testUrl)))
          .thenAnswer((_) async => http.Response(testJsonResponse, 200));

      // act
      final result = await repository.getOnsiteRequests(testEmployeeId);

      // assert
      expect(result, isA<List<OnsiteRequest>>());
      expect(result.length, 1);
      expect(result[0].id, '1');
      expect(result[0].location, 'Client Office');
      verify(mockHttpClient.get(Uri.parse(testUrl)));
    });

    test('should throw ServerException when response is not successful', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(testUrl)))
          .thenAnswer((_) async => http.Response('Error', 404));

      // act
      final call = repository.getOnsiteRequests;

      // assert
      expect(() => call(testEmployeeId), throwsA(isA<ServerException>()));
    });
  });
}