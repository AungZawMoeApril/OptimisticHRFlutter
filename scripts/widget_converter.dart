import 'dart:io';
import 'package:path/path.dart' as path;

void main() async {
  // Process all Dart files in the lib directory
  final dir = Directory('lib');
  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await processFile(entity);
    }
  }
}

Future<void> processFile(File file) async {
  try {
    print('Processing ${file.path}...');
    var content = await file.readAsString();
    var originalContent = content;

    // Replace FlutterFlow widgets
    content = replaceWidgets(content);

    // Only write if content changed
    if (content != originalContent) {
      await file.writeAsString(content);
      print('Updated ${path.basename(file.path)}');
    }
  } catch (e) {
    print('Error processing file ${file.path}: $e');
  }
}

String replaceWidgets(String content) {
  // Replace FlutterFlow button widgets
  content = content.replaceAll(
    'FFButtonWidget(',
    'AppButton(',
  );

  // Replace FlutterFlow icon button widgets
  content = content.replaceAll(
    'FlutterFlowIconButton(',
    'AppIconButton(',
  );

  // Replace FlutterFlow dropdown widgets
  content = content.replaceAll(
    'FlutterFlowDropDown(',
    'AppDropdown(',
  );

  // Replace FlutterFlow calendar widgets
  content = content.replaceAll(
    'FlutterFlowCalendar(',
    'AppCalendar(',
  );

  // Replace FlutterFlow choice chips
  content = content.replaceAll(
    'FlutterFlowChoiceChips(',
    'AppChoiceChips(',
  );

  // Replace FlutterFlow animations
  content = replaceAnimations(content);

  // Remove FlutterFlow imports
  content = content.replaceAll(
    RegExp(r"import '[^']*flutter_flow_[^']*';?\n"),
    '',
  );

  // Add necessary imports
  if (content.contains('AppButton(') || 
      content.contains('AppIconButton(') ||
      content.contains('AppDropdown(')) {
    content = "import '../core/widgets/app_widgets.dart';\n" + content;
  }

  return content;
}

String replaceAnimations(String content) {
  // Replace FlutterFlow animation widgets with proper AnimationController usage
  final animationPattern = RegExp(r'FlutterFlowAnimation\(([\s\S]*?)\)');
  
  return content.replaceAllMapped(animationPattern, (_) {
    // Convert to proper AnimationController setup
    return '''AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..forward()''';
  });
}