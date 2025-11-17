import 'dart:io';

void main() {
  final file = File('lib/leave/leave_request/leave_request_widget.dart');
  var content = file.readAsStringSync();
  
  print('Fixing all remaining font: patterns...');
  
  // More comprehensive pattern that handles newlines and spaces everywhere
  // Match: font: GoogleFonts (with any whitespace/newlines) . (with any whitespace/newlines) methodName ( anything ) 
  content = content.replaceAllMapped(
    RegExp(
      r'font:\s*GoogleFonts\s*\.\s*(\w+)\s*\([^)]*\)',
      multiLine: true,
      dotAll: true,
    ),
    (match) {
      final fontMethod = match.group(1);
      return 'fontFamily: GoogleFonts.$fontMethod().fontFamily';
    },
  );
  
  print('✓ Fixed all font: patterns');
  
  file.writeAsStringSync(content);
  print('✓ Complete!');
}
