// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class LeaveAttachmentListStruct extends BaseStruct {
  LeaveAttachmentListStruct({
    String? attachment,
    String? attachmentUrl,
    String? filename,
    String? filetype,
  })  : _attachment = attachment,
        _attachmentUrl = attachmentUrl,
        _filename = filename,
        _filetype = filetype;

  // "attachment" field.
  String? _attachment;
  String get attachment => _attachment ?? '';
  set attachment(String? val) => _attachment = val;

  bool hasAttachment() => _attachment != null;

  // "attachmentUrl" field.
  String? _attachmentUrl;
  String get attachmentUrl => _attachmentUrl ?? '';
  set attachmentUrl(String? val) => _attachmentUrl = val;

  bool hasAttachmentUrl() => _attachmentUrl != null;

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

  static LeaveAttachmentListStruct fromMap(Map<String, dynamic> data) =>
      LeaveAttachmentListStruct(
        attachment: data['attachment'] as String?,
        attachmentUrl: data['attachmentUrl'] as String?,
        filename: data['filename'] as String?,
        filetype: data['filetype'] as String?,
      );

  static LeaveAttachmentListStruct? maybeFromMap(dynamic data) => data is Map
      ? LeaveAttachmentListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'attachment': _attachment,
        'attachmentUrl': _attachmentUrl,
        'filename': _filename,
        'filetype': _filetype,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'attachment': serializeParam(
          _attachment,
          ParamType.String,
        ),
        'attachmentUrl': serializeParam(
          _attachmentUrl,
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

  static LeaveAttachmentListStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      LeaveAttachmentListStruct(
        attachment: deserializeParam(
          data['attachment'],
          ParamType.String,
          false,
        ),
        attachmentUrl: deserializeParam(
          data['attachmentUrl'],
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
  String toString() => 'LeaveAttachmentListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LeaveAttachmentListStruct &&
        attachment == other.attachment &&
        attachmentUrl == other.attachmentUrl &&
        filename == other.filename &&
        filetype == other.filetype;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([attachment, attachmentUrl, filename, filetype]);
}

LeaveAttachmentListStruct createLeaveAttachmentListStruct({
  String? attachment,
  String? attachmentUrl,
  String? filename,
  String? filetype,
}) =>
    LeaveAttachmentListStruct(
      attachment: attachment,
      attachmentUrl: attachmentUrl,
      filename: filename,
      filetype: filetype,
    );
