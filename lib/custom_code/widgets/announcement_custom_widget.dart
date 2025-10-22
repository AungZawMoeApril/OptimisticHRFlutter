// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:hr_app/core/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:flutter/foundation.dart';

class AnnouncementCustomWidget extends StatefulWidget {
  const AnnouncementCustomWidget({
    super.key,
    this.width,
    this.height,
    required this.weblink,
  });

  final double? width;
  final double? height;
  final String weblink;

  @override
  State<AnnouncementCustomWidget> createState() =>
      _AnnouncementCustomWidgetState();
}

class _AnnouncementCustomWidgetState extends State<AnnouncementCustomWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // ✅ Set platform implementation for webview_flutter
    if (WebViewPlatform.instance == null) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        WebViewPlatform.instance = AndroidWebViewPlatform();
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        WebViewPlatform.instance = WebKitWebViewPlatform();
      } else {
        throw UnsupportedError("WebView is not supported on this platform");
      }
    }

    // ✅ Set up controller creation parameters
    final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params);

    // ✅ Android specific setup
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    // ✅ Assign and configure the controller
    _controller = controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // You can update a progress bar here
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'messageHandler',
        onMessageReceived: (JavaScriptMessage message) {
          if (message.message == 'GoBack') {
            Navigator.of(context).pop();
          }
        },
      )
      ..loadRequest(
        Uri.parse(widget.weblink),
        headers: {'Cache-Control': 'no-cache'},
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: WebViewWidget(controller: _controller),
    );
  }
}
