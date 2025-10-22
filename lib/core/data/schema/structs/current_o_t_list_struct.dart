// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '../core/utils/app_utils.dart';;

class CurrentOTListStruct extends BaseStruct {
  CurrentOTListStruct({
    int? oTRequestID,
    int? clockID,
    String? startDate,
    String? endDate,
    String? oTStartTime,
    String? oTEndTime,
    String? oTHours,
    String? oTRequestedDate,
    String? purposeOT,
    String? approvername,
    String? status,
    List<AttachmentlistStruct>? attachmentlist,
    int? wFID,
    String? checkInStatus,
    String? clockInTime,
    String? clockOutTime,
  })  : _oTRequestID = oTRequestID,
        _clockID = clockID,
        _startDate = startDate,
        _endDate = endDate,
        _oTStartTime = oTStartTime,
        _oTEndTime = oTEndTime,
        _oTHours = oTHours,
        _oTRequestedDate = oTRequestedDate,
        _purposeOT = purposeOT,
        _approvername = approvername,
        _status = status,
        _attachmentlist = attachmentlist,
        _wFID = wFID,
        _checkInStatus = checkInStatus,
        _clockInTime = clockInTime,
        _clockOutTime = clockOutTime;

  // "oT_Request_ID" field.
  int? _oTRequestID;
  int get oTRequestID => _oTRequestID ?? 0;
  set oTRequestID(int? val) => _oTRequestID = val;

  void incrementOTRequestID(int amount) => oTRequestID = oTRequestID + amount;

  bool hasOTRequestID() => _oTRequestID != null;

  // "clock_ID" field.
  int? _clockID;
  int get clockID => _clockID ?? 0;
  set clockID(int? val) => _clockID = val;

  void incrementClockID(int amount) => clockID = clockID + amount;

  bool hasClockID() => _clockID != null;

  // "start_Date" field.
  String? _startDate;
  String get startDate => _startDate ?? '';
  set startDate(String? val) => _startDate = val;

  bool hasStartDate() => _startDate != null;

  // "end_Date" field.
  String? _endDate;
  String get endDate => _endDate ?? '';
  set endDate(String? val) => _endDate = val;

  bool hasEndDate() => _endDate != null;

  // "oT_Start_Time" field.
  String? _oTStartTime;
  String get oTStartTime => _oTStartTime ?? '';
  set oTStartTime(String? val) => _oTStartTime = val;

  bool hasOTStartTime() => _oTStartTime != null;

  // "oT_End_Time" field.
  String? _oTEndTime;
  String get oTEndTime => _oTEndTime ?? '';
  set oTEndTime(String? val) => _oTEndTime = val;

  bool hasOTEndTime() => _oTEndTime != null;

  // "oT_Hours" field.
  String? _oTHours;
  String get oTHours => _oTHours ?? '';
  set oTHours(String? val) => _oTHours = val;

  bool hasOTHours() => _oTHours != null;

  // "oT_Requested_Date" field.
  String? _oTRequestedDate;
  String get oTRequestedDate => _oTRequestedDate ?? '';
  set oTRequestedDate(String? val) => _oTRequestedDate = val;

  bool hasOTRequestedDate() => _oTRequestedDate != null;

  // "purpose_OT" field.
  String? _purposeOT;
  String get purposeOT => _purposeOT ?? '';
  set purposeOT(String? val) => _purposeOT = val;

  bool hasPurposeOT() => _purposeOT != null;

  // "approvername" field.
  String? _approvername;
  String get approvername => _approvername ?? '';
  set approvername(String? val) => _approvername = val;

  bool hasApprovername() => _approvername != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "attachmentlist" field.
  List<AttachmentlistStruct>? _attachmentlist;
  List<AttachmentlistStruct> get attachmentlist => _attachmentlist ?? const [];
  set attachmentlist(List<AttachmentlistStruct>? val) => _attachmentlist = val;

  void updateAttachmentlist(Function(List<AttachmentlistStruct>) updateFn) {
    updateFn(_attachmentlist ??= []);
  }

  bool hasAttachmentlist() => _attachmentlist != null;

