import 'dart:io';

const themeReplacements = {
  'FlutterFlowTheme.of(context).primaryText': 'Theme.of(context).textTheme.bodyLarge?.color',
  'FlutterFlowTheme.of(context).secondaryText': 'Theme.of(context).textTheme.bodyMedium?.color',
  'FlutterFlowTheme.of(context).primary': 'Theme.of(context).colorScheme.primary',
  'FlutterFlowTheme.of(context).secondary': 'Theme.of(context).colorScheme.secondary',
  'FlutterFlowTheme.of(context).tertiary': 'Theme.of(context).colorScheme.tertiary',
  'FlutterFlowTheme.of(context).alternate': 'Theme.of(context).colorScheme.surface',
  'FlutterFlowTheme.of(context).primaryBackground': 'Theme.of(context).colorScheme.background',
  'FlutterFlowTheme.of(context).secondaryBackground': 'Theme.of(context).colorScheme.surface',
};

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Please provide a file path');
    return;
  }

  final filePath = args[0];
  final file = File(filePath);
  if (!await file.exists()) {
    print('File not found: $filePath');
    return;
  }

  var content = await file.readAsString();
  
  // Replace theme references
  themeReplacements.forEach((from, to) {
    content = content.replaceAll(from, to);
  });

  // Add theme migration helper import if needed
  if (!content.contains('import \'package:hr_optimistic/core/theme/theme_migration_helper.dart\'')) {
    content = 'import \'package:hr_optimistic/core/theme/theme_migration_helper.dart\';\n' + content;
  }

  // Create backup
  await file.copy('${filePath}.bak');
  
  // Write updated content
  await file.writeAsString(content);
  
  print('Theme migration completed. Backup saved as ${filePath}.bak');
}