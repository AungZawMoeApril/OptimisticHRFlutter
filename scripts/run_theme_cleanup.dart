import 'dart:io';
import 'package:path/path.dart' as path;

void main() async {
  // Process all Dart files in the lib directory
  final dir = Directory('lib');
  await processDirectory(dir);
}

Future<void> processDirectory(Directory dir) async {
  await for (var entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await processFile(entity);
    }
  }
}

Future<void> processFile(File file) async {
  print('Processing ${file.path}...');
  var content = await file.readAsString();
  var originalContent = content;

  // Theme replacements mapping
  final themeReplacements = {
    'FlutterFlowTheme.of(context).primary': 'Theme.of(context).colorScheme.primary',
    'FlutterFlowTheme.of(context).secondary': 'Theme.of(context).colorScheme.secondary',
    'FlutterFlowTheme.of(context).tertiary': 'Theme.of(context).colorScheme.tertiary',
    'FlutterFlowTheme.of(context).alternate': 'Theme.of(context).colorScheme.surface',
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
    
    // Text styles
    'FlutterFlowTheme.of(context).displayLarge': 'Theme.of(context).textTheme.displayLarge',
    'FlutterFlowTheme.of(context).displayMedium': 'Theme.of(context).textTheme.displayMedium',
    'FlutterFlowTheme.of(context).displaySmall': 'Theme.of(context).textTheme.displaySmall',
    'FlutterFlowTheme.of(context).headlineLarge': 'Theme.of(context).textTheme.headlineLarge',
    'FlutterFlowTheme.of(context).headlineMedium': 'Theme.of(context).textTheme.headlineMedium',
    'FlutterFlowTheme.of(context).headlineSmall': 'Theme.of(context).textTheme.headlineSmall',
    'FlutterFlowTheme.of(context).titleLarge': 'Theme.of(context).textTheme.titleLarge',
    'FlutterFlowTheme.of(context).titleMedium': 'Theme.of(context).textTheme.titleMedium',
    'FlutterFlowTheme.of(context).titleSmall': 'Theme.of(context).textTheme.titleSmall',
    'FlutterFlowTheme.of(context).bodyLarge': 'Theme.of(context).textTheme.bodyLarge',
    'FlutterFlowTheme.of(context).bodyMedium': 'Theme.of(context).textTheme.bodyMedium',
    'FlutterFlowTheme.of(context).bodySmall': 'Theme.of(context).textTheme.bodySmall',
  };

  // Replace theme references
  for (var entry in themeReplacements.entries) {
    content = content.replaceAll(entry.key, entry.value);
  }

  // Replace font styles and weights
  content = content.replaceAll(
    RegExp(r'fontWeight: FlutterFlowTheme\.of\(context\)\.(\w+)\.fontWeight'),
    'fontWeight: Theme.of(context).textTheme.\$1?.fontWeight',
  );
  content = content.replaceAll(
    RegExp(r'fontStyle: FlutterFlowTheme\.of\(context\)\.(\w+)\.fontStyle'),
    'fontStyle: Theme.of(context).textTheme.\$1?.fontStyle',
  );

  // Replace FlutterFlow imports
  content = content.replaceAll(
    "import '/flutter_flow/flutter_flow_theme.dart'",
    "import 'package:flutter/material.dart';",
  );

  // Only write if content changed
  if (content != originalContent) {
    await file.writeAsString(content);
    print('Updated ${path.basename(file.path)}');
  }
}