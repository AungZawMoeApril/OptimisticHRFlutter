// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class RejectPendingApprovalStruct extends BaseStruct {
  RejectPendingApprovalStruct({
    String? workFlowName,
    int? wFID,
    String? requestername,
    String? startDate,
    String? endDate,
    String? message,
    String? purposeOT,
    String? requestedDate,
    String? reqImage,
    String? status,
    bool? cancelFlag,
    List<String>? reqAttachmentlist,
    int? approverOrder,
    String? employeeCode,
  })  : _workFlowName = workFlowName,
        _wFID = wFID,
        _requestername = requestername,
        _startDate = startDate,
        _endDate = endDate,
        _message = message,
        _purposeOT = purposeOT,
        _requestedDate = requestedDate,
        _reqImage = reqImage,
        _status = status,
        _cancelFlag = cancelFlag,
        _reqAttachmentlist = reqAttachmentlist,
        _approverOrder = approverOrder,
        _employeeCode = employeeCode;

  // "workFlow_Name" field.
  String? _workFlowName;
  String get workFlowName => _workFlowName ?? '';
  set workFlowName(String? val) => _workFlowName = val;

  bool hasWorkFlowName() => _workFlowName != null;

  // "wF_ID" field.
  int? _wFID;
  int get wFID => _wFID ?? 0;
  set wFID(int? val) => _wFID = val;

  void incrementWFID(int amount) => wFID = wFID + amount;

  bool hasWFID() => _wFID != null;

  // "requestername" field.
  String? _requestername;
  String get requestername => _requestername ?? '';
  set requestername(String? val) => _requestername = val;

  bool hasRequestername() => _requestername != null;

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

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "purpose_OT" field.
  String? _purposeOT;
  String get purposeOT => _purposeOT ?? '';
  set purposeOT(String? val) => _purposeOT = val;

  bool hasPurposeOT() => _purposeOT != null;

  // "requested_Date" field.
  String? _requestedDate;
  String get requestedDate => _requestedDate ?? '';
  set requestedDate(String? val) => _requestedDate = val;

  bool hasRequestedDate() => _requestedDate != null;

  // "req_Image" field.
  String? _reqImage;
  String get reqImage => _reqImage ?? '';
  set reqImage(String? val) => _reqImage = val;

  bool hasReqImage() => _reqImage != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "cancelFlag" field.
  bool? _cancelFlag;
  bool get cancelFlag => _cancelFlag ?? false;
  set cancelFlag(bool? val) => _cancelFlag = val;

  bool hasCancelFlag() => _cancelFlag != null;

  // "req_Attachmentlist" field.
  List<String>? _reqAttachmentlist;
  List<String> get reqAttachmentlist => _reqAttachmentlist ?? const [];
  set reqAttachmentlist(List<String>? val) => _reqAttachmentlist = val;

  void updateReqAttachmentlist(Function(List<String>) updateFn) {
    updateFn(_reqAttachmentlist ??= []);
  }

  bool hasReqAttachmentlist() => _reqAttachmentlist != null;

  // "approverOrder" field.
  int? _approverOrder;
  int get approverOrder => _approverOrder ?? 0;
  set approverOrder(int? val) => _approverOrder = val;

  void incrementApproverOrder(int amount) =>
      approverOrder = approverOrder + amount;

  bool hasApproverOrder() => _approverOrder != null;

  // "employee_Code" field.
  String? _employeeCode;
  String get employeeCode => _employeeCode ?? '';
  set employeeCode(String? val) => _employeeCode = val;

  bool hasEmployeeCode() => _employeeCode != null;

  static RejectPendingApprovalStruct fromMap(Map<String, dynamic> data) =>
      RejectPendingApprovalStruct(
        workFlowName: data['workFlow_Name'] as String?,
        wFID: castToType<int>(data['wF_ID']),
        requestername: data['requestername'] as String?,
        startDate: data['start_Date'] as String?,
        endDate: data['end_Date'] as String?,
        message: data['message'] as String?,
        purposeOT: data['purpose_OT'] as String?,
        requestedDate: data['requested_Date'] as String?,
        reqImage: data['req_Image'] as String?,
        status: data['status'] as String?,
        cancelFlag: data['cancelFlag'] as bool?,
        reqAttachmentlist: getDataList(data['req_Attachmentlist']),
        approverOrder: castToType<int>(data['approverOrder']),
        employeeCode: data['employee_Code'] as String?,
      );

  static RejectPendingApprovalStruct? maybeFromMap(dynamic data) => data is Map
      ? RejectPendingApprovalStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'workFlow_Name': _workFlowName,
        'wF_ID': _wFID,
        'requestername': _requestername,
        'start_Date': _startDate,
        'end_Date': _endDate,
        'message': _message,
        'purpose_OT': _purposeOT,
        'requested_Date': _requestedDate,
        'req_Image': _reqImage,
        'status': _status,
        'cancelFlag': _cancelFlag,
        'req_Attachmentlist': _reqAttachmentlist,
        'approverOrder': _approverOrder,
        'employee_Code': _employeeCode,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'workFlow_Name': serializeParam(
          _workFlowName,
          ParamType.String,
        ),
        'wF_ID': serializeParam(
          _wFID,
          ParamType.int,
        ),
        'requestername': serializeParam(
          _requestername,
          ParamType.String,
        ),
        'start_Date': serializeParam(
          _startDate,
          ParamType.String,
        ),
        'end_Date': serializeParam(
          _endDate,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'purpose_OT': serializeParam(
          _purposeOT,
          ParamType.String,
        ),
        'requested_Date': serializeParam(
          _requestedDate,
          ParamType.String,
        ),
        'req_Image': serializeParam(
          _reqImage,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'cancelFlag': serializeParam(
          _cancelFlag,
          ParamType.bool,
        ),
        'req_Attachmentlist': serializeParam(
          _reqAttachmentlist,
          ParamType.String,
          isList: true,
        ),
        'approverOrder': serializeParam(
          _approverOrder,
          ParamType.int,
        ),
        'employee_Code': serializeParam(
          _employeeCode,
          ParamType.String,
        ),
      }.withoutNulls;

  static RejectPendingApprovalStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RejectPendingApprovalStruct(
        workFlowName: deserializeParam(
          data['workFlow_Name'],
          ParamType.String,
          false,
        ),
        wFID: deserializeParam(
          data['wF_ID'],
          ParamType.int,
          false,
        ),
        requestername: deserializeParam(
          data['requestername'],
          ParamType.String,
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
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        purposeOT: deserializeParam(
          data['purpose_OT'],
          ParamType.String,
          false,
        ),
        requestedDate: deserializeParam(
          data['requested_Date'],
          ParamType.String,
          false,
        ),
        reqImage: deserializeParam(
          data['req_Image'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        cancelFlag: deserializeParam(
          data['cancelFlag'],
          ParamType.bool,
          false,
        ),
        reqAttachmentlist: deserializeParam<String>(
          data['req_Attachmentlist'],
          ParamType.String,
          true,
        ),
        approverOrder: deserializeParam(
          data['approverOrder'],
          ParamType.int,
          false,
        ),
        employeeCode: deserializeParam(
          data['employee_Code'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RejectPendingApprovalStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is RejectPendingApprovalStruct &&
        workFlowName == other.workFlowName &&
        wFID == other.wFID &&
        requestername == other.requestername &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        message == other.message &&
        purposeOT == other.purposeOT &&
        requestedDate == other.requestedDate &&
        reqImage == other.reqImage &&
        status == other.status &&
        cancelFlag == other.cancelFlag &&
        listEquality.equals(reqAttachmentlist, other.reqAttachmentlist) &&
        approverOrder == other.approverOrder &&
        employeeCode == other.employeeCode;
  }

  @override
  int get hashCode => const ListEquality().hash([
        workFlowName,
        wFID,
        requestername,
        startDate,
        endDate,
        message,
        purposeOT,
        requestedDate,
        reqImage,
        status,
        cancelFlag,
        reqAttachmentlist,
        approverOrder,
        employeeCode
      ]);
}

RejectPendingApprovalStruct createRejectPendingApprovalStruct({
  String? workFlowName,
  int? wFID,
  String? requestername,
  String? startDate,
  String? endDate,
  String? message,
  String? purposeOT,
  String? requestedDate,
  String? reqImage,
  String? status,
  bool? cancelFlag,
  int? approverOrder,
  String? employeeCode,
}) =>
    RejectPendingApprovalStruct(
      workFlowName: workFlowName,
      wFID: wFID,
      requestername: requestername,
      startDate: startDate,
      endDate: endDate,
      message: message,
      purposeOT: purposeOT,
      requestedDate: requestedDate,
      reqImage: reqImage,
      status: status,
      cancelFlag: cancelFlag,
      approverOrder: approverOrder,
      employeeCode: employeeCode,
    );
