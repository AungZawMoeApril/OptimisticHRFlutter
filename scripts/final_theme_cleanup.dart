import 'dart:io';
import 'package:path/path.dart' as path;

void main() async {
  final filesToClean = [
    'c:\\Users\\rain\\Desktop\\flutter\\OptimisticHRFlutter\\lib\\leave\\leave_request\\leave_request_widget.dart',
    'c:\\Users\\rain\\Desktop\\flutter\\OptimisticHRFlutter\\lib\\my_info\\profile\\profile_widget.dart',
    'c:\\Users\\rain\\Desktop\\flutter\\OptimisticHRFlutter\\lib\\leave\\leave_request_edit_main\\leave_request_edit_main_widget.dart',
  ];

  for (var filePath in filesToClean) {
    final file = File(filePath);
    if (await file.exists()) {
      await processFile(file);
    }
  }
}

Future<void> processFile(File file) async {
  print('Processing ${file.path}...');
  var content = await file.readAsString();
  var originalContent = content;

  // Replace remaining theme references
  content = content.replaceAll(
    RegExp(r'FlutterFlowTheme\.of\(context\)\.(\w+)(?:\.fontWeight)?(?:\.fontStyle)?'),
    'Theme.of(context).textTheme.\$1',
  );

  content = content.replaceAll(
    RegExp(r'style:\s*FlutterFlowTheme\.of\(context\)\.(\w+)'),
    'style: Theme.of(context).textTheme.\$1',
  );

  content = content.replaceAll(
    RegExp(r'color:\s*FlutterFlowTheme\.of\(context\)\.(\w+)'),
    'color: Theme.of(context).colorScheme.\$1',
  );

  // Handle text style overrides
  content = content.replaceAll(
    RegExp(r'fontWeight:\s*FlutterFlowTheme\.of\(context\)\.(\w+)\.fontWeight'),
    'fontWeight: Theme.of(context).textTheme.\$1?.fontWeight',
  );

  content = content.replaceAll(
    RegExp(r'fontStyle:\s*FlutterFlowTheme\.of\(context\)\.(\w+)\.fontStyle'),
    'fontStyle: Theme.of(context).textTheme.\$1?.fontStyle',
  );

  // Only write if content changed
  if (content != originalContent) {
    await file.writeAsString(content);
    print('Updated ${path.basename(file.path)}');
  }
}