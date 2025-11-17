import 'dart:io';

void main() async {
  // Get all Dart files
  final libDir = Directory('lib');
  final dartFiles = await libDir
      .list(recursive: true)
      .where((entity) => entity is File && entity.path.endsWith('.dart'))
      .cast<File>()
      .toList();

  print('Found ${dartFiles.length} Dart files');

  int totalUpdated = 0;

  for (final file in dartFiles) {
    try {
      String content = await file.readAsString();
      final originalContent = content;

      // Do replacements - order matters! Do longest matches first
      content = content.replaceAll(
          'FlutterFlowTheme.of(context).primaryBackground',
          'Theme.of(context).colorScheme.background');
      content = content.replaceAll(
          'FlutterFlowTheme.of(context).secondaryBackground',
          'Theme.of(context).colorScheme.surface');
      content = content.replaceAll('FlutterFlowTheme.of(context).primaryText',
          'Theme.of(context).textTheme.bodyLarge?.color');
      content = content.replaceAll('FlutterFlowTheme.of(context).secondaryText',
          'Theme.of(context).textTheme.bodyMedium?.color');
      content = content.replaceAll('FlutterFlowTheme.of(context).primary',
          'Theme.of(context).colorScheme.primary');
      content = content.replaceAll('FlutterFlowTheme.of(context).secondary',
          'Theme.of(context).colorScheme.secondary');
      content = content.replaceAll('FlutterFlowTheme.of(context).tertiary',
          'Theme.of(context).colorScheme.tertiary');
      content = content.replaceAll('FlutterFlowTheme.of(context).alternate',
          'Theme.of(context).colorScheme.surface');
      content = content.replaceAll('FlutterFlowTheme.of(context).accent1',
          'Theme.of(context).colorScheme.primaryContainer');
      content = content.replaceAll('FlutterFlowTheme.of(context).accent2',
          'Theme.of(context).colorScheme.secondaryContainer');
      content = content.replaceAll('FlutterFlowTheme.of(context).accent3',
          'Theme.of(context).colorScheme.tertiaryContainer');
      content = content.replaceAll('FlutterFlowTheme.of(context).accent4',
          'Theme.of(context).colorScheme.surfaceVariant');
      content = content.replaceAll(
          'FlutterFlowTheme.of(context).success', 'Theme.of(context).colorScheme.surfaceTint');
      content = content.replaceAll(
          'FlutterFlowTheme.of(context).error', 'Theme.of(context).colorScheme.error');
      content = content.replaceAll(
          'FlutterFlowTheme.of(context).warning', 'Colors.orange');
      content = content.replaceAll(
          'FlutterFlowTheme.of(context).info', 'Theme.of(context).colorScheme.outline');
      content = content.replaceAll('FlutterFlowTheme.of(context).themeColor',
          'Theme.of(context).colorScheme.primary');

      // Text styles
      content = content.replaceAll('FlutterFlowTheme.of(context).displayLarge',
          'Theme.of(context).textTheme.displayLarge!');
      content = content.replaceAll('FlutterFlowTheme.of(context).displayMedium',
          'Theme.of(context).textTheme.displayMedium!');
      content = content.replaceAll('FlutterFlowTheme.of(context).displaySmall',
          'Theme.of(context).textTheme.displaySmall!');
      content = content.replaceAll('FlutterFlowTheme.of(context).headlineLarge',
          'Theme.of(context).textTheme.headlineLarge!');
      content = content.replaceAll('FlutterFlowTheme.of(context).headlineMedium',
          'Theme.of(context).textTheme.headlineMedium!');
      content = content.replaceAll('FlutterFlowTheme.of(context).headlineSmall',
          'Theme.of(context).textTheme.headlineSmall!');
      content = content.replaceAll('FlutterFlowTheme.of(context).titleLarge',
          'Theme.of(context).textTheme.titleLarge!');
      content = content.replaceAll('FlutterFlowTheme.of(context).titleMedium',
          'Theme.of(context).textTheme.titleMedium!');
      content = content.replaceAll('FlutterFlowTheme.of(context).titleSmall',
          'Theme.of(context).textTheme.titleSmall!');
      content = content.replaceAll('FlutterFlowTheme.of(context).bodyLarge',
          'Theme.of(context).textTheme.bodyLarge!');
      content = content.replaceAll('FlutterFlowTheme.of(context).bodyMedium',
          'Theme.of(context).textTheme.bodyMedium!');
      content = content.replaceAll('FlutterFlowTheme.of(context).bodySmall',
          'Theme.of(context).textTheme.bodySmall!');
      content = content.replaceAll('FlutterFlowTheme.of(context).labelLarge',
          'Theme.of(context).textTheme.labelLarge!');
      content = content.replaceAll('FlutterFlowTheme.of(context).labelMedium',
          'Theme.of(context).textTheme.labelMedium!');
      content = content.replaceAll('FlutterFlowTheme.of(context).labelSmall',
          'Theme.of(context).textTheme.labelSmall!');

      // Remove import statements
      content = content.replaceAll(
          "import '/core/theme/flutter_flow_theme.dart';\n", '');
      content = content.replaceAll(
          "import '/flutter_flow/flutter_flow_theme.dart';\n", '');

      if (content != originalContent) {
        await file.writeAsString(content);
        totalUpdated++;
        print('✓ Updated: ${file.path}');
      }
    } catch (e) {
      print('✗ Error processing ${file.path}: $e');
    }
  }

  print('\n✅ Conversion complete!');
  print('Updated $totalUpdated files');
}
