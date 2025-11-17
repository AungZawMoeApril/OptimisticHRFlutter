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

  // More aggressive patterns that handle newlines anywhere
  final replacements = [
    // Custom app-specific colors - longest names first
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*overtimetextcolor',
          multiLine: true, dotAll: true),
      'replacement': 'AppColors.overtimetextcolor',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*blackFontColor',
          multiLine: true, dotAll: true),
      'replacement': 'AppColors.blackFontColor',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*greyTitle',
          multiLine: true, dotAll: true),
      'replacement': 'AppColors.greyTitle',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*bkCheckin',
          multiLine: true, dotAll: true),
      'replacement': 'AppColors.bkCheckin',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*timeCheckin',
          multiLine: true, dotAll: true),
      'replacement': 'AppColors.timeCheckin',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*timeCheckout',
          multiLine: true, dotAll: true),
      'replacement': 'AppColors.success',
    },
    // Multi-word colors
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*primaryBackground',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.background',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*secondaryBackground',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.surface',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*primaryText',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.bodyLarge?.color',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*secondaryText',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.bodyMedium?.color',
    },
    // Single word colors
    {
      'pattern': RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*primary',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.primary',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*secondary',
              multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.secondary',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*tertiary',
              multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.tertiary',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*alternate',
              multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.surface',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*accent1',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.primaryContainer',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*accent2',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.secondaryContainer',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*accent3',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.tertiaryContainer',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*accent4',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.surfaceVariant',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*success',
          multiLine: true, dotAll: true),
      'replacement': 'AppColors.success',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*error',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.error',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*warning',
          multiLine: true, dotAll: true),
      'replacement': 'AppColors.warning',
    },
    {
      'pattern': RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*info',
          multiLine: true, dotAll: true),
      'replacement': 'AppColors.info',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*themeColor',
              multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).colorScheme.primary',
    },
    // Text styles
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*displayLarge',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.displayLarge!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*displayMedium',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.displayMedium!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*displaySmall',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.displaySmall!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*headlineLarge',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.headlineLarge!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*headlineMedium',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.headlineMedium!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*headlineSmall',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.headlineSmall!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*titleLarge',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.titleLarge!',
    },
    {
      'pattern': RegExp(
          r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*titleMedium',
          multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.titleMedium!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*titleSmall',
              multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.titleSmall!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*bodyLarge',
              multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.bodyLarge!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*bodyMedium',
              multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.bodyMedium!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*bodySmall',
              multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.bodySmall!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*labelLarge',
              multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.labelLarge!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*labelMedium',
              multiLine: true, dotAll: true),
      'replacement': 'Theme.of(context).textTheme.labelMedium!',
    },
    {
      'pattern':
          RegExp(r'FlutterFlowTheme\s*\.\s*of\s*\(\s*context\s*\)\s*\.\s*labelSmall',
              multiLine: true, dotAll: true),
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
      
      // Add AppColors import if needed
      if (content.contains('AppColors.') && 
          !content.contains("import '/core/theme/app_colors.dart'") &&
          !content.contains("import 'package:hr_app/core/theme/app_colors.dart'")) {
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
