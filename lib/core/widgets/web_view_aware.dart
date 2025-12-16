import 'package:flutter/material.dart';

/// FlutterFlow WebViewAware stub - simply wraps the child
class WebViewAware extends StatelessWidget {
  const WebViewAware({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // In a real implementation, this would handle web view specific behavior
    // For now, just return the child
    return child;
  }
}
