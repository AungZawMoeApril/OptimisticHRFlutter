import 'dart:io';

void main() {
  final file = File('lib/leave/leave_request/leave_request_widget.dart');
  var content = file.readAsStringSync();
  
  // Fix pattern: fontFamily: GoogleFonts.xxx(...) to fontFamily: GoogleFonts.xxx(...).fontFamily
  // This regex handles multi-line cases
  final pattern = RegExp(
    r'fontFamily:\s*GoogleFonts\.(\w+)\s*\(([^)]+)\)(?!\.fontFamily)',
    multiLine: true,
    dotAll: true,
  );
  
  content = content.replaceAllMapped(pattern, (match) {
    return 'fontFamily: GoogleFonts.${match.group(1)}(${match.group(2)}).fontFamily';
  });
  
  // Also fix `font:` that were missed
  content = content.replaceAll(RegExp(r'\bfont:\s*GoogleFonts'), 'fontFamily: GoogleFonts');
  content = content.replaceAll(RegExp(r'\bfont:'), 'fontFamily:');
  
  file.writeAsStringSync(content);
  print('Fixed GoogleFonts fontFamily usage');
}
