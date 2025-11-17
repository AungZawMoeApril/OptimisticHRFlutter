import 'dart:io';

void main() {
  final file = File('lib/leave/leave_request/leave_request_widget.dart');
  var content = file.readAsStringSync();
  
  // Count occurrences
  final pattern = RegExp(r'\bdateTimeFormat\(');
  final matches = pattern.allMatches(content);
  print('Found ${matches.length} dateTimeFormat occurrences');
  
  // Replace 'dateTimeFormat(' with 'functions.dateTimeFormat(' only when not already prefixed
  content = content.replaceAllMapped(
    RegExp(r'(?<!functions\.)\bdateTimeFormat\('),
    (match) => 'functions.dateTimeFormat(',
  );
  
  file.writeAsStringSync(content);
  print('Fixed all dateTimeFormat references');
}
