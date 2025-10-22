import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'onsite_screen_test.mocks.dart';
import 'package:h_r_optimistic_mobile/features/onsite/domain/entities/onsite_entities.dart';
import 'package:h_r_optimistic_mobile/features/onsite/presentation/providers/onsite_provider.dart';
import 'package:h_r_optimistic_mobile/features/onsite/presentation/screens/onsite_screen.dart';
import 'package:provider/provider.dart';

@GenerateMocks([OnsiteProvider])
void main() {
  late MockOnsiteProvider mockProvider;

  setUp(() {
    mockProvider = MockOnsiteProvider();
  });

  testWidgets('OnsiteScreen shows loading indicator when loading', (WidgetTester tester) async {
    // Arrange
    when(mockProvider.isLoading).thenAnswer((_) => true);
    when(mockProvider.onsiteRequests).thenAnswer((_) => []);

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<OnsiteProvider>.value(
          value: mockProvider,
          child: const OnsiteScreen(),
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    verify(mockProvider.isLoading).called(greaterThan(0));
  });

  testWidgets('OnsiteScreen shows list of requests when not loading', (WidgetTester tester) async {
    // Arrange
    final testRequests = [
      OnsiteRequest(
        id: '1',
        employeeId: 'emp1',
        startDate: DateTime(2025, 10, 21),
        endDate: DateTime(2025, 10, 21),
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
        type: OnsiteType.client,
        location: 'Client Office',
        reason: 'Meeting',
        status: OnsiteStatus.pending,
        createdAt: DateTime(2025, 10, 21),
        updatedAt: DateTime(2025, 10, 21),
      ),
    ];

    when(mockProvider.isLoading).thenAnswer((_) => false);
    when(mockProvider.onsiteRequests).thenAnswer((_) => testRequests);

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<OnsiteProvider>.value(
          value: mockProvider,
          child: const OnsiteScreen(),
        ),
      ),
    );

    // Assert
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Client Office'), findsOneWidget);
    expect(find.text('Meeting'), findsOneWidget);
  });
}