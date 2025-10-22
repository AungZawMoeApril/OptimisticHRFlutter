import 'dart:io';

void main() async {
  final filePath = 'lib/leave/leave_request/leave_request_widget.dart';
  final file = File(filePath);
  if (await file.exists()) {
    print('Processing $filePath...');
    var content = await file.readAsString();
    var originalContent = content;

    // Deep cleanup of theme references
    content = content.replaceAll(
      RegExp(r'FlutterFlowTheme\.of\(context\)\.(\w+)(?:\.override\([^)]*\))?'),
      'Theme.of(context).textTheme.\$1',
    );

    content = content.replaceAll(
      RegExp(r'color:\s*(?:Theme\.of\(context\)\.textTheme\.(\w+))'),
      'color: Theme.of(context).colorScheme.\$1',
    );

    // Fix any doubled up theme references
    content = content.replaceAll(
      'Theme.of(context).textTheme.primary',
      'Theme.of(context).colorScheme.primary',
    );

    content = content.replaceAll(
      'Theme.of(context).textTheme.secondary',
      'Theme.of(context).colorScheme.secondary',
    );

    if (content != originalContent) {
      await file.writeAsString(content);
      print('Updated leave_request_widget.dart');
    }
  }
}