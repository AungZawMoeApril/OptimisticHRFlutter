// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class GetLeaveWithRemainingDaysStruct extends BaseStruct {
  GetLeaveWithRemainingDaysStruct({
    int? timeOffID,
    String? timeOffTypeEn,
    String? timeoffTypeTH,
    String? leaveDaysLeft,
    int? availablDays,
    int? approverID,
    String? approveName,
  })  : _timeOffID = timeOffID,
        _timeOffTypeEn = timeOffTypeEn,
        _timeoffTypeTH = timeoffTypeTH,
        _leaveDaysLeft = leaveDaysLeft,
        _availablDays = availablDays,
        _approverID = approverID,
        _approveName = approveName;

  // "timeOffID" field.
  int? _timeOffID;
  int get timeOffID => _timeOffID ?? 0;
  set timeOffID(int? val) => _timeOffID = val;

  void incrementTimeOffID(int amount) => timeOffID = timeOffID + amount;

  bool hasTimeOffID() => _timeOffID != null;

  // "timeOff_TypeEn" field.
  String? _timeOffTypeEn;
  String get timeOffTypeEn => _timeOffTypeEn ?? '';
  set timeOffTypeEn(String? val) => _timeOffTypeEn = val;

  bool hasTimeOffTypeEn() => _timeOffTypeEn != null;

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

  static GetLeaveWithRemainingDaysStruct fromMap(Map<String, dynamic> data) =>
      GetLeaveWithRemainingDaysStruct(
        timeOffID: castToType<int>(data['timeOffID']),
        timeOffTypeEn: data['timeOff_TypeEn'] as String?,
        timeoffTypeTH: data['timeoff_TypeTH'] as String?,
        leaveDaysLeft: data['leaveDaysLeft'] as String?,
        availablDays: castToType<int>(data['availablDays']),
        approverID: castToType<int>(data['approver_ID']),
        approveName: data['approve_Name'] as String?,
      );

  static GetLeaveWithRemainingDaysStruct? maybeFromMap(dynamic data) => data
          is Map
      ? GetLeaveWithRemainingDaysStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'timeOffID': _timeOffID,
        'timeOff_TypeEn': _timeOffTypeEn,
        'timeoff_TypeTH': _timeoffTypeTH,
        'leaveDaysLeft': _leaveDaysLeft,
        'availablDays': _availablDays,
        'approver_ID': _approverID,
        'approve_Name': _approveName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'timeOffID': serializeParam(
          _timeOffID,
          ParamType.int,
        ),
        'timeOff_TypeEn': serializeParam(
          _timeOffTypeEn,
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

  static GetLeaveWithRemainingDaysStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      GetLeaveWithRemainingDaysStruct(
        timeOffID: deserializeParam(
          data['timeOffID'],
          ParamType.int,
          false,
        ),
        timeOffTypeEn: deserializeParam(
          data['timeOff_TypeEn'],
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
  String toString() => 'GetLeaveWithRemainingDaysStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GetLeaveWithRemainingDaysStruct &&
        timeOffID == other.timeOffID &&
        timeOffTypeEn == other.timeOffTypeEn &&
        timeoffTypeTH == other.timeoffTypeTH &&
        leaveDaysLeft == other.leaveDaysLeft &&
        availablDays == other.availablDays &&
        approverID == other.approverID &&
        approveName == other.approveName;
  }

  @override
  int get hashCode => const ListEquality().hash([
        timeOffID,
        timeOffTypeEn,
        timeoffTypeTH,
        leaveDaysLeft,
        availablDays,
        approverID,
        approveName
      ]);
}

GetLeaveWithRemainingDaysStruct createGetLeaveWithRemainingDaysStruct({
  int? timeOffID,
  String? timeOffTypeEn,
  String? timeoffTypeTH,
  String? leaveDaysLeft,
  int? availablDays,
  int? approverID,
  String? approveName,
}) =>
    GetLeaveWithRemainingDaysStruct(
      timeOffID: timeOffID,
      timeOffTypeEn: timeOffTypeEn,
      timeoffTypeTH: timeoffTypeTH,
      leaveDaysLeft: leaveDaysLeft,
      availablDays: availablDays,
      approverID: approverID,
      approveName: approveName,
    );
