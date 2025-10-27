import 'dart:io';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Please provide the file path');
    return;
  }

  final filePath = args[0];
  final file = File(filePath);
  if (!await file.exists()) {
    print('File not found: $filePath');
    return;
  }

  var content = await file.readAsString();

  // Create backup
  await file.copy('${filePath}.bak');

  // Replace theme references
  content = replaceThemeReferences(content);

  // Replace FlutterFlowDropDown
  content = replaceDropdownWidget(content);

  // Update imports
  content = updateImports(content);

  // Write updated content
  await file.writeAsString(content);
  print('Successfully updated ${filePath}');
}

String replaceThemeReferences(String content) {
  final replacements = {
    'FlutterFlowTheme.of(context).primaryText': 'Theme.of(context).textTheme.bodyLarge?.color',
    'FlutterFlowTheme.of(context).secondaryText': 'Theme.of(context).textTheme.bodyMedium?.color',
    'FlutterFlowTheme.of(context).primary': 'Theme.of(context).colorScheme.primary',
    'FlutterFlowTheme.of(context).secondary': 'Theme.of(context).colorScheme.secondary',
    'FlutterFlowTheme.of(context).tertiary': 'Theme.of(context).colorScheme.tertiary',
    'FlutterFlowTheme.of(context).alternate': 'Theme.of(context).colorScheme.surface',
    'FlutterFlowTheme.of(context).primaryBackground': 'Theme.of(context).colorScheme.background',
    'FlutterFlowTheme.of(context).secondaryBackground': 'Theme.of(context).colorScheme.surface',
  };

  var updatedContent = content;
  replacements.forEach((oldText, newText) {
    updatedContent = updatedContent.replaceAll(oldText, newText);
  });

  // Replace style overrides
  final styleRegex = RegExp(r'style: FlutterFlowTheme\.of\(context\)\.(\w+)\.override\([^)]+\)');
  updatedContent = updatedContent.replaceAllMapped(styleRegex, (match) {
    final textStyle = match.group(1);
    return 'style: ThemeMigrationHelper.getStyledTextTheme(context, Theme.of(context).textTheme.$textStyle)';
  });

  return updatedContent;
}

String replaceDropdownWidget(String content) {
  final dropdownRegex = RegExp(r'FlutterFlowDropDown<([^>]+)>\([^)]+\)');
  return content.replaceAllMapped(dropdownRegex, (match) {
    final type = match.group(1);
    return 'AppDropdown<$type>(';
  });
}

String updateImports(String content) {
  // Add required imports if not present
  final requiredImports = '''
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_optimistic/core/theme/theme_migration_helper.dart';
import 'package:hr_optimistic/core/widgets/app_dropdown.dart';
''';

  if (!content.contains('theme_migration_helper.dart')) {
    content = requiredImports + content;
  }

  // Remove FlutterFlow imports
  content = content.replaceAll(RegExp(r'import.*flutter_flow.*;\n'), '');

  return content;
}