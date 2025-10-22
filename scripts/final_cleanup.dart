import 'dart:io';

void main() async {
  final filePath = 'lib/leave/leave_request/leave_request_widget.dart';
  final file = File(filePath);
  
  if (await file.exists()) {
    print('Processing $filePath...');
    var content = await file.readAsString();
    var originalContent = content;

    // Replace all FlutterFlowTheme references with proper Material theme ones
    content = content.replaceAll(
      RegExp(r'FlutterFlowTheme\.of\(context\)\.[a-zA-Z]+'),
      'Theme.of(context).textTheme.bodyLarge',
    );

    // Fix color references
    content = content.replaceAll(
      'Theme.of(context).textTheme.primary',
      'Theme.of(context).colorScheme.primary',
    );
    content = content.replaceAll(
      'Theme.of(context).textTheme.secondary',
      'Theme.of(context).colorScheme.secondary',
    );
    content = content.replaceAll(
      'Theme.of(context).textTheme.background',
      'Theme.of(context).colorScheme.background',
    );
    content = content.replaceAll(
      'Theme.of(context).textTheme.surface',
      'Theme.of(context).colorScheme.surface',
    );

    if (content != originalContent) {
      await file.writeAsString(content);
      print('Updated ${file.path}');
    }
  }
}