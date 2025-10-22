import 'dart:io';

void main() async {
  final filesToClean = [
    'lib/leave/leave_request/leave_request_widget.dart',
    'lib/time_attandance/time_attendance/time_attendance_widget.dart',
    'lib/overtime/overtime_request_main/overtime_request_main_widget.dart'
  ];

  for (var filePath in filesToClean) {
    final file = File(filePath);
    if (await file.exists()) {
      print('Processing $filePath...');
      await processFile(file);
    }
  }
}

Future<void> processFile(File file) async {
  var content = await file.readAsString();
  var originalContent = content;

  // Replace specific theme properties with Material theme equivalents
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

  // Clean up remaining style properties
  content = content.replaceAll(
    RegExp(r'style:\s*FlutterFlowTheme\.of\(context\)\.(\w+)'),
    'style: Theme.of(context).textTheme.\$1',
  );

  // Clean up color properties
  content = content.replaceAll(
    RegExp(r'color:\s*FlutterFlowTheme\.of\(context\)\.(\w+)'),
    'color: Theme.of(context).colorScheme.\$1',
  );

  // Clean up text style properties
  content = content.replaceAll(
    RegExp(r'fontWeight:\s*FlutterFlowTheme\.of\(context\)\.(\w+)\.fontWeight'),
    'fontWeight: Theme.of(context).textTheme.\$1?.fontWeight',
  );

  content = content.replaceAll(
    RegExp(r'fontStyle:\s*FlutterFlowTheme\.of\(context\)\.(\w+)\.fontStyle'),
    'fontStyle: Theme.of(context).textTheme.\$1?.fontStyle',
  );

  // Replace any textStyle references
  content = content.replaceAll(
    RegExp(r'textStyle:\s*FlutterFlowTheme\.of\(context\)\.(\w+)'),
    'textStyle: Theme.of(context).textTheme.\$1',
  );

  // Clean up any remaining override patterns
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.(\w+)\.override\([^)]*\)'),
    'Theme.of(context).textTheme.\$1',
  );

  if (content != originalContent) {
    await file.writeAsString(content);
    print('Updated ${file.path}');
  }
}