// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class LeaveDataResultStruct extends BaseStruct {
  LeaveDataResultStruct({
    String? leaveType,
    String? note,
    String? status,
    String? leaveRequestDate,
    List<String>? leaveAttachmentList,
    String? startDate,
    String? endDate,
    int? leaveTypeID,
  })  : _leaveType = leaveType,
        _note = note,
        _status = status,
        _leaveRequestDate = leaveRequestDate,
        _leaveAttachmentList = leaveAttachmentList,
        _startDate = startDate,
        _endDate = endDate,
        _leaveTypeID = leaveTypeID;

  // "leaveType" field.
  String? _leaveType;
  String get leaveType => _leaveType ?? '';
  set leaveType(String? val) => _leaveType = val;

  bool hasLeaveType() => _leaveType != null;

  // "Note" field.
  String? _note;
  String get note => _note ?? '';
  set note(String? val) => _note = val;

  bool hasNote() => _note != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "leaveRequestDate" field.
  String? _leaveRequestDate;
  String get leaveRequestDate => _leaveRequestDate ?? '';
  set leaveRequestDate(String? val) => _leaveRequestDate = val;

  bool hasLeaveRequestDate() => _leaveRequestDate != null;

  // "leaveAttachmentList" field.
  List<String>? _leaveAttachmentList;
  List<String> get leaveAttachmentList => _leaveAttachmentList ?? const [];
  set leaveAttachmentList(List<String>? val) => _leaveAttachmentList = val;

  void updateLeaveAttachmentList(Function(List<String>) updateFn) {
    updateFn(_leaveAttachmentList ??= []);
  }

  bool hasLeaveAttachmentList() => _leaveAttachmentList != null;

  // "startDate" field.
  String? _startDate;
  String get startDate => _startDate ?? '';
  set startDate(String? val) => _startDate = val;

  bool hasStartDate() => _startDate != null;

  // "endDate" field.
  String? _endDate;
  String get endDate => _endDate ?? '';
  set endDate(String? val) => _endDate = val;

  bool hasEndDate() => _endDate != null;

  // "leaveTypeID" field.
  int? _leaveTypeID;
  int get leaveTypeID => _leaveTypeID ?? 0;
  set leaveTypeID(int? val) => _leaveTypeID = val;

  void incrementLeaveTypeID(int amount) => leaveTypeID = leaveTypeID + amount;

  bool hasLeaveTypeID() => _leaveTypeID != null;

  static LeaveDataResultStruct fromMap(Map<String, dynamic> data) =>
      LeaveDataResultStruct(
        leaveType: data['leaveType'] as String?,
        note: data['Note'] as String?,
        status: data['status'] as String?,
        leaveRequestDate: data['leaveRequestDate'] as String?,
        leaveAttachmentList: getDataList(data['leaveAttachmentList']),
        startDate: data['startDate'] as String?,
        endDate: data['endDate'] as String?,
        leaveTypeID: castToType<int>(data['leaveTypeID']),
      );

  static LeaveDataResultStruct? maybeFromMap(dynamic data) => data is Map
      ? LeaveDataResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'leaveType': _leaveType,
        'Note': _note,
        'status': _status,
        'leaveRequestDate': _leaveRequestDate,
        'leaveAttachmentList': _leaveAttachmentList,
        'startDate': _startDate,
        'endDate': _endDate,
        'leaveTypeID': _leaveTypeID,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'leaveType': serializeParam(
          _leaveType,
          ParamType.String,
        ),
        'Note': serializeParam(
          _note,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'leaveRequestDate': serializeParam(
          _leaveRequestDate,
          ParamType.String,
        ),
        'leaveAttachmentList': serializeParam(
          _leaveAttachmentList,
          ParamType.String,
          isList: true,
        ),
        'startDate': serializeParam(
          _startDate,
          ParamType.String,
        ),
        'endDate': serializeParam(
          _endDate,
          ParamType.String,
        ),
        'leaveTypeID': serializeParam(
          _leaveTypeID,
          ParamType.int,
        ),
      }.withoutNulls;

  static LeaveDataResultStruct fromSerializableMap(Map<String, dynamic> data) =>
      LeaveDataResultStruct(
        leaveType: deserializeParam(
          data['leaveType'],
          ParamType.String,
          false,
        ),
        note: deserializeParam(
          data['Note'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        leaveRequestDate: deserializeParam(
          data['leaveRequestDate'],
          ParamType.String,
          false,
        ),
        leaveAttachmentList: deserializeParam<String>(
          data['leaveAttachmentList'],
          ParamType.String,
          true,
        ),
        startDate: deserializeParam(
          data['startDate'],
          ParamType.String,
          false,
        ),
        endDate: deserializeParam(
          data['endDate'],
          ParamType.String,
          false,
        ),
        leaveTypeID: deserializeParam(
          data['leaveTypeID'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'LeaveDataResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is LeaveDataResultStruct &&
        leaveType == other.leaveType &&
        note == other.note &&
        status == other.status &&
        leaveRequestDate == other.leaveRequestDate &&
        listEquality.equals(leaveAttachmentList, other.leaveAttachmentList) &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        leaveTypeID == other.leaveTypeID;
  }

  @override
  int get hashCode => const ListEquality().hash([
        leaveType,
        note,
        status,
        leaveRequestDate,
        leaveAttachmentList,
        startDate,
        endDate,
        leaveTypeID
      ]);
}

LeaveDataResultStruct createLeaveDataResultStruct({
  String? leaveType,
  String? note,
  String? status,
  String? leaveRequestDate,
  String? startDate,
  String? endDate,
  int? leaveTypeID,
}) =>
    LeaveDataResultStruct(
      leaveType: leaveType,
      note: note,
      status: status,
      leaveRequestDate: leaveRequestDate,
      startDate: startDate,
      endDate: endDate,
      leaveTypeID: leaveTypeID,
    );
