import 'dart:io';

void main() {
  // Directory containing the files to process
  final directory = Directory('lib');

  // Process all .dart files recursively
  directory.listSync(recursive: true).forEach((entity) {
    if (entity is File && entity.path.endsWith('.dart')) {
      convertFile(entity);
    }
  });
}

void convertFile(File file) {
  var content = file.readAsStringSync();

  // Replace FlutterFlow theme references
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.primaryBackground'),
    'Theme.of(context).colorScheme.background',
  );
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.secondaryBackground'),
    'Theme.of(context).colorScheme.surface',
  );
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

  // Replace FlutterFlow widgets
  content = content.replaceAll(
    'FlutterFlowIconButton(',
    'AppIconButton(',
  );
  content = content.replaceAll(
    'FlutterFlowDropDown(',
    'AppDropdown(',
  );

  // Replace FlutterFlow imports
  content = content.replaceAll(
    RegExp(r"import '\/flutter_flow\/.*';"),
    '',
  );

  // Add new imports if widgets are used
  if (content.contains('AppIconButton(')) {
    content = "import 'package:your_app/core/widgets/app_icon_button.dart';\n" + content;
  }
  if (content.contains('AppDropdown(')) {
    content = "import 'package:your_app/core/widgets/app_dropdown.dart';\n" + content;
  }

  file.writeAsStringSync(content);
}