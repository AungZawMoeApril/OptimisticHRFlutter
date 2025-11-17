import 'dart:io';

void main() {
  final file = File('lib/leave/leave_request/leave_request_widget.dart');
  var content = file.readAsStringSync();
  
  print('Starting comprehensive fixes...');
  
  // 1. Fix getCurrentTimestamp
  content = content.replaceAll('getCurrentTimestamp', 'DateTime.now()');
  print('✓ Fixed getCurrentTimestamp');
  
  // 2. Fix dateTimeFormat  
  content = content.replaceAllMapped(
    RegExp(r'(?<!functions\.)\bdateTimeFormat\('),
    (match) => 'functions.dateTimeFormat(',
  );
  print('✓ Fixed dateTimeFormat');
  
  //  3. Fix GoogleFonts - simpler approach: just change font: to fontFamily: and add .fontFamily after closing paren
  // Pattern matches: font: GoogleFonts.xxx( ... any content including newlines ... ),
  content = content.replaceAllMapped(
    RegExp(r'font:\s*GoogleFonts\s*\.\s*(\w+)\s*\([^)]*\)\s*,', multiLine: true, dotAll: true),
    (match) {
      final fontMethod = match.group(1);
      return 'fontFamily: GoogleFonts.$fontMethod().fontFamily,';
    },
  );
  print('✓ Fixed GoogleFonts font: parameters');
  
  file.writeAsStringSync(content);
  print('✓ All fixes applied successfully!');
}
