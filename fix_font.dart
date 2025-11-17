import 'dart:io';

void main() {
  final file = File('lib/leave/leave_request/leave_request_widget.dart');
  var content = file.readAsStringSync();
  
  // Replace pattern: font: GoogleFonts.xxx(...) with fontFamily: GoogleFonts.xxx().fontFamily
  // and remove duplicate fontWeight and fontStyle parameters
  
  final pattern = RegExp(
    r'font:\s*GoogleFonts\s*\.\s*(\w+)\s*\([^)]*\),(\s+)' +
    r'((?:(?!fontWeight:|fontStyle:).)*?)' + // content before fontWeight
    r'(?:fontWeight:[^,]*,\s*)?' + // optional fontWeight
    r'((?:(?!fontStyle:).)*?)' + // content between
    r'(?:fontStyle:[^,]*,\s*)?', // optional fontStyle
    multiLine: true,
    dotAll: true,
  );
  
  content = content.replaceAllMapped(pattern, (match) {
    final fontName = match.group(1);
    final indent = match.group(2);
    final content1 = match.group(3) ?? '';
    final content2 = match.group(4) ?? '';
    return 'fontFamily: GoogleFonts.$fontName().fontFamily,$indent$content1$content2';
  });
  
  file.writeAsStringSync(content);
  print('Fixed font: parameters');
}
