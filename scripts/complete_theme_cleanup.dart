import 'dart:io';
import 'package:path/path.dart' as path;

void main() async {
  final filesToClean = [
    'lib/leave/leave_request/leave_request_widget.dart',
    'lib/time_attandance/time_attendance/time_attendance_widget.dart',
    'lib/overtime/overtime_request_main/overtime_request_main_widget.dart',
  ];

  for (var filePath in filesToClean) {
    final file = File(filePath);
    if (await file.exists()) {
      await processFile(file);
    }
  }
}

Future<void> processFile(File file) async {
  print('Processing ${file.path}...');
  var content = await file.readAsString();
  var originalContent = content;

  // Theme mapping
  final themeReplacements = {
    'FlutterFlowTheme.of(context).primary': 'Theme.of(context).colorScheme.primary',
    'FlutterFlowTheme.of(context).secondary': 'Theme.of(context).colorScheme.secondary',
    'FlutterFlowTheme.of(context).tertiary': 'Theme.of(context).colorScheme.tertiary',
    'FlutterFlowTheme.of(context).alternate': 'Theme.of(context).colorScheme.surface',
    'FlutterFlowTheme.of(context).primaryBackground': 'Theme.of(context).colorScheme.background',
    'FlutterFlowTheme.of(context).secondaryBackground': 'Theme.of(context).colorScheme.surface',
    'FlutterFlowTheme.of(context).primaryText': 'Theme.of(context).textTheme.bodyLarge?.color',
    'FlutterFlowTheme.of(context).secondaryText': 'Theme.of(context).textTheme.bodyMedium?.color',
  };

  // Replace theme references
  for (var entry in themeReplacements.entries) {
    content = content.replaceAll(entry.key, entry.value);
  }

  // Replace text styles
  content = content.replaceAll(
    RegExp(r'style:\s*FlutterFlowTheme\.of\(context\)\.(\w+)'),
    'style: Theme.of(context).textTheme.\$1',
  );

  // Replace colors
  content = content.replaceAll(
    RegExp(r'color:\s*FlutterFlowTheme\.of\(context\)\.(\w+)'),
    'color: Theme.of(context).colorScheme.\$1',
  );

  // Replace font properties
  content = content.replaceAll(
    RegExp(r'fontWeight:\s*FlutterFlowTheme\.of\(context\)\.(\w+)\.fontWeight'),
    'fontWeight: Theme.of(context).textTheme.\$1?.fontWeight',
  );

  content = content.replaceAll(
    RegExp(r'fontStyle:\s*FlutterFlowTheme\.of\(context\)\.(\w+)\.fontStyle'),
    'fontStyle: Theme.of(context).textTheme.\$1?.fontStyle',
  );

  // Only write if content changed
  if (content != originalContent) {
    await file.writeAsString(content);
    print('Updated ${path.basename(file.path)}');
  }
}