import 'dart:io';
import 'package:path/path.dart' as path;

void main() async {
  // Process all Dart files in the lib directory
  final dir = Directory('lib');
  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await processFile(entity);
    }
  }
}

Future<void> processFile(File file) async {
  print('Processing ${file.path}...');
  var content = await file.readAsString();
  var originalContent = content;

  // Replace imports
  content = replaceImports(content);

  // Replace theme references
  content = replaceThemeReferences(content);

  // Replace FFAppState references
  content = replaceStateReferences(content);

  // Replace navigation
  content = replaceNavigation(content);

  // Only write if content changed
  if (content != originalContent) {
    await file.writeAsString(content);
    print('Updated ${path.basename(file.path)}');
  }
}

String replaceImports(String content) {
  final imports = {
    "import '/flutter_flow/flutter_flow_theme.dart'": "import 'package:flutter/material.dart';",
    "import '/flutter_flow/flutter_flow_util.dart'": "import '../core/utils/app_utils.dart';",
    "import '/flutter_flow/flutter_flow_widgets.dart'": "import '../core/widgets/app_button.dart';",
    "import '/flutter_flow/flutter_flow_icon_button.dart'": "import '../core/widgets/app_icon_button.dart';",
  };

  for (var entry in imports.entries) {
    content = content.replaceAll(entry.key, entry.value);
  }
  return content;
}

String replaceThemeReferences(String content) {
  final themeReplacements = {
    'FlutterFlowTheme.of(context).primary': 'Theme.of(context).colorScheme.primary',
    'FlutterFlowTheme.of(context).secondary': 'Theme.of(context).colorScheme.secondary',
    'FlutterFlowTheme.of(context).tertiary': 'Theme.of(context).colorScheme.tertiary',
    'FlutterFlowTheme.of(context).primaryBackground': 'Theme.of(context).colorScheme.background',
    'FlutterFlowTheme.of(context).secondaryBackground': 'Theme.of(context).colorScheme.surface',
    'FlutterFlowTheme.of(context).primaryText': 'Theme.of(context).textTheme.bodyLarge?.color',
    'FlutterFlowTheme.of(context).secondaryText': 'Theme.of(context).textTheme.bodyMedium?.color',
    'FlutterFlowTheme.of(context).accent1': 'Theme.of(context).colorScheme.primaryContainer',
    'FlutterFlowTheme.of(context).accent2': 'Theme.of(context).colorScheme.secondaryContainer',
    'FlutterFlowTheme.of(context).accent3': 'Theme.of(context).colorScheme.tertiaryContainer',
    'FlutterFlowTheme.of(context).accent4': 'Theme.of(context).colorScheme.surfaceVariant',
    'FlutterFlowTheme.of(context).success': 'Theme.of(context).colorScheme.surfaceTint',
    'FlutterFlowTheme.of(context).error': 'Theme.of(context).colorScheme.error',
    'FlutterFlowTheme.of(context).warning': 'Colors.orange',
    'FlutterFlowTheme.of(context).info': 'Theme.of(context).colorScheme.outline',
    'FlutterFlowTheme.of(context).themeColor': 'Theme.of(context).colorScheme.primary',
  };

  for (var entry in themeReplacements.entries) {
    content = content.replaceAll(entry.key, entry.value);
  }

  // Replace text style overrides
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.(\w+)\.override\('),
    'Theme.of(context).textTheme.\$1?.copyWith(',
  );

  return content;
}

String replaceStateReferences(String content) {
  // Replace FFAppState with proper Provider/Consumer usage
  content = content.replaceAll(
    'context.watch<FFAppState>()',
    'context.watch<AppState>()',
  );
  content = content.replaceAll(
    'FFAppState()',
    'AppState()',
  );
  return content;
}

String replaceNavigation(String content) {
  // Replace navigation methods
  final navigationReplacements = {
    'context.pop()': 'Navigator.of(context).pop()',
    'context.pushNamed(': 'Navigator.of(context).pushNamed(',
    'context.pushReplacementNamed(': 'Navigator.of(context).pushReplacementNamed(',
  };

  for (var entry in navigationReplacements.entries) {
    content = content.replaceAll(entry.key, entry.value);
  }
  return content;
}