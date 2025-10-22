// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class ReqStaffOTRequestStruct extends BaseStruct {
  ReqStaffOTRequestStruct({
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
    int? approverID2,
    int? approverID3,
    int? approverID4,
    int? approverID5,
    int? companyID,
    String? oTType,
    List<String>? attachments,
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
        _approverID2 = approverID2,
        _approverID3 = approverID3,
        _approverID4 = approverID4,
        _approverID5 = approverID5,
        _companyID = companyID,
        _oTType = oTType,
        _attachments = attachments;

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

  // "approver_ID2" field.
  int? _approverID2;
  int get approverID2 => _approverID2 ?? 0;
  set approverID2(int? val) => _approverID2 = val;

  void incrementApproverID2(int amount) => approverID2 = approverID2 + amount;

  bool hasApproverID2() => _approverID2 != null;

  // "approver_ID3" field.
  int? _approverID3;
  int get approverID3 => _approverID3 ?? 0;
  set approverID3(int? val) => _approverID3 = val;

  void incrementApproverID3(int amount) => approverID3 = approverID3 + amount;

  bool hasApproverID3() => _approverID3 != null;

  // "approver_ID4" field.
  int? _approverID4;
  int get approverID4 => _approverID4 ?? 0;
  set approverID4(int? val) => _approverID4 = val;

  void incrementApproverID4(int amount) => approverID4 = approverID4 + amount;

  bool hasApproverID4() => _approverID4 != null;

  // "approver_ID5" field.
  int? _approverID5;
  int get approverID5 => _approverID5 ?? 0;
  set approverID5(int? val) => _approverID5 = val;

  void incrementApproverID5(int amount) => approverID5 = approverID5 + amount;

  bool hasApproverID5() => _approverID5 != null;

  // "company_ID" field.
  int? _companyID;
  int get companyID => _companyID ?? 0;
  set companyID(int? val) => _companyID = val;

  void incrementCompanyID(int amount) => companyID = companyID + amount;

  bool hasCompanyID() => _companyID != null;

  // "oT_Type" field.
  String? _oTType;
  String get oTType => _oTType ?? '';
  set oTType(String? val) => _oTType = val;

  bool hasOTType() => _oTType != null;

  // "attachments" field.
  List<String>? _attachments;
  List<String> get attachments => _attachments ?? const [];
  set attachments(List<String>? val) => _attachments = val;

  void updateAttachments(Function(List<String>) updateFn) {
    updateFn(_attachments ??= []);
  }

  bool hasAttachments() => _attachments != null;

  static ReqStaffOTRequestStruct fromMap(Map<String, dynamic> data) =>
      ReqStaffOTRequestStruct(
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
        approverID2: castToType<int>(data['approver_ID2']),
        approverID3: castToType<int>(data['approver_ID3']),
        approverID4: castToType<int>(data['approver_ID4']),
        approverID5: castToType<int>(data['approver_ID5']),
        companyID: castToType<int>(data['company_ID']),
        oTType: data['oT_Type'] as String?,
        attachments: getDataList(data['attachments']),
      );

  static ReqStaffOTRequestStruct? maybeFromMap(dynamic data) => data is Map
      ? ReqStaffOTRequestStruct.fromMap(data.cast<String, dynamic>())
      : null;

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
        'approver_ID2': _approverID2,
        'approver_ID3': _approverID3,
        'approver_ID4': _approverID4,
        'approver_ID5': _approverID5,
        'company_ID': _companyID,
        'oT_Type': _oTType,
        'attachments': _attachments,
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
        'approver_ID2': serializeParam(
          _approverID2,
          ParamType.int,
        ),
        'approver_ID3': serializeParam(
          _approverID3,
          ParamType.int,
        ),
        'approver_ID4': serializeParam(
          _approverID4,
          ParamType.int,
        ),
        'approver_ID5': serializeParam(
          _approverID5,
          ParamType.int,
        ),
        'company_ID': serializeParam(
          _companyID,
          ParamType.int,
        ),
        'oT_Type': serializeParam(
          _oTType,
          ParamType.String,
        ),
        'attachments': serializeParam(
          _attachments,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static ReqStaffOTRequestStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ReqStaffOTRequestStruct(
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
        approverID2: deserializeParam(
          data['approver_ID2'],
          ParamType.int,
          false,
        ),
        approverID3: deserializeParam(
          data['approver_ID3'],
          ParamType.int,
          false,
        ),
        approverID4: deserializeParam(
          data['approver_ID4'],
          ParamType.int,
          false,
        ),
        approverID5: deserializeParam(
          data['approver_ID5'],
          ParamType.int,
          false,
        ),
        companyID: deserializeParam(
          data['company_ID'],
          ParamType.int,
          false,
        ),
        oTType: deserializeParam(
          data['oT_Type'],
          ParamType.String,
          false,
        ),
        attachments: deserializeParam<String>(
          data['attachments'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'ReqStaffOTRequestStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ReqStaffOTRequestStruct &&
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
        approverID2 == other.approverID2 &&
        approverID3 == other.approverID3 &&
        approverID4 == other.approverID4 &&
        approverID5 == other.approverID5 &&
        companyID == other.companyID &&
        oTType == other.oTType &&
        listEquality.equals(attachments, other.attachments);
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
        approverID2,
        approverID3,
        approverID4,
        approverID5,
        companyID,
        oTType,
        attachments
      ]);
}

ReqStaffOTRequestStruct createReqStaffOTRequestStruct({
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
  int? approverID2,
  int? approverID3,
  int? approverID4,
  int? approverID5,
  int? companyID,
  String? oTType,
}) =>
    ReqStaffOTRequestStruct(
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
      approverID2: approverID2,
      approverID3: approverID3,
      approverID4: approverID4,
      approverID5: approverID5,
      companyID: companyID,
      oTType: oTType,
    );
