import 'dart:io';

void main() {
  final file = File('lib/leave/leave_request/leave_request_widget.dart');
  var content = file.readAsStringSync();
  
  // Count occurrences
  final pattern = RegExp(r'font:\s*GoogleFonts\s*\.\s*(\w+)\s*\(');
  final matches = pattern.allMatches(content);
  print('Found ${matches.length} GoogleFonts font: occurrences');
  
  // Replace 'font: GoogleFonts.xxx(...)' with 'fontFamily: GoogleFonts.xxx().fontFamily'
  content = content.replaceAllMapped(
    RegExp(r'font:\s*GoogleFonts\s*\.\s*(\w+)\s*\([^)]*\)'),
    (match) => 'fontFamily: GoogleFonts.${match.group(1)}().fontFamily',
  );
  
  file.writeAsStringSync(content);
  print('Fixed all GoogleFonts font: parameters');
}
