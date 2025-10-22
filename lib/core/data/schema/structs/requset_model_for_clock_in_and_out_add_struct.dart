// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class RequsetModelForClockInAndOutAddStruct extends BaseStruct {
  RequsetModelForClockInAndOutAddStruct({
    bool? approve,
    String? clockInLattitude,
    String? clockInLocation,
    String? clockInLongitude,
    String? clockInTime,
    String? clockOutLattitude,
    String? clockOutLocation,
    String? clockOutLongitude,
    String? clockOutTime,
    int? companyID,
    int? employeeID,
    String? irregularInLattitude,
    String? irregularInLocation,
    String? irregularInLongitude,
    String? irregularInTime,
    String? irregularOutLattitude,
    String? irregularOutLongitude,
    String? irregularOutTime,
    String? shftEndTime,
    String? shiftStartTime,
    int? timeID,
    String? timeType,
    int? userID,
  })  : _approve = approve,
        _clockInLattitude = clockInLattitude,
        _clockInLocation = clockInLocation,
        _clockInLongitude = clockInLongitude,
        _clockInTime = clockInTime,
        _clockOutLattitude = clockOutLattitude,
        _clockOutLocation = clockOutLocation,
        _clockOutLongitude = clockOutLongitude,
        _clockOutTime = clockOutTime,
        _companyID = companyID,
        _employeeID = employeeID,
        _irregularInLattitude = irregularInLattitude,
        _irregularInLocation = irregularInLocation,
        _irregularInLongitude = irregularInLongitude,
        _irregularInTime = irregularInTime,
        _irregularOutLattitude = irregularOutLattitude,
        _irregularOutLongitude = irregularOutLongitude,
        _irregularOutTime = irregularOutTime,
        _shftEndTime = shftEndTime,
        _shiftStartTime = shiftStartTime,
        _timeID = timeID,
        _timeType = timeType,
        _userID = userID;

  // "approve" field.
  bool? _approve;
  bool get approve => _approve ?? true;
  set approve(bool? val) => _approve = val;

  bool hasApprove() => _approve != null;

  // "clock_In_Lattitude" field.
  String? _clockInLattitude;
  String get clockInLattitude => _clockInLattitude ?? '-';
  set clockInLattitude(String? val) => _clockInLattitude = val;

  bool hasClockInLattitude() => _clockInLattitude != null;

  // "clock_In_Location" field.
  String? _clockInLocation;
  String get clockInLocation => _clockInLocation ?? '-';
  set clockInLocation(String? val) => _clockInLocation = val;

  bool hasClockInLocation() => _clockInLocation != null;

  // "clock_In_Longitude" field.
  String? _clockInLongitude;
  String get clockInLongitude => _clockInLongitude ?? '-';
  set clockInLongitude(String? val) => _clockInLongitude = val;

  bool hasClockInLongitude() => _clockInLongitude != null;

  // "clock_In_Time" field.
  String? _clockInTime;
  String get clockInTime => _clockInTime ?? '-';
  set clockInTime(String? val) => _clockInTime = val;

  bool hasClockInTime() => _clockInTime != null;

  // "clock_Out_Lattitude" field.
  String? _clockOutLattitude;
  String get clockOutLattitude => _clockOutLattitude ?? '-';
  set clockOutLattitude(String? val) => _clockOutLattitude = val;

  bool hasClockOutLattitude() => _clockOutLattitude != null;

  // "clock_Out_Location" field.
  String? _clockOutLocation;
  String get clockOutLocation => _clockOutLocation ?? '-';
  set clockOutLocation(String? val) => _clockOutLocation = val;

  bool hasClockOutLocation() => _clockOutLocation != null;

  // "clock_Out_Longitude" field.
  String? _clockOutLongitude;
  String get clockOutLongitude => _clockOutLongitude ?? '-';
  set clockOutLongitude(String? val) => _clockOutLongitude = val;

  bool hasClockOutLongitude() => _clockOutLongitude != null;

  // "clock_Out_Time" field.
  String? _clockOutTime;
  String get clockOutTime => _clockOutTime ?? '-';
  set clockOutTime(String? val) => _clockOutTime = val;

  bool hasClockOutTime() => _clockOutTime != null;

  // "company_ID" field.
  int? _companyID;
  int get companyID => _companyID ?? 0;
  set companyID(int? val) => _companyID = val;

  void incrementCompanyID(int amount) => companyID = companyID + amount;

  bool hasCompanyID() => _companyID != null;

  // "employee_ID" field.
  int? _employeeID;
  int get employeeID => _employeeID ?? 0;
  set employeeID(int? val) => _employeeID = val;

  void incrementEmployeeID(int amount) => employeeID = employeeID + amount;

  bool hasEmployeeID() => _employeeID != null;

  // "irregular_In_Lattitude" field.
  String? _irregularInLattitude;
  String get irregularInLattitude => _irregularInLattitude ?? '-';
  set irregularInLattitude(String? val) => _irregularInLattitude = val;

  bool hasIrregularInLattitude() => _irregularInLattitude != null;

  // "irregular_In_Location" field.
  String? _irregularInLocation;
  String get irregularInLocation => _irregularInLocation ?? '-';
  set irregularInLocation(String? val) => _irregularInLocation = val;

  bool hasIrregularInLocation() => _irregularInLocation != null;

  // "irregular_In_Longitude" field.
  String? _irregularInLongitude;
  String get irregularInLongitude => _irregularInLongitude ?? '-';
  set irregularInLongitude(String? val) => _irregularInLongitude = val;

  bool hasIrregularInLongitude() => _irregularInLongitude != null;

  // "irregular_In_Time" field.
  String? _irregularInTime;
  String get irregularInTime => _irregularInTime ?? '-';
  set irregularInTime(String? val) => _irregularInTime = val;

  bool hasIrregularInTime() => _irregularInTime != null;

  // "irregular_Out_Lattitude" field.
  String? _irregularOutLattitude;
  String get irregularOutLattitude => _irregularOutLattitude ?? '-';
  set irregularOutLattitude(String? val) => _irregularOutLattitude = val;

  bool hasIrregularOutLattitude() => _irregularOutLattitude != null;

  // "irregular_Out_Longitude" field.
  String? _irregularOutLongitude;
  String get irregularOutLongitude => _irregularOutLongitude ?? '-';
  set irregularOutLongitude(String? val) => _irregularOutLongitude = val;

  bool hasIrregularOutLongitude() => _irregularOutLongitude != null;

  // "irregular_Out_Time" field.
  String? _irregularOutTime;
  String get irregularOutTime => _irregularOutTime ?? '-';
  set irregularOutTime(String? val) => _irregularOutTime = val;

  bool hasIrregularOutTime() => _irregularOutTime != null;

  // "shft_EndTime" field.
  String? _shftEndTime;
  String get shftEndTime => _shftEndTime ?? '-';
  set shftEndTime(String? val) => _shftEndTime = val;

  bool hasShftEndTime() => _shftEndTime != null;

  // "shift_StartTime" field.
  String? _shiftStartTime;
  String get shiftStartTime => _shiftStartTime ?? '-';
  set shiftStartTime(String? val) => _shiftStartTime = val;

  bool hasShiftStartTime() => _shiftStartTime != null;

  // "time_ID" field.
  int? _timeID;
  int get timeID => _timeID ?? 0;
  set timeID(int? val) => _timeID = val;

  void incrementTimeID(int amount) => timeID = timeID + amount;

  bool hasTimeID() => _timeID != null;

  // "time_Type" field.
  String? _timeType;
  String get timeType => _timeType ?? 'Regular';
  set timeType(String? val) => _timeType = val;

  bool hasTimeType() => _timeType != null;

  // "user_ID" field.
  int? _userID;
  int get userID => _userID ?? 0;
  set userID(int? val) => _userID = val;

  void incrementUserID(int amount) => userID = userID + amount;

  bool hasUserID() => _userID != null;

  static RequsetModelForClockInAndOutAddStruct fromMap(
          Map<String, dynamic> data) =>
      RequsetModelForClockInAndOutAddStruct(
        approve: data['approve'] as bool?,
        clockInLattitude: data['clock_In_Lattitude'] as String?,
        clockInLocation: data['clock_In_Location'] as String?,
        clockInLongitude: data['clock_In_Longitude'] as String?,
        clockInTime: data['clock_In_Time'] as String?,
        clockOutLattitude: data['clock_Out_Lattitude'] as String?,
        clockOutLocation: data['clock_Out_Location'] as String?,
        clockOutLongitude: data['clock_Out_Longitude'] as String?,
        clockOutTime: data['clock_Out_Time'] as String?,
        companyID: castToType<int>(data['company_ID']),
        employeeID: castToType<int>(data['employee_ID']),
        irregularInLattitude: data['irregular_In_Lattitude'] as String?,
        irregularInLocation: data['irregular_In_Location'] as String?,
        irregularInLongitude: data['irregular_In_Longitude'] as String?,
        irregularInTime: data['irregular_In_Time'] as String?,
        irregularOutLattitude: data['irregular_Out_Lattitude'] as String?,
        irregularOutLongitude: data['irregular_Out_Longitude'] as String?,
        irregularOutTime: data['irregular_Out_Time'] as String?,
        shftEndTime: data['shft_EndTime'] as String?,
        shiftStartTime: data['shift_StartTime'] as String?,
        timeID: castToType<int>(data['time_ID']),
        timeType: data['time_Type'] as String?,
        userID: castToType<int>(data['user_ID']),
      );

  static RequsetModelForClockInAndOutAddStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? RequsetModelForClockInAndOutAddStruct.fromMap(
              data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'approve': _approve,
        'clock_In_Lattitude': _clockInLattitude,
        'clock_In_Location': _clockInLocation,
        'clock_In_Longitude': _clockInLongitude,
        'clock_In_Time': _clockInTime,
        'clock_Out_Lattitude': _clockOutLattitude,
        'clock_Out_Location': _clockOutLocation,
        'clock_Out_Longitude': _clockOutLongitude,
        'clock_Out_Time': _clockOutTime,
        'company_ID': _companyID,
        'employee_ID': _employeeID,
        'irregular_In_Lattitude': _irregularInLattitude,
        'irregular_In_Location': _irregularInLocation,
        'irregular_In_Longitude': _irregularInLongitude,
        'irregular_In_Time': _irregularInTime,
        'irregular_Out_Lattitude': _irregularOutLattitude,
        'irregular_Out_Longitude': _irregularOutLongitude,
        'irregular_Out_Time': _irregularOutTime,
        'shft_EndTime': _shftEndTime,
        'shift_StartTime': _shiftStartTime,
        'time_ID': _timeID,
        'time_Type': _timeType,
        'user_ID': _userID,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'approve': serializeParam(
          _approve,
          ParamType.bool,
        ),
        'clock_In_Lattitude': serializeParam(
          _clockInLattitude,
          ParamType.String,
        ),
        'clock_In_Location': serializeParam(
          _clockInLocation,
          ParamType.String,
        ),
        'clock_In_Longitude': serializeParam(
          _clockInLongitude,
          ParamType.String,
        ),
        'clock_In_Time': serializeParam(
          _clockInTime,
          ParamType.String,
        ),
        'clock_Out_Lattitude': serializeParam(
          _clockOutLattitude,
          ParamType.String,
        ),
        'clock_Out_Location': serializeParam(
          _clockOutLocation,
          ParamType.String,
        ),
        'clock_Out_Longitude': serializeParam(
          _clockOutLongitude,
          ParamType.String,
        ),
        'clock_Out_Time': serializeParam(
          _clockOutTime,
          ParamType.String,
        ),
        'company_ID': serializeParam(
          _companyID,
          ParamType.int,
        ),
        'employee_ID': serializeParam(
          _employeeID,
          ParamType.int,
        ),
        'irregular_In_Lattitude': serializeParam(
          _irregularInLattitude,
          ParamType.String,
        ),
        'irregular_In_Location': serializeParam(
          _irregularInLocation,
          ParamType.String,
        ),
        'irregular_In_Longitude': serializeParam(
          _irregularInLongitude,
          ParamType.String,
        ),
        'irregular_In_Time': serializeParam(
          _irregularInTime,
          ParamType.String,
        ),
        'irregular_Out_Lattitude': serializeParam(
          _irregularOutLattitude,
          ParamType.String,
        ),
        'irregular_Out_Longitude': serializeParam(
          _irregularOutLongitude,
          ParamType.String,
        ),
        'irregular_Out_Time': serializeParam(
          _irregularOutTime,
          ParamType.String,
        ),
        'shft_EndTime': serializeParam(
          _shftEndTime,
          ParamType.String,
        ),
        'shift_StartTime': serializeParam(
          _shiftStartTime,
          ParamType.String,
        ),
        'time_ID': serializeParam(
          _timeID,
          ParamType.int,
        ),
        'time_Type': serializeParam(
          _timeType,
          ParamType.String,
        ),
        'user_ID': serializeParam(
          _userID,
          ParamType.int,
        ),
      }.withoutNulls;

  static RequsetModelForClockInAndOutAddStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RequsetModelForClockInAndOutAddStruct(
        approve: deserializeParam(
          data['approve'],
          ParamType.bool,
          false,
        ),
        clockInLattitude: deserializeParam(
          data['clock_In_Lattitude'],
          ParamType.String,
          false,
        ),
        clockInLocation: deserializeParam(
          data['clock_In_Location'],
          ParamType.String,
          false,
        ),
        clockInLongitude: deserializeParam(
          data['clock_In_Longitude'],
          ParamType.String,
          false,
        ),
        clockInTime: deserializeParam(
          data['clock_In_Time'],
          ParamType.String,
          false,
        ),
        clockOutLattitude: deserializeParam(
          data['clock_Out_Lattitude'],
          ParamType.String,
          false,
        ),
        clockOutLocation: deserializeParam(
          data['clock_Out_Location'],
          ParamType.String,
          false,
        ),
        clockOutLongitude: deserializeParam(
          data['clock_Out_Longitude'],
          ParamType.String,
          false,
        ),
        clockOutTime: deserializeParam(
          data['clock_Out_Time'],
          ParamType.String,
          false,
        ),
        companyID: deserializeParam(
          data['company_ID'],
          ParamType.int,
          false,
        ),
        employeeID: deserializeParam(
          data['employee_ID'],
          ParamType.int,
          false,
        ),
        irregularInLattitude: deserializeParam(
          data['irregular_In_Lattitude'],
          ParamType.String,
          false,
        ),
        irregularInLocation: deserializeParam(
          data['irregular_In_Location'],
          ParamType.String,
          false,
        ),
        irregularInLongitude: deserializeParam(
          data['irregular_In_Longitude'],
          ParamType.String,
          false,
        ),
        irregularInTime: deserializeParam(
          data['irregular_In_Time'],
          ParamType.String,
          false,
        ),
        irregularOutLattitude: deserializeParam(
          data['irregular_Out_Lattitude'],
          ParamType.String,
          false,
        ),
        irregularOutLongitude: deserializeParam(
          data['irregular_Out_Longitude'],
          ParamType.String,
          false,
        ),
        irregularOutTime: deserializeParam(
          data['irregular_Out_Time'],
          ParamType.String,
          false,
        ),
        shftEndTime: deserializeParam(
          data['shft_EndTime'],
          ParamType.String,
          false,
        ),
        shiftStartTime: deserializeParam(
          data['shift_StartTime'],
          ParamType.String,
          false,
        ),
        timeID: deserializeParam(
          data['time_ID'],
          ParamType.int,
          false,
        ),
        timeType: deserializeParam(
          data['time_Type'],
          ParamType.String,
          false,
        ),
        userID: deserializeParam(
          data['user_ID'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'RequsetModelForClockInAndOutAddStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RequsetModelForClockInAndOutAddStruct &&
        approve == other.approve &&
        clockInLattitude == other.clockInLattitude &&
        clockInLocation == other.clockInLocation &&
        clockInLongitude == other.clockInLongitude &&
        clockInTime == other.clockInTime &&
        clockOutLattitude == other.clockOutLattitude &&
        clockOutLocation == other.clockOutLocation &&
        clockOutLongitude == other.clockOutLongitude &&
        clockOutTime == other.clockOutTime &&
        companyID == other.companyID &&
        employeeID == other.employeeID &&
        irregularInLattitude == other.irregularInLattitude &&
        irregularInLocation == other.irregularInLocation &&
        irregularInLongitude == other.irregularInLongitude &&
        irregularInTime == other.irregularInTime &&
        irregularOutLattitude == other.irregularOutLattitude &&
        irregularOutLongitude == other.irregularOutLongitude &&
        irregularOutTime == other.irregularOutTime &&
        shftEndTime == other.shftEndTime &&
        shiftStartTime == other.shiftStartTime &&
        timeID == other.timeID &&
        timeType == other.timeType &&
        userID == other.userID;
  }

  @override
  int get hashCode => const ListEquality().hash([
        approve,
        clockInLattitude,
        clockInLocation,
        clockInLongitude,
        clockInTime,
        clockOutLattitude,
        clockOutLocation,
        clockOutLongitude,
        clockOutTime,
        companyID,
        employeeID,
        irregularInLattitude,
        irregularInLocation,
        irregularInLongitude,
        irregularInTime,
        irregularOutLattitude,
        irregularOutLongitude,
        irregularOutTime,
        shftEndTime,
        shiftStartTime,
        timeID,
        timeType,
        userID
      ]);
}

RequsetModelForClockInAndOutAddStruct
    createRequsetModelForClockInAndOutAddStruct({
  bool? approve,
  String? clockInLattitude,
  String? clockInLocation,
  String? clockInLongitude,
  String? clockInTime,
  String? clockOutLattitude,
  String? clockOutLocation,
  String? clockOutLongitude,
  String? clockOutTime,
  int? companyID,
  int? employeeID,
  String? irregularInLattitude,
  String? irregularInLocation,
  String? irregularInLongitude,
  String? irregularInTime,
  String? irregularOutLattitude,
  String? irregularOutLongitude,
  String? irregularOutTime,
  String? shftEndTime,
  String? shiftStartTime,
  int? timeID,
  String? timeType,
  int? userID,
}) =>
        RequsetModelForClockInAndOutAddStruct(
          approve: approve,
          clockInLattitude: clockInLattitude,
          clockInLocation: clockInLocation,
          clockInLongitude: clockInLongitude,
          clockInTime: clockInTime,
          clockOutLattitude: clockOutLattitude,
          clockOutLocation: clockOutLocation,
          clockOutLongitude: clockOutLongitude,
          clockOutTime: clockOutTime,
          companyID: companyID,
          employeeID: employeeID,
          irregularInLattitude: irregularInLattitude,
          irregularInLocation: irregularInLocation,
          irregularInLongitude: irregularInLongitude,
          irregularInTime: irregularInTime,
          irregularOutLattitude: irregularOutLattitude,
          irregularOutLongitude: irregularOutLongitude,
          irregularOutTime: irregularOutTime,
          shftEndTime: shftEndTime,
          shiftStartTime: shiftStartTime,
          timeID: timeID,
          timeType: timeType,
          userID: userID,
        );
