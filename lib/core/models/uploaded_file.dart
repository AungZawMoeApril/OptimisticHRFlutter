import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mime/mime.dart';

/// Represents an uploaded file with metadata
class UploadedFile {
  UploadedFile({
    required this.name,
    required this.bytes,
    this.height,
    this.width,
    String? contentType,
  }) : contentType = contentType ?? _getContentType(name, bytes);

  /// The name of the file including extension
  final String name;

  /// The bytes of the file
  final Uint8List bytes;

  /// The height of the image if this is an image file
  final double? height;

  /// The width of the image if this is an image file
  final double? width;

  /// The content type (MIME type) of the file
  final String contentType;

  /// Create an UploadedFile from a File
  static Future<UploadedFile> fromFile(File file) async {
    final bytes = await file.readAsBytes();
    return UploadedFile(
      name: file.path.split('/').last,
      bytes: bytes,
    );
  }

  /// Get the content type based on file extension and content
  static String _getContentType(String fileName, Uint8List bytes) {
    // Try to determine MIME type from file extension first
    final mimeType = lookupMimeType(fileName, headerBytes: bytes);
    if (mimeType != null) {
      return mimeType;
    }

    // Fallback to checking file signature
    if (_isImage(bytes)) {
      return 'image/jpeg'; // Default to JPEG if specific type can't be determined
    }

    // Default to binary if type can't be determined
    return 'application/octet-stream';
  }

  /// Check if the bytes represent an image file
  static bool _isImage(Uint8List bytes) {
    if (bytes.length < 4) return false;

    // Check for common image signatures
    final signature = bytes.sublist(0, 4);
    
    // JPEG
    if (bytes[0] == 0xFF && bytes[1] == 0xD8) {
      return true;
    }
    
    // PNG
    if (signature[0] == 0x89 && signature[1] == 0x50 && 
        signature[2] == 0x4E && signature[3] == 0x47) {
      return true;
    }
    
    // GIF
    if (signature[0] == 0x47 && signature[1] == 0x49 && 
        signature[2] == 0x46 && signature[3] == 0x38) {
      return true;
    }

    return false;
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'bytes': base64Encode(bytes),
    'height': height,
    'width': width,
    'contentType': contentType,
  };

  static UploadedFile? fromMap(Map<String, dynamic>? data) =>
    data == null
      ? null
      : UploadedFile(
          name: data['name'] as String,
          bytes: base64Decode(data['bytes'] as String),
          height: data['height'] as double?,
          width: data['width'] as double?,
          contentType: data['contentType'] as String?,
        );
}