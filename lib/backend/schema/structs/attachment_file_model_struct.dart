// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class AttachmentFileModelStruct extends BaseStruct {
  AttachmentFileModelStruct({
    String? attachmentFile,
    String? filename,
    String? filetype,
  })  : _attachmentFile = attachmentFile,
        _filename = filename,
        _filetype = filetype;

  // "attachment_file" field.
  String? _attachmentFile;
  String get attachmentFile => _attachmentFile ?? '';
  set attachmentFile(String? val) => _attachmentFile = val;

  bool hasAttachmentFile() => _attachmentFile != null;

  // "filename" field.
  String? _filename;
  String get filename => _filename ?? '';
  set filename(String? val) => _filename = val;

  bool hasFilename() => _filename != null;

  // "filetype" field.
  String? _filetype;
  String get filetype => _filetype ?? '';
  set filetype(String? val) => _filetype = val;

  bool hasFiletype() => _filetype != null;

  static AttachmentFileModelStruct fromMap(Map<String, dynamic> data) =>
      AttachmentFileModelStruct(
        attachmentFile: data['attachment_file'] as String?,
        filename: data['filename'] as String?,
        filetype: data['filetype'] as String?,
      );

  static AttachmentFileModelStruct? maybeFromMap(dynamic data) => data is Map
      ? AttachmentFileModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'attachment_file': _attachmentFile,
        'filename': _filename,
        'filetype': _filetype,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'attachment_file': serializeParam(
          _attachmentFile,
          ParamType.String,
        ),
        'filename': serializeParam(
          _filename,
          ParamType.String,
        ),
        'filetype': serializeParam(
          _filetype,
          ParamType.String,
        ),
      }.withoutNulls;

  static AttachmentFileModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      AttachmentFileModelStruct(
        attachmentFile: deserializeParam(
          data['attachment_file'],
          ParamType.String,
          false,
        ),
        filename: deserializeParam(
          data['filename'],
          ParamType.String,
          false,
        ),
        filetype: deserializeParam(
          data['filetype'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AttachmentFileModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AttachmentFileModelStruct &&
        attachmentFile == other.attachmentFile &&
        filename == other.filename &&
        filetype == other.filetype;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([attachmentFile, filename, filetype]);
}

AttachmentFileModelStruct createAttachmentFileModelStruct({
  String? attachmentFile,
  String? filename,
  String? filetype,
}) =>
    AttachmentFileModelStruct(
      attachmentFile: attachmentFile,
      filename: filename,
      filetype: filetype,
    );
