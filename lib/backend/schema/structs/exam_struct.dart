// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '../core/utils/app_utils.dart';;

class ExamStruct extends BaseStruct {
  ExamStruct({
    String? requestedDate,
    bool? wholeDay,
    String? startDate,
    String? endDate,
    String? oTStartTime,
    String? oTEndTime,
    String? oTHours,
    String? purposeOT,
    bool? saveDraft,
    int? requesterID,
    int? approverID,
    int? companyID,
    List<AttachmentsStruct>? attachments,
    String? oTType,
  })  : _requestedDate = requestedDate,
        _wholeDay = wholeDay,
        _startDate = startDate,
        _endDate = endDate,
        _oTStartTime = oTStartTime,
        _oTEndTime = oTEndTime,
        _oTHours = oTHours,
        _purposeOT = purposeOT,
        _saveDraft = saveDraft,
        _requesterID = requesterID,
        _approverID = approverID,
        _companyID = companyID,
        _attachments = attachments,
        _oTType = oTType;

  // "requestedDate" field.
  String? _requestedDate;
  String get requestedDate => _requestedDate ?? '';
  set requestedDate(String? val) => _requestedDate = val;

  bool hasRequestedDate() => _requestedDate != null;

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

  // "purpose_OT" field.
  String? _purposeOT;
  String get purposeOT => _purposeOT ?? '';
  set purposeOT(String? val) => _purposeOT = val;

  bool hasPurposeOT() => _purposeOT != null;

  // "saveDraft" field.
  bool? _saveDraft;
  bool get saveDraft => _saveDraft ?? false;
  set saveDraft(bool? val) => _saveDraft = val;

  bool hasSaveDraft() => _saveDraft != null;

  // "requester_ID" field.
  int? _requesterID;
  int get requesterID => _requesterID ?? 0;
  set requesterID(int? val) => _requesterID = val;

  void incrementRequesterID(int amount) => requesterID = requesterID + amount;

  bool hasRequesterID() => _requesterID != null;

  // "approver_ID" field.
  int? _approverID;
  int get approverID => _approverID ?? 0;
  set approverID(int? val) => _approverID = val;

  void incrementApproverID(int amount) => approverID = approverID + amount;

  bool hasApproverID() => _approverID != null;

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

  // "oT_Type" field.
  String? _oTType;
  String get oTType => _oTType ?? '';
  set oTType(String? val) => _oTType = val;

  bool hasOTType() => _oTType != null;

  static ExamStruct fromMap(Map<String, dynamic> data) => ExamStruct(
        requestedDate: data['requestedDate'] as String?,
        wholeDay: data['wholeDay'] as bool?,
        startDate: data['start_Date'] as String?,
        endDate: data['end_Date'] as String?,
        oTStartTime: data['oT_Start_Time'] as String?,
        oTEndTime: data['oT_End_Time'] as String?,
        oTHours: data['oT_Hours'] as String?,
        purposeOT: data['purpose_OT'] as String?,
        saveDraft: data['saveDraft'] as bool?,
        requesterID: castToType<int>(data['requester_ID']),
        approverID: castToType<int>(data['approver_ID']),
        companyID: castToType<int>(data['company_ID']),
        attachments: getStructList(
          data['attachments'],
          AttachmentsStruct.fromMap,
        ),
        oTType: data['oT_Type'] as String?,
      );

  static ExamStruct? maybeFromMap(dynamic data) =>
      data is Map ? ExamStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'requestedDate': _requestedDate,
        'wholeDay': _wholeDay,
        'start_Date': _startDate,
        'end_Date': _endDate,
        'oT_Start_Time': _oTStartTime,
        'oT_End_Time': _oTEndTime,
        'oT_Hours': _oTHours,
        'purpose_OT': _purposeOT,
        'saveDraft': _saveDraft,
        'requester_ID': _requesterID,
        'approver_ID': _approverID,
        'company_ID': _companyID,
        'attachments': _attachments?.map((e) => e.toMap()).toList(),
        'oT_Type': _oTType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'requestedDate': serializeParam(
          _requestedDate,
          ParamType.String,
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
        'purpose_OT': serializeParam(
          _purposeOT,
          ParamType.String,
        ),
        'saveDraft': serializeParam(
          _saveDraft,
          ParamType.bool,
        ),
        'requester_ID': serializeParam(
          _requesterID,
          ParamType.int,
        ),
        'approver_ID': serializeParam(
          _approverID,
          ParamType.int,
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
        'oT_Type': serializeParam(
          _oTType,
          ParamType.String,
        ),
      }.withoutNulls;

  static ExamStruct fromSerializableMap(Map<String, dynamic> data) =>
      ExamStruct(
        requestedDate: deserializeParam(
          data['requestedDate'],
          ParamType.String,
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
        purposeOT: deserializeParam(
          data['purpose_OT'],
          ParamType.String,
          false,
        ),
        saveDraft: deserializeParam(
          data['saveDraft'],
          ParamType.bool,
          false,
        ),
        requesterID: deserializeParam(
          data['requester_ID'],
          ParamType.int,
          false,
        ),
        approverID: deserializeParam(
          data['approver_ID'],
          ParamType.int,
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
        oTType: deserializeParam(
          data['oT_Type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ExamStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ExamStruct &&
        requestedDate == other.requestedDate &&
        wholeDay == other.wholeDay &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        oTStartTime == other.oTStartTime &&
        oTEndTime == other.oTEndTime &&
        oTHours == other.oTHours &&
        purposeOT == other.purposeOT &&
        saveDraft == other.saveDraft &&
        requesterID == other.requesterID &&
        approverID == other.approverID &&
        companyID == other.companyID &&
        listEquality.equals(attachments, other.attachments) &&
        oTType == other.oTType;
  }

  @override
  int get hashCode => const ListEquality().hash([
        requestedDate,
        wholeDay,
        startDate,
        endDate,
        oTStartTime,
        oTEndTime,
        oTHours,
        purposeOT,
        saveDraft,
        requesterID,
        approverID,
        companyID,
        attachments,
        oTType
      ]);
}

ExamStruct createExamStruct({
  String? requestedDate,
  bool? wholeDay,
  String? startDate,
  String? endDate,
  String? oTStartTime,
  String? oTEndTime,
  String? oTHours,
  String? purposeOT,
  bool? saveDraft,
  int? requesterID,
  int? approverID,
  int? companyID,
  String? oTType,
}) =>
    ExamStruct(
      requestedDate: requestedDate,
      wholeDay: wholeDay,
      startDate: startDate,
      endDate: endDate,
      oTStartTime: oTStartTime,
      oTEndTime: oTEndTime,
      oTHours: oTHours,
      purposeOT: purposeOT,
      saveDraft: saveDraft,
      requesterID: requesterID,
      approverID: approverID,
      companyID: companyID,
      oTType: oTType,
    );
