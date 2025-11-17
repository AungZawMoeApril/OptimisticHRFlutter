import 'dart:io';

void main() {
  final file = File('lib/leave/leave_request/leave_request_widget.dart');
  var content = file.readAsStringSync();
  
  print('Fixing remaining GoogleFonts issues...');
  
  // Pattern 1: font: GoogleFonts.xxx(...),  (with comma at end)
  content = content.replaceAllMapped(
    RegExp(r'font:\s*GoogleFonts\s*\.\s*(\w+)\s*\([^)]*\)\s*,', multiLine: true, dotAll: true),
    (match) {
      final fontMethod = match.group(1);
      return 'fontFamily: GoogleFonts.$fontMethod().fontFamily,';
    },
  );
  
  // Pattern 2: font: GoogleFonts.xxx(...) (without comma at end, followed by closing paren)
  content = content.replaceAllMapped(
    RegExp(r'font:\s*GoogleFonts\s*\.\s*(\w+)\s*\([^)]*\)\s*\)', multiLine: true, dotAll: true),
    (match) {
      final fontMethod = match.group(1);
      return 'fontFamily: GoogleFonts.$fontMethod().fontFamily)';
    },
  );
  
  print('✓ Fixed remaining GoogleFonts font: parameters');
  
  file.writeAsStringSync(content);
  print('✓ All fixes applied!');
}
