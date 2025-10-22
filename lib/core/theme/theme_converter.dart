import 'dart:io';
import 'package:path/path.dart' as path;
import 'theme_mapping.dart';

void main() {
  final libDir = Directory('lib');
  processDirectory(libDir);
}

void processDirectory(Directory dir) {
  for (var entity in dir.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      processFile(entity);
    }
  }
}

void processFile(File file) {
  var content = file.readAsStringSync();
  var modified = false;

  // Replace FlutterFlow theme imports
  if (content.contains("import 'package:flutter/material.dart';")) {
    content = content.replaceAll(
      "import 'package:flutter/material.dart';",
      "import 'package:flutter/material.dart';",
    );
    modified = true;
  }

  // Replace theme references
  for (var entry in themeMapping.entries) {
    if (content.contains(entry.key)) {
      content = content.replaceAll(entry.key, entry.value);
      modified = true;
    }
  }

  // Replace common FlutterFlow theme patterns
  final styleOverridePattern = RegExp(
    r'FlutterFlowTheme\.of\(context\)\.[a-zA-Z]+\.override\(',
    multiLine: true,
  );
  if (content.contains(styleOverridePattern)) {
    content = content.replaceAllMapped(
      styleOverridePattern,
      (match) => 'Theme.of(context).textTheme.${match.group(0)!.split('.')[2]}.copyWith(',
    );
    modified = true;
  }

  // Save changes if file was modified
  if (modified) {
    file.writeAsStringSync(content);
    print('Updated ${path.basename(file.path)}');
  }
}