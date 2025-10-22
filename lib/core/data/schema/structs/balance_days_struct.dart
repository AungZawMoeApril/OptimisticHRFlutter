// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class BalanceDaysStruct extends BaseStruct {
  BalanceDaysStruct({
    int? timeOffID,
    String? timeoffTypeEN,
    String? timeoffTypeTH,
    String? leaveDaysLeft,
    int? availablDays,
    int? approverID,
    String? approveName,
  })  : _timeOffID = timeOffID,
        _timeoffTypeEN = timeoffTypeEN,
        _timeoffTypeTH = timeoffTypeTH,
        _leaveDaysLeft = leaveDaysLeft,
        _availablDays = availablDays,
        _approverID = approverID,
        _approveName = approveName;

  // "timeOff_ID" field.
  int? _timeOffID;
  int get timeOffID => _timeOffID ?? 0;
  set timeOffID(int? val) => _timeOffID = val;

  void incrementTimeOffID(int amount) => timeOffID = timeOffID + amount;

  bool hasTimeOffID() => _timeOffID != null;

  // "timeoff_TypeEN" field.
  String? _timeoffTypeEN;
  String get timeoffTypeEN => _timeoffTypeEN ?? '';
  set timeoffTypeEN(String? val) => _timeoffTypeEN = val;

  bool hasTimeoffTypeEN() => _timeoffTypeEN != null;

  // "timeoff_TypeTH" field.
  String? _timeoffTypeTH;
  String get timeoffTypeTH => _timeoffTypeTH ?? '';
  set timeoffTypeTH(String? val) => _timeoffTypeTH = val;

  bool hasTimeoffTypeTH() => _timeoffTypeTH != null;

  // "leaveDaysLeft" field.
  String? _leaveDaysLeft;
  String get leaveDaysLeft => _leaveDaysLeft ?? '';
  set leaveDaysLeft(String? val) => _leaveDaysLeft = val;

  bool hasLeaveDaysLeft() => _leaveDaysLeft != null;

  // "availablDays" field.
  int? _availablDays;
  int get availablDays => _availablDays ?? 0;
  set availablDays(int? val) => _availablDays = val;

  void incrementAvailablDays(int amount) =>
      availablDays = availablDays + amount;

  bool hasAvailablDays() => _availablDays != null;

  // "approver_ID" field.
  int? _approverID;
  int get approverID => _approverID ?? 0;
  set approverID(int? val) => _approverID = val;

  void incrementApproverID(int amount) => approverID = approverID + amount;

  bool hasApproverID() => _approverID != null;

  // "approve_Name" field.
  String? _approveName;
  String get approveName => _approveName ?? '';
  set approveName(String? val) => _approveName = val;

  bool hasApproveName() => _approveName != null;

  static BalanceDaysStruct fromMap(Map<String, dynamic> data) =>
      BalanceDaysStruct(
        timeOffID: castToType<int>(data['timeOff_ID']),
        timeoffTypeEN: data['timeoff_TypeEN'] as String?,
        timeoffTypeTH: data['timeoff_TypeTH'] as String?,
        leaveDaysLeft: data['leaveDaysLeft'] as String?,
        availablDays: castToType<int>(data['availablDays']),
        approverID: castToType<int>(data['approver_ID']),
        approveName: data['approve_Name'] as String?,
      );

  static BalanceDaysStruct? maybeFromMap(dynamic data) => data is Map
      ? BalanceDaysStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'timeOff_ID': _timeOffID,
        'timeoff_TypeEN': _timeoffTypeEN,
        'timeoff_TypeTH': _timeoffTypeTH,
        'leaveDaysLeft': _leaveDaysLeft,
        'availablDays': _availablDays,
        'approver_ID': _approverID,
        'approve_Name': _approveName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'timeOff_ID': serializeParam(
          _timeOffID,
          ParamType.int,
        ),
        'timeoff_TypeEN': serializeParam(
          _timeoffTypeEN,
          ParamType.String,
        ),
        'timeoff_TypeTH': serializeParam(
          _timeoffTypeTH,
          ParamType.String,
        ),
        'leaveDaysLeft': serializeParam(
          _leaveDaysLeft,
          ParamType.String,
        ),
        'availablDays': serializeParam(
          _availablDays,
          ParamType.int,
        ),
        'approver_ID': serializeParam(
          _approverID,
          ParamType.int,
        ),
        'approve_Name': serializeParam(
          _approveName,
          ParamType.String,
        ),
      }.withoutNulls;

  static BalanceDaysStruct fromSerializableMap(Map<String, dynamic> data) =>
      BalanceDaysStruct(
        timeOffID: deserializeParam(
          data['timeOff_ID'],
          ParamType.int,
          false,
        ),
        timeoffTypeEN: deserializeParam(
          data['timeoff_TypeEN'],
          ParamType.String,
          false,
        ),
        timeoffTypeTH: deserializeParam(
          data['timeoff_TypeTH'],
          ParamType.String,
          false,
        ),
        leaveDaysLeft: deserializeParam(
          data['leaveDaysLeft'],
          ParamType.String,
          false,
        ),
        availablDays: deserializeParam(
          data['availablDays'],
          ParamType.int,
          false,
        ),
        approverID: deserializeParam(
          data['approver_ID'],
          ParamType.int,
          false,
        ),
        approveName: deserializeParam(
          data['approve_Name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BalanceDaysStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BalanceDaysStruct &&
        timeOffID == other.timeOffID &&
        timeoffTypeEN == other.timeoffTypeEN &&
        timeoffTypeTH == other.timeoffTypeTH &&
        leaveDaysLeft == other.leaveDaysLeft &&
        availablDays == other.availablDays &&
        approverID == other.approverID &&
        approveName == other.approveName;
  }

  @override
  int get hashCode => const ListEquality().hash([
        timeOffID,
        timeoffTypeEN,
        timeoffTypeTH,
        leaveDaysLeft,
        availablDays,
        approverID,
        approveName
      ]);
}

BalanceDaysStruct createBalanceDaysStruct({
  int? timeOffID,
  String? timeoffTypeEN,
  String? timeoffTypeTH,
  String? leaveDaysLeft,
  int? availablDays,
  int? approverID,
  String? approveName,
}) =>
    BalanceDaysStruct(
      timeOffID: timeOffID,
      timeoffTypeEN: timeoffTypeEN,
      timeoffTypeTH: timeoffTypeTH,
      leaveDaysLeft: leaveDaysLeft,
      availablDays: availablDays,
      approverID: approverID,
      approveName: approveName,
    );
