// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '../core/utils/app_utils.dart';;

class UpdateLeaveRequestStruct extends BaseStruct {
  UpdateLeaveRequestStruct({
    int? timeOffRequestID,
    int? timeoffID,
    bool? wholeDay,
    String? startDate,
    String? endDate,
    String? oTRequestedDate,
    String? startTime,
    String? endTime,
    String? message,
    String? balance,
    bool? saveDraft,
    int? companyID,
    List<AttachmentsStruct>? attachments,
  })  : _timeOffRequestID = timeOffRequestID,
        _timeoffID = timeoffID,
        _wholeDay = wholeDay,
        _startDate = startDate,
        _endDate = endDate,
        _oTRequestedDate = oTRequestedDate,
        _startTime = startTime,
        _endTime = endTime,
        _message = message,
        _balance = balance,
        _saveDraft = saveDraft,
        _companyID = companyID,
        _attachments = attachments;

  // "time_off_RequestID" field.
  int? _timeOffRequestID;
  int get timeOffRequestID => _timeOffRequestID ?? 0;
  set timeOffRequestID(int? val) => _timeOffRequestID = val;

  void incrementTimeOffRequestID(int amount) =>
      timeOffRequestID = timeOffRequestID + amount;

  bool hasTimeOffRequestID() => _timeOffRequestID != null;

  // "timeoff_ID" field.
  int? _timeoffID;
  int get timeoffID => _timeoffID ?? 0;
  set timeoffID(int? val) => _timeoffID = val;

  void incrementTimeoffID(int amount) => timeoffID = timeoffID + amount;

  bool hasTimeoffID() => _timeoffID != null;

  // "wholeDay" field.
  bool? _wholeDay;
  bool get wholeDay => _wholeDay ?? false;
  set wholeDay(bool? val) => _wholeDay = val;

  bool hasWholeDay() => _wholeDay != null;

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

  // "oT_Requested_Date" field.
  String? _oTRequestedDate;
  String get oTRequestedDate => _oTRequestedDate ?? '';
  set oTRequestedDate(String? val) => _oTRequestedDate = val;

  bool hasOTRequestedDate() => _oTRequestedDate != null;

  // "start_Time" field.
  String? _startTime;
  String get startTime => _startTime ?? '';
  set startTime(String? val) => _startTime = val;

  bool hasStartTime() => _startTime != null;

  // "end_Time" field.
  String? _endTime;
  String get endTime => _endTime ?? '';
  set endTime(String? val) => _endTime = val;

  bool hasEndTime() => _endTime != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "balance" field.
  String? _balance;
  String get balance => _balance ?? '';
  set balance(String? val) => _balance = val;

  bool hasBalance() => _balance != null;

  // "saveDraft" field.
  bool? _saveDraft;
  bool get saveDraft => _saveDraft ?? false;
  set saveDraft(bool? val) => _saveDraft = val;

  bool hasSaveDraft() => _saveDraft != null;

  // "company_ID" field.
  int? _companyID;
  int get companyID => _companyID ?? 0;
  set companyID(int? val) => _companyID = val;

  void incrementCompanyID(int amount) => companyID = companyID + amount;

  bool hasCompanyID() => _companyID != null;

  // "attachments" field.
  List<AttachmentsStruct>? _attachments;
  List<AttachmentsStruct> get attachments => _attachments ?? const [];
  set attachments(List<AttachmentsStruct>? val) => _attachments = val;

  void updateAttachments(Function(List<AttachmentsStruct>) updateFn) {
    updateFn(_attachments ??= []);
  }

  bool hasAttachments() => _attachments != null;

  static UpdateLeaveRequestStruct fromMap(Map<String, dynamic> data) =>
      UpdateLeaveRequestStruct(
        timeOffRequestID: castToType<int>(data['time_off_RequestID']),
        timeoffID: castToType<int>(data['timeoff_ID']),
        wholeDay: data['wholeDay'] as bool?,
        startDate: data['start_Date'] as String?,
        endDate: data['end_Date'] as String?,
        oTRequestedDate: data['oT_Requested_Date'] as String?,
        startTime: data['start_Time'] as String?,
        endTime: data['end_Time'] as String?,
        message: data['message'] as String?,
        balance: data['balance'] as String?,
        saveDraft: data['saveDraft'] as bool?,
        companyID: castToType<int>(data['company_ID']),
        attachments: getStructList(
          data['attachments'],
          AttachmentsStruct.fromMap,
        ),
      );

