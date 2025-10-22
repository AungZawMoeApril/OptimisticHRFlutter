// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '../core/utils/app_utils.dart';;

class OTCheckOutRequestStruct extends BaseStruct {
  OTCheckOutRequestStruct({
    int? clockID,
    String? clockOutTime,
    int? userID,
    List<AttachmentsStruct>? attachments,
  })  : _clockID = clockID,
        _clockOutTime = clockOutTime,
        _userID = userID,
        _attachments = attachments;

  // "clock_ID" field.
  int? _clockID;
  int get clockID => _clockID ?? 0;
  set clockID(int? val) => _clockID = val;

  void incrementClockID(int amount) => clockID = clockID + amount;

  bool hasClockID() => _clockID != null;

  // "clock_Out_Time" field.
  String? _clockOutTime;
  String get clockOutTime => _clockOutTime ?? '';
  set clockOutTime(String? val) => _clockOutTime = val;

  bool hasClockOutTime() => _clockOutTime != null;

  // "user_ID" field.
  int? _userID;
  int get userID => _userID ?? 0;
  set userID(int? val) => _userID = val;

  void incrementUserID(int amount) => userID = userID + amount;

  bool hasUserID() => _userID != null;

  // "attachments" field.
  List<AttachmentsStruct>? _attachments;
  List<AttachmentsStruct> get attachments => _attachments ?? const [];
  set attachments(List<AttachmentsStruct>? val) => _attachments = val;

  void updateAttachments(Function(List<AttachmentsStruct>) updateFn) {
    updateFn(_attachments ??= []);
  }

  bool hasAttachments() => _attachments != null;

  static OTCheckOutRequestStruct fromMap(Map<String, dynamic> data) =>
      OTCheckOutRequestStruct(
        clockID: castToType<int>(data['clock_ID']),
        clockOutTime: data['clock_Out_Time'] as String?,
        userID: castToType<int>(data['user_ID']),
        attachments: getStructList(
          data['attachments'],
          AttachmentsStruct.fromMap,
        ),
      );

  static OTCheckOutRequestStruct? maybeFromMap(dynamic data) => data is Map
      ? OTCheckOutRequestStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'clock_ID': _clockID,
        'clock_Out_Time': _clockOutTime,
        'user_ID': _userID,
        'attachments': _attachments?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'clock_ID': serializeParam(
          _clockID,
          ParamType.int,
        ),
        'clock_Out_Time': serializeParam(
          _clockOutTime,
          ParamType.String,
        ),
        'user_ID': serializeParam(
          _userID,
          ParamType.int,
        ),
        'attachments': serializeParam(
          _attachments,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static OTCheckOutRequestStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      OTCheckOutRequestStruct(
        clockID: deserializeParam(
          data['clock_ID'],
          ParamType.int,
          false,
        ),
        clockOutTime: deserializeParam(
          data['clock_Out_Time'],
          ParamType.String,
          false,
        ),
        userID: deserializeParam(
          data['user_ID'],
          ParamType.int,
          false,
        ),
        attachments: deserializeStructParam<AttachmentsStruct>(
          data['attachments'],
          ParamType.DataStruct,
          true,
          structBuilder: AttachmentsStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'OTCheckOutRequestStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is OTCheckOutRequestStruct &&
        clockID == other.clockID &&
        clockOutTime == other.clockOutTime &&
        userID == other.userID &&
        listEquality.equals(attachments, other.attachments);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([clockID, clockOutTime, userID, attachments]);
}

OTCheckOutRequestStruct createOTCheckOutRequestStruct({
  int? clockID,
  String? clockOutTime,
  int? userID,
}) =>
    OTCheckOutRequestStruct(
      clockID: clockID,
      clockOutTime: clockOutTime,
      userID: userID,
    );
