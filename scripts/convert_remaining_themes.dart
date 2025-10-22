import 'dart:io';

void main() async {
  print('Converting remaining FlutterFlow theme references to Material 3...');
  
  final directory = Directory('lib');
  await processDirectory(directory);
  
  print('\nConversion complete! Please review the changes.');
}

Future<void> processDirectory(Directory dir) async {
  final entities = await dir.list().toList();
  
  for (final entity in entities) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await convertFile(entity);
    } else if (entity is Directory) {
      await processDirectory(entity);
    }
  }
}

Future<void> convertFile(File file) async {
  var content = await file.readAsString();
  
  if (!content.contains('FlutterFlowTheme')) {
    return;
  }

  print('Processing ${file.path}');
  var modified = false;

  // Theme conversions
  final themeReplacements = {
    RegExp(r'FlutterFlowTheme\.of\(context\)\.primaryBackground'): 'Theme.of(context).colorScheme.background',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.secondaryBackground'): 'Theme.of(context).colorScheme.surface',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.primaryText'): 'Theme.of(context).colorScheme.onBackground',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.secondaryText'): 'Theme.of(context).colorScheme.onSurface',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.primary'): 'Theme.of(context).colorScheme.primary',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.secondary'): 'Theme.of(context).colorScheme.secondary',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.accent1'): 'Theme.of(context).colorScheme.primaryContainer',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.accent2'): 'Theme.of(context).colorScheme.secondaryContainer',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.accent3'): 'Theme.of(context).colorScheme.tertiaryContainer',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.accent4'): 'Theme.of(context).colorScheme.surface',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.success'): 'Colors.green',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.error'): 'Theme.of(context).colorScheme.error',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.info'): 'Colors.blue',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.warning'): 'Colors.orange',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.alternate'): 'Theme.of(context).colorScheme.surfaceVariant',
    // Text styles
    RegExp(r'FlutterFlowTheme\.of\(context\)\.bodyMedium'): 'Theme.of(context).textTheme.bodyMedium',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.bodyLarge'): 'Theme.of(context).textTheme.bodyLarge',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.bodySmall'): 'Theme.of(context).textTheme.bodySmall',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.titleMedium'): 'Theme.of(context).textTheme.titleMedium',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.titleLarge'): 'Theme.of(context).textTheme.titleLarge',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.titleSmall'): 'Theme.of(context).textTheme.titleSmall',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.labelMedium'): 'Theme.of(context).textTheme.labelMedium',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.labelLarge'): 'Theme.of(context).textTheme.labelLarge',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.labelSmall'): 'Theme.of(context).textTheme.labelSmall',
  };

  // Apply theme replacements
  for (final entry in themeReplacements.entries) {
    if (content.contains(entry.key)) {
      content = content.replaceAll(entry.key, entry.value);
      modified = true;
    }
  }

  // Update imports if needed
  if (content.contains('FlutterFlowTheme')) {
    content = content.replaceAll(
      RegExp(r"import '[^']*flutter_flow_theme\.dart';"),
      '',
    );
    modified = true;
  }

  if (modified) {
    await file.writeAsString(content);
    print('Updated ${file.path}');
  }
}