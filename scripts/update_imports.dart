import 'dart:io';

void main() async {
  final dir = Directory('lib');
  await processDirectory(dir);
}

Future<void> processDirectory(Directory dir) async {
  await for (var entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await updateImports(entity);
    }
  }
}

Future<void> updateImports(File file) async {
  var content = await file.readAsString();
  
  // Replace FlutterFlow imports with our new core utilities
  final replacements = {
    "import '/flutter_flow/custom_functions.dart'": "import 'package:hr_app/core/utils/custom_functions.dart'",
    "import '/flutter_flow/form_field_controller.dart'": "import 'package:hr_app/core/utils/form_field_controller.dart'",
    "import '/flutter_flow/upload_data.dart'": "import 'package:hr_app/core/utils/upload_data.dart'",
  };

  var modified = false;
  for (var entry in replacements.entries) {
    if (content.contains(entry.key)) {
      content = content.replaceAll(entry.key, entry.value);
      modified = true;
    }
  }

  if (modified) {
    await file.writeAsString(content);
    print('Updated imports in: ${file.path}');
  }
}