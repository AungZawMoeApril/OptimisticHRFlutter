import 'dart:io';
import 'package:path/path.dart' as path;

// Map of FlutterFlow theme properties to Material theme equivalents
final themeMap = {
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
  'FlutterFlowTheme.of(context).labelLarge': 'Theme.of(context).textTheme.labelLarge',
  'FlutterFlowTheme.of(context).labelMedium': 'Theme.of(context).textTheme.labelMedium',
  'FlutterFlowTheme.of(context).labelSmall': 'Theme.of(context).textTheme.labelSmall',
};

void main() {
  // Get all dart files
  final dir = Directory('lib');
  final dartFiles = dir.listSync(recursive: true)
    .where((f) => f.path.endsWith('.dart'))
    .cast<File>();

  // Process each file
  for (final file in dartFiles) {
    processFile(file);
  }
}

void processFile(File file) {
  var contents = file.readAsStringSync();
  var modified = false;

  // Replace theme references
  for (final entry in themeMap.entries) {
    if (contents.contains(entry.key)) {
      contents = contents.replaceAll(entry.key, entry.value);
      modified = true;
    }
  }

  // Update model inheritance
  if (contents.contains('extends FlutterFlowModel')) {
    contents = contents.replaceAll(
      'extends FlutterFlowModel',
      'extends BaseViewModel'
    );
    contents = contents.replaceAll(
      'import \'/flutter_flow/flutter_flow_model.dart\';',
      'import \'package:hr_app/core/presentation/base/base_view.dart\';'
    );
    modified = true;
  }

  // Save if modified
  if (modified) {
    file.writeAsStringSync(contents);
    print('Updated ${path.basename(file.path)}');
  }
}