import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class UploadData {
  static Future<String?> uploadFile(String path, {String? url}) async {
    if (url == null || url.isEmpty) return null;

    try {
      final file = File(path);
      if (!await file.exists()) return null;

      final bytes = await file.readAsBytes();
      final uri = Uri.parse(url);
      
      final request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: path.split('/').last,
        ));

      final response = await request.send();
      if (response.statusCode != 200) return null;

      final responseData = await response.stream.bytesToString();
      final json = jsonDecode(responseData);
      
      return json['url'] as String?;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  static Future<List<String>> uploadFiles(
    List<String> paths, {
    String? url,
  }) async {
    final uploads = <Future<String?>>[];
    for (final path in paths) {
      uploads.add(uploadFile(path, url: url));
    }
    return (await Future.wait(uploads))
        .where((url) => url != null)
        .map((url) => url!)
        .toList();
  }
}