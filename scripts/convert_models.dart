import 'dart:io';

void main() async {
  final dir = Directory('c:\\Users\\rain\\Desktop\\flutter\\OptimisticHRFlutter\\lib');
  await convertModels(dir);
}

Future<void> convertModels(Directory dir) async {
  await for (var entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('_model.dart')) {
      await convertModelFile(entity);
    }
  }
}

Future<void> convertModelFile(File file) async {
  print('Converting ${file.path}...');
  var content = await file.readAsString();

  if (!content.contains('extends FlutterFlowModel')) {
    return;
  }

  // Extract the model name
  final filename = file.path.split('\\').last;
  final className = filename.replaceAll('_model.dart', '').split('_')
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join('');

  // Create new model content
  final newContent = '''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '\${filename.replaceAll('.dart', '.freezed.dart')}';
part '\${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class ${className}State with _\$${className}State {
  const factory ${className}State({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _${className}State;

  factory ${className}State.fromJson(Map<String, dynamic> json) =>
      _\$${className}StateFromJson(json);
}
''';

  await file.writeAsString(newContent);
  print('Converted ${filename}');
}