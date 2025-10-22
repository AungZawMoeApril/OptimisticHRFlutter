// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class OvertimeCheckStructStruct extends BaseStruct {
  OvertimeCheckStructStruct({
    bool? hasValidOvertime,
    int? timeZoneOffsetMinutes,
  })  : _hasValidOvertime = hasValidOvertime,
        _timeZoneOffsetMinutes = timeZoneOffsetMinutes;

  // "hasValidOvertime" field.
  bool? _hasValidOvertime;
  bool get hasValidOvertime => _hasValidOvertime ?? false;
  set hasValidOvertime(bool? val) => _hasValidOvertime = val;

  bool hasHasValidOvertime() => _hasValidOvertime != null;

  // "timeZoneOffsetMinutes" field.
  int? _timeZoneOffsetMinutes;
  int get timeZoneOffsetMinutes => _timeZoneOffsetMinutes ?? 0;
  set timeZoneOffsetMinutes(int? val) => _timeZoneOffsetMinutes = val;

  void incrementTimeZoneOffsetMinutes(int amount) =>
      timeZoneOffsetMinutes = timeZoneOffsetMinutes + amount;

  bool hasTimeZoneOffsetMinutes() => _timeZoneOffsetMinutes != null;

  static OvertimeCheckStructStruct fromMap(Map<String, dynamic> data) =>
      OvertimeCheckStructStruct(
        hasValidOvertime: data['hasValidOvertime'] as bool?,
        timeZoneOffsetMinutes: castToType<int>(data['timeZoneOffsetMinutes']),
      );

  static OvertimeCheckStructStruct? maybeFromMap(dynamic data) => data is Map
      ? OvertimeCheckStructStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'hasValidOvertime': _hasValidOvertime,
        'timeZoneOffsetMinutes': _timeZoneOffsetMinutes,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'hasValidOvertime': serializeParam(
          _hasValidOvertime,
          ParamType.bool,
        ),
        'timeZoneOffsetMinutes': serializeParam(
          _timeZoneOffsetMinutes,
          ParamType.int,
        ),
      }.withoutNulls;

  static OvertimeCheckStructStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      OvertimeCheckStructStruct(
        hasValidOvertime: deserializeParam(
          data['hasValidOvertime'],
          ParamType.bool,
          false,
        ),
        timeZoneOffsetMinutes: deserializeParam(
          data['timeZoneOffsetMinutes'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'OvertimeCheckStructStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OvertimeCheckStructStruct &&
        hasValidOvertime == other.hasValidOvertime &&
        timeZoneOffsetMinutes == other.timeZoneOffsetMinutes;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([hasValidOvertime, timeZoneOffsetMinutes]);
}

OvertimeCheckStructStruct createOvertimeCheckStructStruct({
  bool? hasValidOvertime,
  int? timeZoneOffsetMinutes,
}) =>
    OvertimeCheckStructStruct(
      hasValidOvertime: hasValidOvertime,
      timeZoneOffsetMinutes: timeZoneOffsetMinutes,
    );
