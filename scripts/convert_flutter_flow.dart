import 'dart:io';

Future<void> main() async {
  print('Starting comprehensive FlutterFlow to Flutter conversion...');

  // 1. Convert themes first
  print('\nConverting themes...');
  await Process.run('dart', ['scripts/convert_themes.dart']);

  // 2. Convert widget structures
  print('\nConverting widgets to modern architecture...');
  await Process.run('dart', ['scripts/convert_widgets.dart']);

  // 3. Convert remaining FlutterFlow components
  print('\nConverting FlutterFlow components...');
  final directory = Directory('lib');
  await convertAllFiles(directory);

  // 4. Clean up FlutterFlow directory
  print('\nCleaning up FlutterFlow files...');
  await cleanupFlutterFlow();

  print('\nConversion complete! Please review changes and test the application.');
}

Future<void> convertAllFiles(Directory directory) async {
  final entities = directory.listSync(recursive: true);
  
  for (final entity in entities) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await convertFile(entity);
    }
  }
}

Future<void> convertFile(File file) async {
  print('Processing ${file.path}');
  var content = file.readAsStringSync();
  var modified = false;

  // Theme conversions
  final themeReplacements = {
    RegExp(r'FlutterFlowTheme\.of\(context\)\.primaryBackground'): 'Theme.of(context).colorScheme.background',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.secondaryBackground'): 'Theme.of(context).colorScheme.surface',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.primaryText'): 'Theme.of(context).textTheme.bodyLarge?.color',
    RegExp(r'FlutterFlowTheme\.of\(context\)\.secondaryText'): 'Theme.of(context).textTheme.bodyMedium?.color',
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
  };

  // Widget conversions
  final widgetReplacements = {
    'FFButtonWidget(': 'AppButton(',
    'FlutterFlowIconButton(': 'AppIconButton(',
    'FlutterFlowDropDown(': 'AppDropdown(',
    'FlutterFlowRadioButton(': 'AppRadioButton(',
    'FlutterFlowCheckbox(': 'AppCheckbox(',
  };

  // Apply theme replacements
  for (final entry in themeReplacements.entries) {
    if (content.contains(entry.key)) {
      content = content.replaceAll(entry.key, entry.value);
      modified = true;
    }
  }

  // Apply widget replacements
  for (final entry in widgetReplacements.entries) {
    if (content.contains(entry.key)) {
      content = content.replaceAll(entry.key, entry.value);
      modified = true;
    }
  }

  // Handle imports
  final imports = {
    RegExp(r"import '[\.\/]*flutter_flow/flutter_flow_theme\.dart';"): '',
    RegExp(r"import '[\.\/]*flutter_flow/flutter_flow_widgets\.dart';"): "import 'package:hr_app/core/widgets/app_button.dart';",
    RegExp(r"import '[\.\/]*flutter_flow/flutter_flow_icon_button\.dart';"): "import 'package:hr_app/core/widgets/app_icon_button.dart';",
    RegExp(r"import '[\.\/]*flutter_flow/flutter_flow_drop_down\.dart';"): "import 'package:hr_app/core/widgets/app_dropdown.dart';",
    RegExp(r"import '[\.\/]*flutter_flow/flutter_flow_radio_button\.dart';"): "import 'package:hr_app/core/widgets/app_radio_button.dart';",
    RegExp(r"import '[\.\/]*flutter_flow/flutter_flow_checkbox\.dart';"): "import 'package:hr_app/core/widgets/app_checkbox.dart';",
    RegExp(r"import '[\.\/]*flutter_flow/flutter_flow_util\.dart';"): "import 'package:hr_app/core/utils/app_utils.dart';",
  };

  // Apply import replacements
  for (final entry in imports.entries) {
    if (content.contains(entry.key)) {
      content = content.replaceAll(entry.key, entry.value);
      modified = true;
    }
  }

  // Save changes if the file was modified
  if (modified) {
    file.writeAsStringSync(content);
    print('Updated ${file.path}');
  }
}

Future<void> cleanupFlutterFlow() async {
  final flutterFlowDir = Directory('lib/flutter_flow');
  if (await flutterFlowDir.exists()) {
    await flutterFlowDir.delete(recursive: true);
    print('Deleted flutter_flow directory');
  }
}