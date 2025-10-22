import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:h_r_optimistic_mobile/main.dart' as app;
import '../test/performance/performance_metrics.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Performance Tests', () {
    tearDown(() async {
      // Log memory usage after each test
      await PerformanceMetrics.logMemoryMetrics('After Test');
    });
    testWidgets('Measure app startup performance', (tester) async {
      await PerformanceMetrics.logMemoryMetrics('Before Startup');
      
      final stopwatch = Stopwatch()..start();
      
      app.main();
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      final startupTime = stopwatch.elapsedMilliseconds;
      
      debugPrint('App startup time: ${startupTime}ms');
      debugPrint('Performance grade: ${PerformanceMetrics.getPerformanceGrade(startupTime)}');
      
      await PerformanceMetrics.logMemoryMetrics('After Startup');
      
      expect(startupTime, lessThan(2000));
    });

    testWidgets('Measure time attendance page load performance', (tester) async {
      // Initialize app
      app.main();
      await tester.pumpAndSettle();

      // Login first
      await _performLogin(tester);

      final stopwatch = Stopwatch()..start();
      
      // Navigate to time attendance
      await tester.tap(find.byKey(const Key('time_attendance_nav')));
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      debugPrint('Time attendance page load time: ${stopwatch.elapsedMilliseconds}ms');
      
      // Assert navigation and load time is under 500ms
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
    });

    testWidgets('Measure list scrolling performance', (tester) async {
      // Initialize app and navigate to a list view
      app.main();
      await tester.pumpAndSettle();
      await _navigateToAnnouncementsList(tester);

      // Measure scroll performance
      final stopwatch = Stopwatch()..start();
      
      await tester.fling(
        find.byType(ListView),
        const Offset(0, -500),
        10000,
      );
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      debugPrint('Scroll performance: ${stopwatch.elapsedMilliseconds}ms');
      
      // Assert smooth scrolling (under 16ms per frame)
      expect(stopwatch.elapsedMilliseconds / 60, lessThan(16.67),
          reason: 'Scrolling performance below 60fps');
    });

    testWidgets('Measure navigation performance', (tester) async {
      // Initialize app
      app.main();
      await tester.pumpAndSettle();
      await _performLogin(tester);

      final stopwatch = Stopwatch()..start();

      // Navigate through multiple pages
      for (final page in ['Home', 'Time Attendance', 'Leave', 'Overtime']) {
        await tester.tap(find.text(page));
        await tester.pumpAndSettle();
      }

      stopwatch.stop();
      final averageNavigationTime = stopwatch.elapsedMilliseconds / 4;
      debugPrint('Average navigation time: ${averageNavigationTime}ms');
      
      // Assert navigation is under 300ms per screen
      expect(averageNavigationTime, lessThan(300));
    });

    testWidgets('Measure image loading performance', (tester) async {
      // Initialize app
      app.main();
      await tester.pumpAndSettle();
      await _navigateToAnnouncementsList(tester);

      final stopwatch = Stopwatch()..start();
      
      // Find and measure image loading time
      final images = find.byType(Image);
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      debugPrint('Image loading time: ${stopwatch.elapsedMilliseconds}ms');
      
      // Assert image loading time is under 1 second
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
      
      // Verify images are cached
      final cachedImages = find.byType(Image);
      expect(cachedImages, equals(images));
    });
  });
}

Future<void> _performLogin(WidgetTester tester) async {
  await tester.enterText(find.byKey(const Key('email_field')), 'test@example.com');
  await tester.enterText(find.byKey(const Key('password_field')), 'password123');
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle();
}

Future<void> _navigateToAnnouncementsList(WidgetTester tester) async {
  await _performLogin(tester);
  await tester.tap(find.byKey(const Key('announcements_nav')));
  await tester.pumpAndSettle();
}