  static UpdateLeaveRequestStruct? maybeFromMap(dynamic data) => data is Map
      ? UpdateLeaveRequestStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'time_off_RequestID': _timeOffRequestID,
        'timeoff_ID': _timeoffID,
        'wholeDay': _wholeDay,
        'start_Date': _startDate,
        'end_Date': _endDate,
        'oT_Requested_Date': _oTRequestedDate,
        'start_Time': _startTime,
        'end_Time': _endTime,
        'message': _message,
        'balance': _balance,
        'saveDraft': _saveDraft,
        'company_ID': _companyID,
        'attachments': _attachments?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'time_off_RequestID': serializeParam(
          _timeOffRequestID,
          ParamType.int,
        ),
        'timeoff_ID': serializeParam(
          _timeoffID,
          ParamType.int,
        ),
        'wholeDay': serializeParam(
          _wholeDay,
          ParamType.bool,
        ),
        'start_Date': serializeParam(
          _startDate,
          ParamType.String,
        ),
        'end_Date': serializeParam(
          _endDate,
          ParamType.String,
        ),
        'oT_Requested_Date': serializeParam(
          _oTRequestedDate,
          ParamType.String,
        ),
        'start_Time': serializeParam(
          _startTime,
          ParamType.String,
        ),
        'end_Time': serializeParam(
          _endTime,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'balance': serializeParam(
          _balance,
          ParamType.String,
        ),
        'saveDraft': serializeParam(
          _saveDraft,
          ParamType.bool,
        ),
        'company_ID': serializeParam(
          _companyID,
          ParamType.int,
        ),
        'attachments': serializeParam(
          _attachments,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static UpdateLeaveRequestStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      UpdateLeaveRequestStruct(
        timeOffRequestID: deserializeParam(
          data['time_off_RequestID'],
          ParamType.int,
          false,
        ),
        timeoffID: deserializeParam(
          data['timeoff_ID'],
          ParamType.int,
          false,
        ),
        wholeDay: deserializeParam(
          data['wholeDay'],
          ParamType.bool,
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
        oTRequestedDate: deserializeParam(
          data['oT_Requested_Date'],
          ParamType.String,
          false,
        ),
        startTime: deserializeParam(
          data['start_Time'],
          ParamType.String,
          false,
        ),
        endTime: deserializeParam(
          data['end_Time'],
          ParamType.String,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        balance: deserializeParam(
          data['balance'],
          ParamType.String,
          false,
        ),
        saveDraft: deserializeParam(
          data['saveDraft'],
          ParamType.bool,
          false,
        ),
        companyID: deserializeParam(
          data['company_ID'],
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
  String toString() => 'UpdateLeaveRequestStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is UpdateLeaveRequestStruct &&
        timeOffRequestID == other.timeOffRequestID &&
        timeoffID == other.timeoffID &&
        wholeDay == other.wholeDay &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        oTRequestedDate == other.oTRequestedDate &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        message == other.message &&
        balance == other.balance &&
        saveDraft == other.saveDraft &&
        companyID == other.companyID &&
        listEquality.equals(attachments, other.attachments);
  }

  @override
  int get hashCode => const ListEquality().hash([
        timeOffRequestID,
        timeoffID,
        wholeDay,
        startDate,
        endDate,
        oTRequestedDate,
        startTime,
        endTime,
        message,
        balance,
        saveDraft,
        companyID,
        attachments
      ]);
}

UpdateLeaveRequestStruct createUpdateLeaveRequestStruct({
  int? timeOffRequestID,
  int? timeoffID,
  bool? wholeDay,
  String? startDate,
  String? endDate,
  String? oTRequestedDate,
  String? startTime,
  String? endTime,
  String? message,
  String? balance,
  bool? saveDraft,
  int? companyID,
}) =>
    UpdateLeaveRequestStruct(
      timeOffRequestID: timeOffRequestID,
      timeoffID: timeoffID,
      wholeDay: wholeDay,
      startDate: startDate,
      endDate: endDate,
      oTRequestedDate: oTRequestedDate,
      startTime: startTime,
      endTime: endTime,
      message: message,
      balance: balance,
      saveDraft: saveDraft,
      companyID: companyID,
    );
