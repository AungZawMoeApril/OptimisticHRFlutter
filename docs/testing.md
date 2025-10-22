# Testing Guide

This document outlines the testing strategy and implementation for the HR Optimistic Flutter application.

## Test Types

### 1. Unit Tests
- Test individual components in isolation
- Focus on business logic and use cases
- Mock dependencies using `mockito`
- Test coverage targets: 80%

Coverage areas:
- ViewModels
- Repositories
- Use Cases
- Utilities
- Services

### 2. Widget Tests
- Test UI components and their interactions
- Verify widget behavior and state changes
- Test user interactions and input handling
- Test coverage targets: 70%

Coverage areas:
- Screens
- Custom Widgets
- Forms
- Dialogs
- Navigation

### 3. Integration Tests
- Test complete feature workflows
- Test API integration and data flow
- Test data persistence and caching
- Test coverage targets: Key user flows

Coverage areas:
- Authentication flow
- Announcement system
- Time attendance
- Leave management
- Onsite requests

### 4. Performance Tests
- Test app startup time (target: <2s)
- Test page load performance (<300ms)
- Test scrolling smoothness (60fps)
- Test navigation speed
- Test image loading and caching
- Test memory usage
- Test network efficiency

### 4. Performance Tests
- Test app startup time
- Test page load performance
- Test scrolling smoothness
- Test navigation speed
- Test image loading performance

Performance Benchmarks:
- App startup: < 2000ms
- Page navigation: < 300ms per screen
- List scrolling: 60fps (16.67ms/frame)
- Image loading: < 1000ms

## Test Structure

```
test/
├── unit/
│   ├── features/
│   │   ├── auth/
│   │   ├── leave/
│   │   ├── overtime/
│   │   └── onsite/
│   └── core/
├── widget/
│   └── features/
└── integration/
    └── features/
```

## Running Tests

1. **Unit Tests**
   ```bash
   flutter test test/unit
   ```

2. **Widget Tests**
   ```bash
   flutter test test/widget
   ```

3. **Integration Tests**
   ```bash
   flutter test test/integration
   ```

4. **All Tests**
   ```bash
   flutter test
   ```

## Writing Tests

### Unit Test Example
```dart
void main() {
  group('GetOnsiteRequests', () {
    late OnsiteRepository repository;
    late GetOnsiteRequests useCase;

    setUp(() {
      repository = MockOnsiteRepository();
      useCase = GetOnsiteRequests(repository);
    });

    test('should get onsite requests from repository', () async {
      // Arrange
      when(repository.getOnsiteRequests(any))
          .thenAnswer((_) async => []);

      // Act
      final result = await useCase('employee_id');

      // Assert
      expect(result, isA<List<OnsiteRequest>>());
      verify(repository.getOnsiteRequests('employee_id'));
    });
  });
}
```

### Widget Test Example
```dart
void main() {
  group('OnsiteScreen', () {
    testWidgets('displays list of onsite requests', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: OnsiteScreen(),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
```

## Best Practices

1. **Test Coverage**
   - Aim for high test coverage
   - Focus on critical business logic
   - Test edge cases and error scenarios

2. **Mocking**
   - Use `mockito` for mocking
   - Mock external dependencies
   - Mock API calls and database operations

3. **Test Organization**
   - Group related tests
   - Clear test descriptions
   - Follow AAA pattern (Arrange, Act, Assert)

4. **CI/CD Integration**
   - Run tests in CI pipeline
   - Enforce test coverage thresholds
   - Automate test execution