  // "wF_ID" field.
  int? _wFID;
  int get wFID => _wFID ?? 0;
  set wFID(int? val) => _wFID = val;

  void incrementWFID(int amount) => wFID = wFID + amount;

  bool hasWFID() => _wFID != null;

  // "checkInStatus" field.
  String? _checkInStatus;
  String get checkInStatus => _checkInStatus ?? '';
  set checkInStatus(String? val) => _checkInStatus = val;

  bool hasCheckInStatus() => _checkInStatus != null;

  // "clock_In_Time" field.
  String? _clockInTime;
  String get clockInTime => _clockInTime ?? '';
  set clockInTime(String? val) => _clockInTime = val;

  bool hasClockInTime() => _clockInTime != null;

  // "clock_Out_Time" field.
  String? _clockOutTime;
  String get clockOutTime => _clockOutTime ?? '';
  set clockOutTime(String? val) => _clockOutTime = val;

  bool hasClockOutTime() => _clockOutTime != null;

  static CurrentOTListStruct fromMap(Map<String, dynamic> data) =>
      CurrentOTListStruct(
        oTRequestID: castToType<int>(data['oT_Request_ID']),
        clockID: castToType<int>(data['clock_ID']),
        startDate: data['start_Date'] as String?,
        endDate: data['end_Date'] as String?,
        oTStartTime: data['oT_Start_Time'] as String?,
        oTEndTime: data['oT_End_Time'] as String?,
        oTHours: data['oT_Hours'] as String?,
        oTRequestedDate: data['oT_Requested_Date'] as String?,
        purposeOT: data['purpose_OT'] as String?,
        approvername: data['approvername'] as String?,
        status: data['status'] as String?,
        attachmentlist: getStructList(
          data['attachmentlist'],
          AttachmentlistStruct.fromMap,
        ),
        wFID: castToType<int>(data['wF_ID']),
        checkInStatus: data['checkInStatus'] as String?,
        clockInTime: data['clock_In_Time'] as String?,
        clockOutTime: data['clock_Out_Time'] as String?,
      );

  static CurrentOTListStruct? maybeFromMap(dynamic data) => data is Map
      ? CurrentOTListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'oT_Request_ID': _oTRequestID,
        'clock_ID': _clockID,
        'start_Date': _startDate,
        'end_Date': _endDate,
        'oT_Start_Time': _oTStartTime,
        'oT_End_Time': _oTEndTime,
        'oT_Hours': _oTHours,
        'oT_Requested_Date': _oTRequestedDate,
        'purpose_OT': _purposeOT,
        'approvername': _approvername,
        'status': _status,
        'attachmentlist': _attachmentlist?.map((e) => e.toMap()).toList(),
        'wF_ID': _wFID,
        'checkInStatus': _checkInStatus,
        'clock_In_Time': _clockInTime,
        'clock_Out_Time': _clockOutTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'oT_Request_ID': serializeParam(
          _oTRequestID,
          ParamType.int,
        ),
        'clock_ID': serializeParam(
          _clockID,
          ParamType.int,
        ),
        'start_Date': serializeParam(
          _startDate,
          ParamType.String,
        ),
        'end_Date': serializeParam(
          _endDate,
          ParamType.String,
        ),
        'oT_Start_Time': serializeParam(
          _oTStartTime,
          ParamType.String,
        ),
        'oT_End_Time': serializeParam(
          _oTEndTime,
          ParamType.String,
        ),
        'oT_Hours': serializeParam(
          _oTHours,
          ParamType.String,
        ),
        'oT_Requested_Date': serializeParam(
          _oTRequestedDate,
          ParamType.String,
        ),
        'purpose_OT': serializeParam(
          _purposeOT,
          ParamType.String,
        ),
        'approvername': serializeParam(
          _approvername,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'attachmentlist': serializeParam(
          _attachmentlist,
          ParamType.DataStruct,
          isList: true,
        ),
        'wF_ID': serializeParam(
          _wFID,
          ParamType.int,
        ),
        'checkInStatus': serializeParam(
          _checkInStatus,
          ParamType.String,
        ),
        'clock_In_Time': serializeParam(
          _clockInTime,
          ParamType.String,
        ),
        'clock_Out_Time': serializeParam(
          _clockOutTime,
          ParamType.String,
        ),
      }.withoutNulls;

