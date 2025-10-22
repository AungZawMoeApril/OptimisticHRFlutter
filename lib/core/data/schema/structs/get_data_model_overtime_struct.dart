// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class GetDataModelOvertimeStruct extends BaseStruct {
  GetDataModelOvertimeStruct({
    int? approverID,
    String? attachmentlist,
    int? companyID,
    String? departmentName,
    String? employeeCode,
    int? employeeID,
    String? emptype,
    String? endDate,
    String? firstName,
    String? lastName,
    String? myLastName,
    String? name,
    String? oTApprovedDate,
    String? oTEndTime,
    String? oTHours,
    int? oTRequestID,
    String? oTRequestedDate,
    String? oTStartTime,
    String? oTType,
    String? positionName,
    String? purposeOT,
    String? reason,
    int? requesterID,
    bool? saveDraft,
    String? startDate,
    String? status,
    int? wFID,
    bool? wholeDay,
    String? workFlowName,
  })  : _approverID = approverID,
        _attachmentlist = attachmentlist,
        _companyID = companyID,
        _departmentName = departmentName,
        _employeeCode = employeeCode,
        _employeeID = employeeID,
        _emptype = emptype,
        _endDate = endDate,
        _firstName = firstName,
        _lastName = lastName,
        _myLastName = myLastName,
        _name = name,
        _oTApprovedDate = oTApprovedDate,
        _oTEndTime = oTEndTime,
        _oTHours = oTHours,
        _oTRequestID = oTRequestID,
        _oTRequestedDate = oTRequestedDate,
        _oTStartTime = oTStartTime,
        _oTType = oTType,
        _positionName = positionName,
        _purposeOT = purposeOT,
        _reason = reason,
        _requesterID = requesterID,
        _saveDraft = saveDraft,
        _startDate = startDate,
        _status = status,
        _wFID = wFID,
        _wholeDay = wholeDay,
        _workFlowName = workFlowName;

  // "approver_ID" field.
  int? _approverID;
  int get approverID => _approverID ?? 0;
  set approverID(int? val) => _approverID = val;

  void incrementApproverID(int amount) => approverID = approverID + amount;

  bool hasApproverID() => _approverID != null;

  // "attachmentlist" field.
  String? _attachmentlist;
  String get attachmentlist => _attachmentlist ?? '';
  set attachmentlist(String? val) => _attachmentlist = val;

  bool hasAttachmentlist() => _attachmentlist != null;

  // "company_ID" field.
  int? _companyID;
  int get companyID => _companyID ?? 0;
  set companyID(int? val) => _companyID = val;

  void incrementCompanyID(int amount) => companyID = companyID + amount;

  bool hasCompanyID() => _companyID != null;

  // "departmentName" field.
  String? _departmentName;
  String get departmentName => _departmentName ?? '';
  set departmentName(String? val) => _departmentName = val;

  bool hasDepartmentName() => _departmentName != null;

  // "employee_Code" field.
  String? _employeeCode;
  String get employeeCode => _employeeCode ?? '';
  set employeeCode(String? val) => _employeeCode = val;

  bool hasEmployeeCode() => _employeeCode != null;

  // "employee_ID" field.
  int? _employeeID;
  int get employeeID => _employeeID ?? 0;
  set employeeID(int? val) => _employeeID = val;

  void incrementEmployeeID(int amount) => employeeID = employeeID + amount;

  bool hasEmployeeID() => _employeeID != null;

  // "emptype" field.
  String? _emptype;
  String get emptype => _emptype ?? '';
  set emptype(String? val) => _emptype = val;

  bool hasEmptype() => _emptype != null;

  // "end_Date" field.
  String? _endDate;
  String get endDate => _endDate ?? '';
  set endDate(String? val) => _endDate = val;

  bool hasEndDate() => _endDate != null;

  // "firstName" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  set firstName(String? val) => _firstName = val;

  bool hasFirstName() => _firstName != null;

  // "lastName" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  set lastName(String? val) => _lastName = val;

  bool hasLastName() => _lastName != null;

  // "myLastName" field.
  String? _myLastName;
  String get myLastName => _myLastName ?? '';
  set myLastName(String? val) => _myLastName = val;

  bool hasMyLastName() => _myLastName != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "oT_Approved_Date" field.
  String? _oTApprovedDate;
  String get oTApprovedDate => _oTApprovedDate ?? '';
  set oTApprovedDate(String? val) => _oTApprovedDate = val;

  bool hasOTApprovedDate() => _oTApprovedDate != null;

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

  // "oT_Request_ID" field.
  int? _oTRequestID;
  int get oTRequestID => _oTRequestID ?? 0;
  set oTRequestID(int? val) => _oTRequestID = val;

  void incrementOTRequestID(int amount) => oTRequestID = oTRequestID + amount;

  bool hasOTRequestID() => _oTRequestID != null;

  // "oT_Requested_Date" field.
  String? _oTRequestedDate;
  String get oTRequestedDate => _oTRequestedDate ?? '';
  set oTRequestedDate(String? val) => _oTRequestedDate = val;

  bool hasOTRequestedDate() => _oTRequestedDate != null;

  // "oT_Start_Time" field.
  String? _oTStartTime;
  String get oTStartTime => _oTStartTime ?? '';
  set oTStartTime(String? val) => _oTStartTime = val;

  bool hasOTStartTime() => _oTStartTime != null;

  // "oT_Type" field.
  String? _oTType;
  String get oTType => _oTType ?? '';
  set oTType(String? val) => _oTType = val;

  bool hasOTType() => _oTType != null;

  // "positionName" field.
  String? _positionName;
  String get positionName => _positionName ?? '';
  set positionName(String? val) => _positionName = val;

  bool hasPositionName() => _positionName != null;

  // "purpose_OT" field.
  String? _purposeOT;
  String get purposeOT => _purposeOT ?? '';
  set purposeOT(String? val) => _purposeOT = val;

  bool hasPurposeOT() => _purposeOT != null;

  // "reason" field.
  String? _reason;
  String get reason => _reason ?? '';
  set reason(String? val) => _reason = val;

  bool hasReason() => _reason != null;

  // "requester_ID" field.
  int? _requesterID;
  int get requesterID => _requesterID ?? 0;
  set requesterID(int? val) => _requesterID = val;

  void incrementRequesterID(int amount) => requesterID = requesterID + amount;

  bool hasRequesterID() => _requesterID != null;

  // "saveDraft" field.
  bool? _saveDraft;
  bool get saveDraft => _saveDraft ?? false;
  set saveDraft(bool? val) => _saveDraft = val;

  bool hasSaveDraft() => _saveDraft != null;

  // "start_Date" field.
  String? _startDate;
  String get startDate => _startDate ?? '';
  set startDate(String? val) => _startDate = val;

  bool hasStartDate() => _startDate != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "wF_ID" field.
  int? _wFID;
  int get wFID => _wFID ?? 0;
  set wFID(int? val) => _wFID = val;

  void incrementWFID(int amount) => wFID = wFID + amount;

  bool hasWFID() => _wFID != null;

  // "wholeDay" field.
  bool? _wholeDay;
  bool get wholeDay => _wholeDay ?? false;
  set wholeDay(bool? val) => _wholeDay = val;

  bool hasWholeDay() => _wholeDay != null;

  // "workFlow_Name" field.
  String? _workFlowName;
  String get workFlowName => _workFlowName ?? '';
  set workFlowName(String? val) => _workFlowName = val;

  bool hasWorkFlowName() => _workFlowName != null;

  static GetDataModelOvertimeStruct fromMap(Map<String, dynamic> data) =>
      GetDataModelOvertimeStruct(
        approverID: castToType<int>(data['approver_ID']),
        attachmentlist: data['attachmentlist'] as String?,
        companyID: castToType<int>(data['company_ID']),
        departmentName: data['departmentName'] as String?,
        employeeCode: data['employee_Code'] as String?,
        employeeID: castToType<int>(data['employee_ID']),
        emptype: data['emptype'] as String?,
        endDate: data['end_Date'] as String?,
        firstName: data['firstName'] as String?,
        lastName: data['lastName'] as String?,
        myLastName: data['myLastName'] as String?,
        name: data['name'] as String?,
        oTApprovedDate: data['oT_Approved_Date'] as String?,
        oTEndTime: data['oT_End_Time'] as String?,
        oTHours: data['oT_Hours'] as String?,
        oTRequestID: castToType<int>(data['oT_Request_ID']),
        oTRequestedDate: data['oT_Requested_Date'] as String?,
        oTStartTime: data['oT_Start_Time'] as String?,
        oTType: data['oT_Type'] as String?,
        positionName: data['positionName'] as String?,
        purposeOT: data['purpose_OT'] as String?,
        reason: data['reason'] as String?,
        requesterID: castToType<int>(data['requester_ID']),
        saveDraft: data['saveDraft'] as bool?,
        startDate: data['start_Date'] as String?,
        status: data['status'] as String?,
        wFID: castToType<int>(data['wF_ID']),
        wholeDay: data['wholeDay'] as bool?,
        workFlowName: data['workFlow_Name'] as String?,
      );

  static GetDataModelOvertimeStruct? maybeFromMap(dynamic data) => data is Map
      ? GetDataModelOvertimeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'approver_ID': _approverID,
        'attachmentlist': _attachmentlist,
        'company_ID': _companyID,
        'departmentName': _departmentName,
        'employee_Code': _employeeCode,
        'employee_ID': _employeeID,
        'emptype': _emptype,
        'end_Date': _endDate,
        'firstName': _firstName,
        'lastName': _lastName,
        'myLastName': _myLastName,
        'name': _name,
        'oT_Approved_Date': _oTApprovedDate,
        'oT_End_Time': _oTEndTime,
        'oT_Hours': _oTHours,
        'oT_Request_ID': _oTRequestID,
        'oT_Requested_Date': _oTRequestedDate,
        'oT_Start_Time': _oTStartTime,
        'oT_Type': _oTType,
        'positionName': _positionName,
        'purpose_OT': _purposeOT,
        'reason': _reason,
        'requester_ID': _requesterID,
        'saveDraft': _saveDraft,
        'start_Date': _startDate,
        'status': _status,
        'wF_ID': _wFID,
        'wholeDay': _wholeDay,
        'workFlow_Name': _workFlowName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'approver_ID': serializeParam(
          _approverID,
          ParamType.int,
        ),
        'attachmentlist': serializeParam(
          _attachmentlist,
          ParamType.String,
        ),
        'company_ID': serializeParam(
          _companyID,
          ParamType.int,
        ),
        'departmentName': serializeParam(
          _departmentName,
          ParamType.String,
        ),
        'employee_Code': serializeParam(
          _employeeCode,
          ParamType.String,
        ),
        'employee_ID': serializeParam(
          _employeeID,
          ParamType.int,
        ),
        'emptype': serializeParam(
          _emptype,
          ParamType.String,
        ),
        'end_Date': serializeParam(
          _endDate,
          ParamType.String,
        ),
        'firstName': serializeParam(
          _firstName,
          ParamType.String,
        ),
        'lastName': serializeParam(
          _lastName,
          ParamType.String,
        ),
        'myLastName': serializeParam(
          _myLastName,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'oT_Approved_Date': serializeParam(
          _oTApprovedDate,
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
        'oT_Request_ID': serializeParam(
          _oTRequestID,
          ParamType.int,
        ),
        'oT_Requested_Date': serializeParam(
          _oTRequestedDate,
          ParamType.String,
        ),
        'oT_Start_Time': serializeParam(
          _oTStartTime,
          ParamType.String,
        ),
        'oT_Type': serializeParam(
          _oTType,
          ParamType.String,
        ),
        'positionName': serializeParam(
          _positionName,
          ParamType.String,
        ),
        'purpose_OT': serializeParam(
          _purposeOT,
          ParamType.String,
        ),
        'reason': serializeParam(
          _reason,
          ParamType.String,
        ),
        'requester_ID': serializeParam(
          _requesterID,
          ParamType.int,
        ),
        'saveDraft': serializeParam(
          _saveDraft,
          ParamType.bool,
        ),
        'start_Date': serializeParam(
          _startDate,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'wF_ID': serializeParam(
          _wFID,
          ParamType.int,
        ),
        'wholeDay': serializeParam(
          _wholeDay,
          ParamType.bool,
        ),
        'workFlow_Name': serializeParam(
          _workFlowName,
          ParamType.String,
        ),
      }.withoutNulls;

  static GetDataModelOvertimeStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      GetDataModelOvertimeStruct(
        approverID: deserializeParam(
          data['approver_ID'],
          ParamType.int,
          false,
        ),
        attachmentlist: deserializeParam(
          data['attachmentlist'],
          ParamType.String,
          false,
        ),
        companyID: deserializeParam(
          data['company_ID'],
          ParamType.int,
          false,
        ),
        departmentName: deserializeParam(
          data['departmentName'],
          ParamType.String,
          false,
        ),
        employeeCode: deserializeParam(
          data['employee_Code'],
          ParamType.String,
          false,
        ),
        employeeID: deserializeParam(
          data['employee_ID'],
          ParamType.int,
          false,
        ),
        emptype: deserializeParam(
          data['emptype'],
          ParamType.String,
          false,
        ),
        endDate: deserializeParam(
          data['end_Date'],
          ParamType.String,
          false,
        ),
        firstName: deserializeParam(
          data['firstName'],
          ParamType.String,
          false,
        ),
        lastName: deserializeParam(
          data['lastName'],
          ParamType.String,
          false,
        ),
        myLastName: deserializeParam(
          data['myLastName'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        oTApprovedDate: deserializeParam(
          data['oT_Approved_Date'],
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
        oTRequestID: deserializeParam(
          data['oT_Request_ID'],
          ParamType.int,
          false,
        ),
        oTRequestedDate: deserializeParam(
          data['oT_Requested_Date'],
          ParamType.String,
          false,
        ),
        oTStartTime: deserializeParam(
          data['oT_Start_Time'],
          ParamType.String,
          false,
        ),
        oTType: deserializeParam(
          data['oT_Type'],
          ParamType.String,
          false,
        ),
        positionName: deserializeParam(
          data['positionName'],
          ParamType.String,
          false,
        ),
        purposeOT: deserializeParam(
          data['purpose_OT'],
          ParamType.String,
          false,
        ),
        reason: deserializeParam(
          data['reason'],
          ParamType.String,
          false,
        ),
        requesterID: deserializeParam(
          data['requester_ID'],
          ParamType.int,
          false,
        ),
        saveDraft: deserializeParam(
          data['saveDraft'],
          ParamType.bool,
          false,
        ),
        startDate: deserializeParam(
          data['start_Date'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        wFID: deserializeParam(
          data['wF_ID'],
          ParamType.int,
          false,
        ),
        wholeDay: deserializeParam(
          data['wholeDay'],
          ParamType.bool,
          false,
        ),
        workFlowName: deserializeParam(
          data['workFlow_Name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GetDataModelOvertimeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GetDataModelOvertimeStruct &&
        approverID == other.approverID &&
        attachmentlist == other.attachmentlist &&
        companyID == other.companyID &&
        departmentName == other.departmentName &&
        employeeCode == other.employeeCode &&
        employeeID == other.employeeID &&
        emptype == other.emptype &&
        endDate == other.endDate &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        myLastName == other.myLastName &&
        name == other.name &&
        oTApprovedDate == other.oTApprovedDate &&
        oTEndTime == other.oTEndTime &&
        oTHours == other.oTHours &&
        oTRequestID == other.oTRequestID &&
        oTRequestedDate == other.oTRequestedDate &&
        oTStartTime == other.oTStartTime &&
        oTType == other.oTType &&
        positionName == other.positionName &&
        purposeOT == other.purposeOT &&
        reason == other.reason &&
        requesterID == other.requesterID &&
        saveDraft == other.saveDraft &&
        startDate == other.startDate &&
        status == other.status &&
        wFID == other.wFID &&
        wholeDay == other.wholeDay &&
        workFlowName == other.workFlowName;
  }

  @override
  int get hashCode => const ListEquality().hash([
        approverID,
        attachmentlist,
        companyID,
        departmentName,
        employeeCode,
        employeeID,
        emptype,
        endDate,
        firstName,
        lastName,
        myLastName,
        name,
        oTApprovedDate,
        oTEndTime,
        oTHours,
        oTRequestID,
        oTRequestedDate,
        oTStartTime,
        oTType,
        positionName,
        purposeOT,
        reason,
        requesterID,
        saveDraft,
        startDate,
        status,
        wFID,
        wholeDay,
        workFlowName
      ]);
}

GetDataModelOvertimeStruct createGetDataModelOvertimeStruct({
  int? approverID,
  String? attachmentlist,
  int? companyID,
  String? departmentName,
  String? employeeCode,
  int? employeeID,
  String? emptype,
  String? endDate,
  String? firstName,
  String? lastName,
  String? myLastName,
  String? name,
  String? oTApprovedDate,
  String? oTEndTime,
  String? oTHours,
  int? oTRequestID,
  String? oTRequestedDate,
  String? oTStartTime,
  String? oTType,
  String? positionName,
  String? purposeOT,
  String? reason,
  int? requesterID,
  bool? saveDraft,
  String? startDate,
  String? status,
  int? wFID,
  bool? wholeDay,
  String? workFlowName,
}) =>
    GetDataModelOvertimeStruct(
      approverID: approverID,
      attachmentlist: attachmentlist,
      companyID: companyID,
      departmentName: departmentName,
      employeeCode: employeeCode,
      employeeID: employeeID,
      emptype: emptype,
      endDate: endDate,
      firstName: firstName,
      lastName: lastName,
      myLastName: myLastName,
      name: name,
      oTApprovedDate: oTApprovedDate,
      oTEndTime: oTEndTime,
      oTHours: oTHours,
      oTRequestID: oTRequestID,
      oTRequestedDate: oTRequestedDate,
      oTStartTime: oTStartTime,
      oTType: oTType,
      positionName: positionName,
      purposeOT: purposeOT,
      reason: reason,
      requesterID: requesterID,
      saveDraft: saveDraft,
      startDate: startDate,
      status: status,
      wFID: wFID,
      wholeDay: wholeDay,
      workFlowName: workFlowName,
    );
