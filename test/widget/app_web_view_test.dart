import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hr_app/core/widgets/app_web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'app_web_view_test.mocks.dart';

@GenerateMocks([WebViewController, NavigationDelegate])
void main() {
  group('AppWebView Widget Tests', () {
    testWidgets('AppWebView renders correctly with default props', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppWebView(
            url: 'https://example.com',
          ),
        ),
      );

      expect(find.byType(AppWebView), findsOneWidget);
      expect(find.byType(WebViewWidget), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('AppWebView hides AppBar when showAppBar is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppWebView(
            url: 'https://example.com',
            showAppBar: false,
          ),
        ),
      );

      expect(find.byType(AppBar), findsNothing);
    });

    testWidgets('AppWebView shows custom title when provided', (WidgetTester tester) async {
      const testTitle = 'Test Title';
      
      await tester.pumpWidget(
        MaterialApp(
          home: AppWebView(
            url: 'https://example.com',
            title: testTitle,
          ),
        ),
      );

      expect(find.text(testTitle), findsOneWidget);
    });

    testWidgets('AppWebView shows loading indicator initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppWebView(
            url: 'https://example.com',
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('AppWebView handles onPageFinished callback', (WidgetTester tester) async {
      String? finishedUrl;
      
      await tester.pumpWidget(
        MaterialApp(
          home: AppWebView(
            url: 'https://example.com',
            onPageFinished: (url) {
              finishedUrl = url;
            },
          ),
        ),
      );

      // Wait for the WebView to initialize
      await tester.pumpAndSettle();

      // Simulate page load finish
      final State<AppWebView> state = tester.state(find.byType(AppWebView));
      final navigationDelegate = (state as _AppWebViewState)
          ._controller
          .platform
          .navigationDelegate as NavigationDelegate;
          
      navigationDelegate.onPageFinished?.call('https://example.com');
      
      expect(finishedUrl, 'https://example.com');
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('AppWebView applies custom headers when provided', (WidgetTester tester) async {
      final headers = {'Authorization': 'Bearer token'};
      
      await tester.pumpWidget(
        MaterialApp(
          home: AppWebView(
            url: 'https://example.com',
            headers: headers,
          ),
        ),
      );

      final State<AppWebView> state = tester.state(find.byType(AppWebView));
      final controller = (state as _AppWebViewState)._controller;
      
      // Verify headers are passed to loadRequest
      verify(controller.loadRequest(
        Uri.parse('https://example.com'),
        headers: headers,
      ));
    });
  });
}