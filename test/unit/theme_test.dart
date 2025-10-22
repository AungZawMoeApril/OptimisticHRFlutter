import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hr_app/core/theme/app_theme.dart';

void main() {
  group('AppTheme Tests', () {
    test('Light theme should have correct color scheme', () {
      final lightTheme = AppTheme.light();
      
      expect(lightTheme.colorScheme.primary, const Color(0xFF2196F3));
      expect(lightTheme.colorScheme.secondary, const Color(0xFF64B5F6));
      expect(lightTheme.colorScheme.surface, const Color(0xFFF5F5F5));
      expect(lightTheme.colorScheme.background, Colors.white);
      expect(lightTheme.colorScheme.error, const Color(0xFFD32F2F));
    });

    test('Dark theme should have correct color scheme', () {
      final darkTheme = AppTheme.dark();
      
      expect(darkTheme.colorScheme.primary, const Color(0xFF90CAF9));
      expect(darkTheme.colorScheme.secondary, const Color(0xFF64B5F6));
      expect(darkTheme.colorScheme.surface, const Color(0xFF1E1E1E));
      expect(darkTheme.colorScheme.background, const Color(0xFF121212));
      expect(darkTheme.colorScheme.error, const Color(0xFFEF5350));
    });

    test('Typography should be consistent across themes', () {
      final lightTheme = AppTheme.light();
      final darkTheme = AppTheme.dark();

      expect(lightTheme.textTheme.bodyLarge?.fontSize, darkTheme.textTheme.bodyLarge?.fontSize);
      expect(lightTheme.textTheme.titleMedium?.fontSize, darkTheme.textTheme.titleMedium?.fontSize);
      expect(lightTheme.textTheme.labelLarge?.fontSize, darkTheme.textTheme.labelLarge?.fontSize);
    });

    test('Button themes should have correct properties', () {
      final lightTheme = AppTheme.light();
      final elevatedButtonTheme = lightTheme.elevatedButtonTheme;

      final style = elevatedButtonTheme.style?.resolve({});
      expect(style?.backgroundColor?.resolve({}), const Color(0xFFF9B052));
      expect(style?.elevation?.resolve({}), 3.0);
      expect(
        style?.shape?.resolve({}) as RoundedRectangleBorder?,
        isA<RoundedRectangleBorder>().having(
          (s) => s.borderRadius,
          'borderRadius',
          BorderRadius.circular(8.0),
        ),
      );
    });
  });
}