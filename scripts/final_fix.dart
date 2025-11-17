import 'dart:io';

void main() async {
  final libDir = Directory('lib');
  final dartFiles = await libDir
      .list(recursive: true)
      .where((entity) => entity is File && entity.path.endsWith('.dart'))
      .cast<File>()
      .toList();

  print('Found ${dartFiles.length} Dart files');

  int totalUpdated = 0;

  // Replacements in order - do custom properties first!
  final replacements = [
    // Custom app-specific colors first (defined in AppColors)
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*timeCheckin',
          multiLine: true),
      'replacement': 'AppColors.timeCheckin',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*timeCheckout',
          multiLine: true),
      'replacement': 'AppColors.success', // assuming checkout uses success color
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*timeMergeCheckin',
          multiLine: true),
      'replacement': 'AppColors.info',
    },
    // Then do multi-word standard colors
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*primaryBackground',
          multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.background',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*secondaryBackground',
          multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.surface',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*primaryText',
          multiLine: true),
      'replacement': 'Theme.of(context).textTheme.bodyLarge?.color',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*secondaryText',
          multiLine: true),
      'replacement': 'Theme.of(context).textTheme.bodyMedium?.color',
    },
    // Single word colors
    {
      'pattern': RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*primary',
          multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.primary',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*secondary',
              multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.secondary',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*tertiary',
              multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.tertiary',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*alternate',
              multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.surface',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*accent1',
          multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.primaryContainer',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*accent2',
          multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.secondaryContainer',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*accent3',
          multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.tertiaryContainer',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*accent4',
          multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.surfaceVariant',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*success',
          multiLine: true),
      'replacement': 'AppColors.success',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*error',
          multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.error',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*warning',
          multiLine: true),
      'replacement': 'AppColors.warning',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*info',
          multiLine: true),
      'replacement': 'AppColors.info',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*themeColor',
              multiLine: true),
      'replacement': 'Theme.of(context).colorScheme.primary',
    },
    // Text styles
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*displayLarge',
          multiLine: true),
      'replacement': 'Theme.of(context).textTheme.displayLarge!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*displayMedium',
          multiLine: true),
      'replacement': 'Theme.of(context).textTheme.displayMedium!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*displaySmall',
          multiLine: true),
      'replacement': 'Theme.of(context).textTheme.displaySmall!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*headlineLarge',
          multiLine: true),
      'replacement': 'Theme.of(context).textTheme.headlineLarge!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*headlineMedium',
          multiLine: true),
      'replacement': 'Theme.of(context).textTheme.headlineMedium!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*headlineSmall',
          multiLine: true),
      'replacement': 'Theme.of(context).textTheme.headlineSmall!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*titleLarge',
          multiLine: true),
      'replacement': 'Theme.of(context).textTheme.titleLarge!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*titleMedium',
          multiLine: true),
      'replacement': 'Theme.of(context).textTheme.titleMedium!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*titleSmall',
              multiLine: true),
      'replacement': 'Theme.of(context).textTheme.titleSmall!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*bodyLarge',
              multiLine: true),
      'replacement': 'Theme.of(context).textTheme.bodyLarge!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*bodyMedium',
              multiLine: true),
      'replacement': 'Theme.of(context).textTheme.bodyMedium!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*bodySmall',
              multiLine: true),
      'replacement': 'Theme.of(context).textTheme.bodySmall!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*labelLarge',
              multiLine: true),
      'replacement': 'Theme.of(context).textTheme.labelLarge!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*labelMedium',
              multiLine: true),
      'replacement': 'Theme.of(context).textTheme.labelMedium!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\.of\(\s*context\s*\)\s*\.\s*labelSmall',
              multiLine: true),
      'replacement': 'Theme.of(context).textTheme.labelSmall!',
    },
  ];

  for (final file in dartFiles) {
    try {
      String content = await file.readAsString();
      final originalContent = content;

      // Apply all regex replacements
      for (final replacement in replacements) {
        content = content.replaceAll(
            replacement['pattern'] as RegExp, replacement['replacement'] as String);
      }

      // Remove import statements
      content = content.replaceAll(
          "import '/core/theme/flutter_flow_theme.dart';\n", '');
      content = content.replaceAll(
          "import '/flutter_flow/flutter_flow_theme.dart';\n", '');
      
      // Add AppColors import if we're using it and it's not already there
      if (content.contains('AppColors.') && 
          !content.contains("import '/core/theme/app_colors.dart'") &&
          !content.contains("import 'package:hr_app/core/theme/app_colors.dart'")) {
        // Simple approach: add after package imports
        final lines = content.split('\n');
        var insertIndex = 0;
        for (var i = 0; i < lines.length; i++) {
          if (lines[i].trim().startsWith('import ')) {
            insertIndex = i + 1;
          }
        }
        lines.insert(insertIndex, "import '/core/theme/app_colors.dart';");
        content = lines.join('\n');
      }

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
