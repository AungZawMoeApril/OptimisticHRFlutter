// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class OTCheckInReqStruct extends BaseStruct {
  OTCheckInReqStruct({
    String? theDate,
    String? clockInTime,
    int? employeeID,
    int? companyID,
    int? userID,
    List<String>? attachments,
  })  : _theDate = theDate,
        _clockInTime = clockInTime,
        _employeeID = employeeID,
        _companyID = companyID,
        _userID = userID,
        _attachments = attachments;

  // "the_Date" field.
  String? _theDate;
  String get theDate => _theDate ?? '';
  set theDate(String? val) => _theDate = val;

  bool hasTheDate() => _theDate != null;

  // "clock_In_Time" field.
  String? _clockInTime;
  String get clockInTime => _clockInTime ?? '';
  set clockInTime(String? val) => _clockInTime = val;

  bool hasClockInTime() => _clockInTime != null;

  // "employee_ID" field.
  int? _employeeID;
  int get employeeID => _employeeID ?? 0;
  set employeeID(int? val) => _employeeID = val;

  void incrementEmployeeID(int amount) => employeeID = employeeID + amount;

  bool hasEmployeeID() => _employeeID != null;

  // "company_ID" field.
  int? _companyID;
  int get companyID => _companyID ?? 0;
  set companyID(int? val) => _companyID = val;

  void incrementCompanyID(int amount) => companyID = companyID + amount;

  bool hasCompanyID() => _companyID != null;

  // "user_ID" field.
  int? _userID;
  int get userID => _userID ?? 0;
  set userID(int? val) => _userID = val;

  void incrementUserID(int amount) => userID = userID + amount;

  bool hasUserID() => _userID != null;

  // "attachments" field.
  List<String>? _attachments;
  List<String> get attachments => _attachments ?? const [];
  set attachments(List<String>? val) => _attachments = val;

  void updateAttachments(Function(List<String>) updateFn) {
    updateFn(_attachments ??= []);
  }

  bool hasAttachments() => _attachments != null;

  static OTCheckInReqStruct fromMap(Map<String, dynamic> data) =>
      OTCheckInReqStruct(
        theDate: data['the_Date'] as String?,
        clockInTime: data['clock_In_Time'] as String?,
        employeeID: castToType<int>(data['employee_ID']),
        companyID: castToType<int>(data['company_ID']),
        userID: castToType<int>(data['user_ID']),
        attachments: getDataList(data['attachments']),
      );

  static OTCheckInReqStruct? maybeFromMap(dynamic data) => data is Map
      ? OTCheckInReqStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'the_Date': _theDate,
        'clock_In_Time': _clockInTime,
        'employee_ID': _employeeID,
        'company_ID': _companyID,
        'user_ID': _userID,
        'attachments': _attachments,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'the_Date': serializeParam(
          _theDate,
          ParamType.String,
        ),
        'clock_In_Time': serializeParam(
          _clockInTime,
          ParamType.String,
        ),
        'employee_ID': serializeParam(
          _employeeID,
          ParamType.int,
        ),
        'company_ID': serializeParam(
          _companyID,
          ParamType.int,
        ),
        'user_ID': serializeParam(
          _userID,
          ParamType.int,
        ),
        'attachments': serializeParam(
          _attachments,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static OTCheckInReqStruct fromSerializableMap(Map<String, dynamic> data) =>
      OTCheckInReqStruct(
        theDate: deserializeParam(
          data['the_Date'],
          ParamType.String,
          false,
        ),
        clockInTime: deserializeParam(
          data['clock_In_Time'],
          ParamType.String,
          false,
        ),
        employeeID: deserializeParam(
          data['employee_ID'],
          ParamType.int,
          false,
        ),
        companyID: deserializeParam(
          data['company_ID'],
          ParamType.int,
          false,
        ),
        userID: deserializeParam(
          data['user_ID'],
          ParamType.int,
          false,
        ),
        attachments: deserializeParam<String>(
          data['attachments'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'OTCheckInReqStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is OTCheckInReqStruct &&
        theDate == other.theDate &&
        clockInTime == other.clockInTime &&
        employeeID == other.employeeID &&
        companyID == other.companyID &&
        userID == other.userID &&
        listEquality.equals(attachments, other.attachments);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([theDate, clockInTime, employeeID, companyID, userID, attachments]);
}

OTCheckInReqStruct createOTCheckInReqStruct({
  String? theDate,
  String? clockInTime,
  int? employeeID,
  int? companyID,
  int? userID,
}) =>
    OTCheckInReqStruct(
      theDate: theDate,
      clockInTime: clockInTime,
      employeeID: employeeID,
      companyID: companyID,
      userID: userID,
    );
