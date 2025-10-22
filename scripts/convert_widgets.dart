import 'dart:io';
import 'package:path/path.dart' as path;

/// The base widget template for converting FlutterFlow widgets
const baseWidgetTemplate = '''
import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class {WidgetName}ViewModel extends BaseViewModel {
  {ViewModel}
}

class {WidgetName} extends StatelessWidget {
  {Constructor}

  @override
  Widget build(BuildContext context) {
    return BaseView<{WidgetName}ViewModel>(
      viewModelBuilder: () => {WidgetName}ViewModel(),
      builder: (context, model, child) {
        return {Widget};
      },
    );
  }
}
''';

void main() {
  // Get all widget files
  final dir = Directory('lib');
  final widgetFiles = dir.listSync(recursive: true)
    .where((f) => f.path.endsWith('_widget.dart'))
    .cast<File>();

  // Process each file
  for (final file in widgetFiles) {
    processWidget(file);
  }
}

void processWidget(File file) {
  final contents = file.readAsStringSync();
  
  // Skip if already converted
  if (!contents.contains('extends StatefulWidget')) return;

  // Extract widget name
  final fileName = path.basenameWithoutExtension(file.path);
  final className = fileName.split('_').map((s) => s[0].toUpperCase() + s.substring(1)).join('');

  // Extract constructor
  final constructorMatch = RegExp(r'const \w+\({[^}]+}\);').firstMatch(contents);
  final constructor = constructorMatch?.group(0) ?? 'const $className();';

  // Extract widget build method content
  final buildMatch = RegExp(r'Widget build\(BuildContext context\) {([^}]+)}').firstMatch(contents);
  final widget = buildMatch?.group(1)?.trim() ?? 'Container()';

  // Extract view model properties and methods
  final modelLines = <String>[];
  final stateMatches = RegExp(r'(\w+) _\w+ = [^;]+;').allMatches(contents);
  for (final match in stateMatches) {
    final line = match.group(0);
    if (line != null) modelLines.add(line);
  }

  // Generate new widget
  final newContents = baseWidgetTemplate
    .replaceAll('{WidgetName}', className)
    .replaceAll('{Constructor}', constructor)
    .replaceAll('{Widget}', widget)
    .replaceAll('{ViewModel}', modelLines.join('\n  '));

  // Write new file
  final newFile = File('${file.parent.path}/${fileName}_new.dart');
  newFile.writeAsStringSync(newContents);
  print('Generated ${path.basename(newFile.path)}');
}