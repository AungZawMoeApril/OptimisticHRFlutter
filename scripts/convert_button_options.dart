import 'dart:io';

void main() async {
  print('Converting FFButtonOptions to Material 3 button styles...');
  
  final directory = Directory('lib');
  await processDirectory(directory);
  
  print('\nConversion complete! Please review the changes.');
}

Future<void> processDirectory(Directory dir) async {
  final entities = await dir.list().toList();
  
  for (final entity in entities) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await convertFile(entity);
    } else if (entity is Directory) {
      await processDirectory(entity);
    }
  }
}

Future<void> convertFile(File file) async {
  var content = await file.readAsString();
  
  if (!content.contains('FFButtonOptions')) {
    return;
  }

  print('Processing ${file.path}');
  var modified = false;

  // Replace FFButtonOptions block with ElevatedButton.styleFrom
  final buttonOptionsPattern = RegExp(
    r'options:\s*FFButtonOptions\(\s*'
    r'(?:width:\s*([^,]+),\s*)?'
    r'(?:height:\s*([^,]+),\s*)?'
    r'(?:padding:[^,]+,\s*)?'
    r'(?:iconPadding:[^,]+,\s*)?'
    r'(?:color:\s*([^,]+),\s*)?'
    r'(?:textStyle:\s*([^,]+),\s*)?'
    r'(?:elevation:\s*([^,]+),\s*)?'
    r'(?:borderSide:\s*BorderSide\([^)]+\),\s*)?'
    r'(?:borderRadius:\s*([^,\)]+))?[^)]*\)',
    multiLine: true,
  );

  content = content.replaceAllMapped(buttonOptionsPattern, (match) {
    final width = match.group(1);
    final height = match.group(2);
    final color = match.group(3);
    final textStyle = match.group(4);
    final elevation = match.group(5);
    final borderRadius = match.group(6);

    var sizeStr = '';
    if (width != null && height != null) {
      sizeStr = 'minimumSize: Size($width, $height),';
    } else if (height != null) {
      sizeStr = 'minimumSize: Size.fromHeight($height),';
    }

    modified = true;
    return '''style: ElevatedButton.styleFrom(
      $sizeStr
      padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
      backgroundColor: $color,
      textStyle: $textStyle,
      elevation: $elevation,
      side: const BorderSide(
        color: Colors.transparent,
        width: 1.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: $borderRadius,
      ),
    )''';
  });

  // Update imports if needed
  if (content.contains('FFButtonOptions')) {
    content = content.replaceAll(
      RegExp(r"import '[^']*flutter_flow_widgets\.dart';"),
      "import 'package:hr_app/core/widgets/app_button.dart';",
    );
    modified = true;
  }

  if (modified) {
    await file.writeAsString(content);
    print('Updated ${file.path}');
  }
}