import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hr_app/core/widgets/app_button.dart';

void main() {
  group('AppButton Widget Tests', () {
    testWidgets('AppButton renders correctly with primary style', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Test Button',
              onPressed: () {},
              type: AppButtonType.primary,
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(AppButton);
      expect(buttonFinder, findsOneWidget);

      final textFinder = find.text('Test Button');
      expect(textFinder, findsOneWidget);

      final button = tester.widget<AppButton>(buttonFinder);
      expect(button.type, AppButtonType.primary);
      expect(button.onPressed, isNotNull);
    });

    testWidgets('AppButton handles disabled state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Disabled Button',
              onPressed: null,
              type: AppButtonType.primary,
            ),
          ),
        ),
      );

      final button = tester.widget<AppButton>(find.byType(AppButton));
      expect(button.onPressed, isNull);

      // Verify button is rendered with disabled style
      final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(elevatedButton.enabled, isFalse);
    });

    testWidgets('AppButton handles tap events correctly', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Tap Me',
              onPressed: () {
                wasPressed = true;
              },
              type: AppButtonType.primary,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      expect(wasPressed, isTrue);
    });

    testWidgets('AppButton renders with different types correctly', (WidgetTester tester) async {
      for (final type in AppButtonType.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Button',
                onPressed: () {},
                type: type,
              ),
            ),
          ),
        );

        final button = tester.widget<AppButton>(find.byType(AppButton));
        expect(button.type, type);
      }
    });
  });
}