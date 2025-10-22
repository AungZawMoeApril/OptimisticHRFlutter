import 'dart:io';

void main() async {
  // Get all Dart files recursively
  final dirs = [
    'lib/leave',
    'lib/overtime',
    'lib/on_site',
    // Add other directories as needed
  ];

  for (final dir in dirs) {
    await processDirectory(dir);
  }
}

Future<void> processDirectory(String dirPath) async {
  final dir = Directory(dirPath);
  if (!dir.existsSync()) {
    print('Directory $dirPath does not exist');
    return;
  }

  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await processFile(entity.path);
    }
  }
}

Future<void> processFile(String filePath) async {
  var content = await File(filePath).readAsString();
  if (!content.contains('FFButton')) {
    return;
  }

  // Replace FFButtonOptions with AppButton parameters
  content = content.replaceAll(
    RegExp(r'FFButtonWidget\(\s*text:\s*([^,]+),\s*onPressed:\s*([^,]+),\s*options:\s*FFButtonOptions\(\s*width:\s*([^,]+),\s*height:\s*([^,]+),\s*padding:[^,]+,\s*iconPadding:[^,]+,\s*color:\s*([^,]+),\s*textStyle:[^,]+,\s*elevation:\s*([^,]+),\s*borderSide:\s*BorderSide\([^)]+\),\s*borderRadius:\s*([^,]+),'),
    'AppButton(\n'
    '  text: \$1,\n'
    '  onPressed: \$2,\n'
    '  width: \$3,\n'
    '  height: \$4,\n'
    '  backgroundColor: \$5,\n'
    '  borderRadius: \$7,\n'
    '  showBorder: false,\n'
  );

  // Replace FFButtonOptions import
  content = content.replaceAll(
    "import '/flutter_flow/flutter_flow_theme.dart';",
    "import '../core/widgets/app_button.dart';"
  );

  await File(filePath).writeAsString(content);
  print('Processed $filePath');
}