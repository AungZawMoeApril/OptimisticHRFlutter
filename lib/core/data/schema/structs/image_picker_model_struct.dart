// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class ImagePickerModelStruct extends BaseStruct {
  ImagePickerModelStruct({
    String? base64String,
    String? filename,
  })  : _base64String = base64String,
        _filename = filename;

  // "base64String" field.
  String? _base64String;
  String get base64String => _base64String ?? '';
  set base64String(String? val) => _base64String = val;

  bool hasBase64String() => _base64String != null;

  // "filename" field.
  String? _filename;
  String get filename => _filename ?? '';
  set filename(String? val) => _filename = val;

  bool hasFilename() => _filename != null;

  static ImagePickerModelStruct fromMap(Map<String, dynamic> data) =>
      ImagePickerModelStruct(
        base64String: data['base64String'] as String?,
        filename: data['filename'] as String?,
      );

  static ImagePickerModelStruct? maybeFromMap(dynamic data) => data is Map
      ? ImagePickerModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'base64String': _base64String,
        'filename': _filename,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'base64String': serializeParam(
          _base64String,
          ParamType.String,
        ),
        'filename': serializeParam(
          _filename,
          ParamType.String,
        ),
      }.withoutNulls;

  static ImagePickerModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ImagePickerModelStruct(
        base64String: deserializeParam(
          data['base64String'],
          ParamType.String,
          false,
        ),
        filename: deserializeParam(
          data['filename'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ImagePickerModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ImagePickerModelStruct &&
        base64String == other.base64String &&
        filename == other.filename;
  }

  @override
  int get hashCode => const ListEquality().hash([base64String, filename]);
}

ImagePickerModelStruct createImagePickerModelStruct({
  String? base64String,
  String? filename,
}) =>
    ImagePickerModelStruct(
      base64String: base64String,
      filename: filename,
    );
