import 'dart:io';
import 'package:path/path.dart' as path;

void main() async {
  final dir = Directory('lib');
  await processDirectory(dir);
}

Future<void> processDirectory(Directory dir) async {
  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await processFile(entity);
    }
  }
}

Future<void> processFile(File file) async {
  var content = await file.readAsString();
  
  // Skip files that don't use FlutterFlowTheme
  if (!content.contains('FlutterFlowTheme')) {
    return;
  }

  print('Processing ${file.path}');

  // Replace theme references
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.primaryText'),
    'Theme.of(context).textTheme.bodyLarge?.color',
  );
  
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.secondaryText'),
    'Theme.of(context).textTheme.bodyMedium?.color',
  );
  
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.primary'),
    'Theme.of(context).colorScheme.primary',
  );
  
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.secondary'),
    'Theme.of(context).colorScheme.secondary',
  );
  
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.tertiary'),
    'Theme.of(context).colorScheme.tertiary',
  );
  
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.alternate'),
    'Theme.of(context).colorScheme.surface',
  );
  
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.primaryBackground'),
    'Theme.of(context).colorScheme.background',
  );
  
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.secondaryBackground'),
    'Theme.of(context).colorScheme.surface',
  );

  // Replace style overrides
  content = content.replaceAll(
    RegExp(r'style: FlutterFlowTheme\.of\(context\)\.bodyMedium\.override\([^)]+\)'),
    'style: ThemeMigrationHelper.getStyledTextTheme(context, Theme.of(context).textTheme.bodyMedium)',
  );

  content = content.replaceAll(
    RegExp(r'style: FlutterFlowTheme\.of\(context\)\.bodyLarge\.override\([^)]+\)'),
    'style: ThemeMigrationHelper.getStyledTextTheme(context, Theme.of(context).textTheme.bodyLarge)',
  );

  // Add imports if needed
  if (content.contains('ThemeMigrationHelper') && !content.contains('theme_migration_helper.dart')) {
    content = "import 'package:hr_optimistic/core/theme/theme_migration_helper.dart';\n" + content;
  }

  await file.writeAsString(content);
  print('Processed ${file.path}');
}