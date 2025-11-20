import 'dart:io';

void main() async {
  final dir = Directory('lib');
  await processDirectory(dir);
}

Future<void> processDirectory(Directory dir) async {
  await for (var entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await updateImports(entity);
    }
  }
}

Future<void> updateImports(File file) async {
  var content = await file.readAsString();
  
  // Replace FlutterFlow imports with our core implementations
  final replacements = {
    "import '/flutter_flow/flutter_flow_theme.dart'": "import 'package:hr_app/core/theme/app_theme.dart'",
    "import '../../../../flutter_flow/flutter_flow_theme.dart'": "import 'package:hr_app/core/theme/app_theme.dart'",
    "import '../../../../../flutter_flow/flutter_flow_theme.dart'": "import 'package:hr_app/core/theme/app_theme.dart'",
    
    "import '/flutter_flow/lat_lng.dart'": "import 'package:hr_app/core/models/lat_lng.dart'",
    "import '../../flutter_flow/lat_lng.dart'": "import 'package:hr_app/core/models/lat_lng.dart'",
    
    "import '/flutter_flow/place.dart'": "import 'package:hr_app/core/models/place.dart'",
    "import '../../flutter_flow/place.dart'": "import 'package:hr_app/core/models/place.dart'",
    
    "import '/flutter_flow/uploaded_file.dart'": "import 'package:hr_app/core/models/uploaded_file.dart'",
    "import '../../flutter_flow/uploaded_file.dart'": "import 'package:hr_app/core/models/uploaded_file.dart'",
    
    "import '/flutter_flow/flutter_flow_util.dart'": "import 'package:hr_app/core/utils/app_utils.dart'",
    "import '../../../../flutter_flow/flutter_flow_util.dart'": "import 'package:hr_app/core/utils/app_utils.dart'",
    
    "import '/flutter_flow/flutter_flow_model.dart'": "",
    "export 'flutter_flow_model.dart'": "",
  };

  var modified = false;
  for (var entry in replacements.entries) {
    if (content.contains(entry.key)) {
      content = content.replaceAll(entry.key, entry.value);
      modified = true;
    }
  }

  if (modified) {
    await file.writeAsString(content);
    print('Updated imports in: ${file.path}');
  }
}