  static CurrentOTListStruct fromSerializableMap(Map<String, dynamic> data) =>
      CurrentOTListStruct(
        oTRequestID: deserializeParam(
          data['oT_Request_ID'],
          ParamType.int,
          false,
        ),
        clockID: deserializeParam(
          data['clock_ID'],
          ParamType.int,
          false,
        ),
        startDate: deserializeParam(
          data['start_Date'],
          ParamType.String,
          false,
        ),
        endDate: deserializeParam(
          data['end_Date'],
          ParamType.String,
          false,
        ),
        oTStartTime: deserializeParam(
          data['oT_Start_Time'],
          ParamType.String,
          false,
        ),
        oTEndTime: deserializeParam(
          data['oT_End_Time'],
          ParamType.String,
          false,
        ),
        oTHours: deserializeParam(
          data['oT_Hours'],
          ParamType.String,
          false,
        ),
        oTRequestedDate: deserializeParam(
          data['oT_Requested_Date'],
          ParamType.String,
          false,
        ),
        purposeOT: deserializeParam(
          data['purpose_OT'],
          ParamType.String,
          false,
        ),
        approvername: deserializeParam(
          data['approvername'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        attachmentlist: deserializeStructParam<AttachmentlistStruct>(
          data['attachmentlist'],
          ParamType.DataStruct,
          true,
          structBuilder: AttachmentlistStruct.fromSerializableMap,
        ),
        wFID: deserializeParam(
          data['wF_ID'],
          ParamType.int,
          false,
        ),
        checkInStatus: deserializeParam(
          data['checkInStatus'],
          ParamType.String,
          false,
        ),
        clockInTime: deserializeParam(
          data['clock_In_Time'],
          ParamType.String,
          false,
        ),
        clockOutTime: deserializeParam(
          data['clock_Out_Time'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CurrentOTListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CurrentOTListStruct &&
        oTRequestID == other.oTRequestID &&
        clockID == other.clockID &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        oTStartTime == other.oTStartTime &&
        oTEndTime == other.oTEndTime &&
        oTHours == other.oTHours &&
        oTRequestedDate == other.oTRequestedDate &&
        purposeOT == other.purposeOT &&
        approvername == other.approvername &&
        status == other.status &&
        listEquality.equals(attachmentlist, other.attachmentlist) &&
        wFID == other.wFID &&
        checkInStatus == other.checkInStatus &&
        clockInTime == other.clockInTime &&
        clockOutTime == other.clockOutTime;
  }

  @override
  int get hashCode => const ListEquality().hash([
        oTRequestID,
        clockID,
        startDate,
        endDate,
        oTStartTime,
        oTEndTime,
        oTHours,
        oTRequestedDate,
        purposeOT,
        approvername,
        status,
        attachmentlist,
        wFID,
        checkInStatus,
        clockInTime,
        clockOutTime
      ]);
}

CurrentOTListStruct createCurrentOTListStruct({
  int? oTRequestID,
  int? clockID,
  String? startDate,
  String? endDate,
  String? oTStartTime,
  String? oTEndTime,
  String? oTHours,
  String? oTRequestedDate,
  String? purposeOT,
  String? approvername,
  String? status,
  int? wFID,
  String? checkInStatus,
  String? clockInTime,
  String? clockOutTime,
}) =>
    CurrentOTListStruct(
      oTRequestID: oTRequestID,
      clockID: clockID,
      startDate: startDate,
      endDate: endDate,
      oTStartTime: oTStartTime,
      oTEndTime: oTEndTime,
      oTHours: oTHours,
      oTRequestedDate: oTRequestedDate,
      purposeOT: purposeOT,
      approvername: approvername,
      status: status,
      wFID: wFID,
      checkInStatus: checkInStatus,
      clockInTime: clockInTime,
      clockOutTime: clockOutTime,
    );
