import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hr_app/core/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  group('AppLocalizations Tests', () {
    testWidgets('Localization delegates are properly configured', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(),
        ),
      );

      final context = tester.element(find.byType(Scaffold));
      expect(AppLocalizations.of(context), isNotNull);
    });

    testWidgets('English translations are loaded correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Builder(
            builder: (context) => Text(AppLocalizations.of(context).appName),
          ),
        ),
      );

      expect(find.text('HR Optimistic'), findsOneWidget);
    });

    testWidgets('Myanmar translations are loaded correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('my'),
          home: Builder(
            builder: (context) => Text(AppLocalizations.of(context).leaveRequest),
          ),
        ),
      );

      // Replace with actual Myanmar translation
      expect(find.text('ခွင့်တောင်းခြင်း'), findsOneWidget);
    });

    test('Supported locales contain required languages', () {
      expect(
        AppLocalizations.supportedLocales,
        containsAll([
          const Locale('en', ''),
          const Locale('my', ''),
          const Locale('th', ''),
          const Locale('zh', ''),
          const Locale('vi', ''),
        ]),
      );
    });

    test('Delegate shouldReload returns false', () {
      final delegate = AppLocalizations.delegate;
      expect(delegate.shouldReload(delegate), isFalse);
    });
  });
}