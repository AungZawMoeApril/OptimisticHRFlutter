import 'dart:io';

void main() async {
  final dir = Directory('c:\\Users\\rain\\Desktop\\flutter\\OptimisticHRFlutter\\lib');
  final results = {
    'models': <String>[],
    'themes': <String>[],
    'imports': <String>[],
    'widgets': <String>[],
  };

  await processDirectory(dir, results);
  printResults(results);
}

Future<void> processDirectory(Directory dir, Map<String, List<String>> results) async {
  await for (var entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await checkFile(entity, results);
    }
  }
}

Future<void> checkFile(File file, Map<String, List<String>> results) async {
  var content = await file.readAsString();
  
  if (content.contains('FlutterFlowTheme')) {
    results['themes']!.add(file.path);
  }
  
  if (content.contains('extends FlutterFlowModel')) {
    results['models']!.add(file.path);
  }
  
  if (content.contains('import') && content.contains('flutter_flow')) {
    results['imports']!.add(file.path);
  }
  
  if (content.contains('FlutterFlow') && !content.contains('FlutterFlowTheme')) {
    results['widgets']!.add(file.path);
  }
}

void printResults(Map<String, List<String>> results) {
  print('\n🔍 FlutterFlow Usage Report:\n');
  
  print('📊 Summary:');
  print('- Theme References: ${results['themes']!.length} files');
  print('- Model Extensions: ${results['models']!.length} files');
  print('- FlutterFlow Imports: ${results['imports']!.length} files');
  print('- Other FlutterFlow Usage: ${results['widgets']!.length} files\n');
  
  for (var entry in results.entries) {
    if (entry.value.isNotEmpty) {
      print('📝 ${entry.key.toUpperCase()}:');
      for (var file in entry.value) {
        print('  - ${file.split('\\').last}');
      }
      print('');
    }
  }
}