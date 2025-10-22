// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class OvertimeDetailsStruct extends BaseStruct {
  OvertimeDetailsStruct({
    String? overtime,
    String? status,
    String? overtimeDay,
    String? startDate,
    String? endDate,
    String? note,
    List<String>? overtImeDescription,
    bool? cancelFlag,
  })  : _overtime = overtime,
        _status = status,
        _overtimeDay = overtimeDay,
        _startDate = startDate,
        _endDate = endDate,
        _note = note,
        _overtImeDescription = overtImeDescription,
        _cancelFlag = cancelFlag;

  // "overtime" field.
  String? _overtime;
  String get overtime => _overtime ?? '';
  set overtime(String? val) => _overtime = val;

  bool hasOvertime() => _overtime != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "OvertimeDay" field.
  String? _overtimeDay;
  String get overtimeDay => _overtimeDay ?? '';
  set overtimeDay(String? val) => _overtimeDay = val;

  bool hasOvertimeDay() => _overtimeDay != null;

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

  // "Note" field.
  String? _note;
  String get note => _note ?? '';
  set note(String? val) => _note = val;

  bool hasNote() => _note != null;

  // "overtImeDescription" field.
  List<String>? _overtImeDescription;
  List<String> get overtImeDescription => _overtImeDescription ?? const [];
  set overtImeDescription(List<String>? val) => _overtImeDescription = val;

  void updateOvertImeDescription(Function(List<String>) updateFn) {
    updateFn(_overtImeDescription ??= []);
  }

  bool hasOvertImeDescription() => _overtImeDescription != null;

  // "cancelFlag" field.
  bool? _cancelFlag;
  bool get cancelFlag => _cancelFlag ?? false;
  set cancelFlag(bool? val) => _cancelFlag = val;

  bool hasCancelFlag() => _cancelFlag != null;

  static OvertimeDetailsStruct fromMap(Map<String, dynamic> data) =>
      OvertimeDetailsStruct(
        overtime: data['overtime'] as String?,
        status: data['status'] as String?,
        overtimeDay: data['OvertimeDay'] as String?,
        startDate: data['startDate'] as String?,
        endDate: data['endDate'] as String?,
        note: data['Note'] as String?,
        overtImeDescription: getDataList(data['overtImeDescription']),
        cancelFlag: data['cancelFlag'] as bool?,
      );

  static OvertimeDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? OvertimeDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'overtime': _overtime,
        'status': _status,
        'OvertimeDay': _overtimeDay,
        'startDate': _startDate,
        'endDate': _endDate,
        'Note': _note,
        'overtImeDescription': _overtImeDescription,
        'cancelFlag': _cancelFlag,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'overtime': serializeParam(
          _overtime,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'OvertimeDay': serializeParam(
          _overtimeDay,
          ParamType.String,
        ),
        'startDate': serializeParam(
          _startDate,
          ParamType.String,
        ),
        'endDate': serializeParam(
          _endDate,
          ParamType.String,
        ),
        'Note': serializeParam(
          _note,
          ParamType.String,
        ),
        'overtImeDescription': serializeParam(
          _overtImeDescription,
          ParamType.String,
          isList: true,
        ),
        'cancelFlag': serializeParam(
          _cancelFlag,
          ParamType.bool,
        ),
      }.withoutNulls;

  static OvertimeDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      OvertimeDetailsStruct(
        overtime: deserializeParam(
          data['overtime'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        overtimeDay: deserializeParam(
          data['OvertimeDay'],
          ParamType.String,
          false,
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
        note: deserializeParam(
          data['Note'],
          ParamType.String,
          false,
        ),
        overtImeDescription: deserializeParam<String>(
          data['overtImeDescription'],
          ParamType.String,
          true,
        ),
        cancelFlag: deserializeParam(
          data['cancelFlag'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'OvertimeDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is OvertimeDetailsStruct &&
        overtime == other.overtime &&
        status == other.status &&
        overtimeDay == other.overtimeDay &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        note == other.note &&
        listEquality.equals(overtImeDescription, other.overtImeDescription) &&
        cancelFlag == other.cancelFlag;
  }

  @override
  int get hashCode => const ListEquality().hash([
        overtime,
        status,
        overtimeDay,
        startDate,
        endDate,
        note,
        overtImeDescription,
        cancelFlag
      ]);
}

OvertimeDetailsStruct createOvertimeDetailsStruct({
  String? overtime,
  String? status,
  String? overtimeDay,
  String? startDate,
  String? endDate,
  String? note,
  bool? cancelFlag,
}) =>
    OvertimeDetailsStruct(
      overtime: overtime,
      status: status,
      overtimeDay: overtimeDay,
      startDate: startDate,
      endDate: endDate,
      note: note,
      cancelFlag: cancelFlag,
    );
