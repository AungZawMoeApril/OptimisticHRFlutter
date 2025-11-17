import 'dart:io';

void main() {
  final file = File('lib/leave/leave_request/leave_request_widget.dart');
  var content = file.readAsStringSync();
  
  // Count occurrences
  final pattern = RegExp(r'\bgetCurrentTimestamp\b');
  final matches = pattern.allMatches(content);
  print('Found ${matches.length} getCurrentTimestamp occurrences');
  
  // Replace 'getCurrentTimestamp' with 'DateTime.now()'
  content = content.replaceAll('getCurrentTimestamp', 'DateTime.now()');
  
  file.writeAsStringSync(content);
  print('Fixed all getCurrentTimestamp references');
}
