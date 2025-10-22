// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class ModelTimeStruct extends BaseStruct {
  ModelTimeStruct({
    int? clockID,
    String? clockInTime,
    String? clockOutTime,
    String? clockInLocation,
    String? clockOutLocation,
    String? clockInLattitude,
    String? clockInLongitude,
    String? clockOutLattitude,
    String? clockOutLongitude,
    String? type,
  })  : _clockID = clockID,
        _clockInTime = clockInTime,
        _clockOutTime = clockOutTime,
        _clockInLocation = clockInLocation,
        _clockOutLocation = clockOutLocation,
        _clockInLattitude = clockInLattitude,
        _clockInLongitude = clockInLongitude,
        _clockOutLattitude = clockOutLattitude,
        _clockOutLongitude = clockOutLongitude,
        _type = type;

  // "clock_ID" field.
  int? _clockID;
  int get clockID => _clockID ?? 0;
  set clockID(int? val) => _clockID = val;

  void incrementClockID(int amount) => clockID = clockID + amount;

  bool hasClockID() => _clockID != null;

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

  // "clock_In_Location" field.
  String? _clockInLocation;
  String get clockInLocation => _clockInLocation ?? '';
  set clockInLocation(String? val) => _clockInLocation = val;

  bool hasClockInLocation() => _clockInLocation != null;

  // "clock_Out_Location" field.
  String? _clockOutLocation;
  String get clockOutLocation => _clockOutLocation ?? '';
  set clockOutLocation(String? val) => _clockOutLocation = val;

  bool hasClockOutLocation() => _clockOutLocation != null;

  // "clock_In_Lattitude" field.
  String? _clockInLattitude;
  String get clockInLattitude => _clockInLattitude ?? '';
  set clockInLattitude(String? val) => _clockInLattitude = val;

  bool hasClockInLattitude() => _clockInLattitude != null;

  // "clock_In_Longitude" field.
  String? _clockInLongitude;
  String get clockInLongitude => _clockInLongitude ?? '';
  set clockInLongitude(String? val) => _clockInLongitude = val;

  bool hasClockInLongitude() => _clockInLongitude != null;

  // "clock_Out_Lattitude" field.
  String? _clockOutLattitude;
  String get clockOutLattitude => _clockOutLattitude ?? '';
  set clockOutLattitude(String? val) => _clockOutLattitude = val;

  bool hasClockOutLattitude() => _clockOutLattitude != null;

  // "clock_Out_Longitude" field.
  String? _clockOutLongitude;
  String get clockOutLongitude => _clockOutLongitude ?? '';
  set clockOutLongitude(String? val) => _clockOutLongitude = val;

  bool hasClockOutLongitude() => _clockOutLongitude != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  static ModelTimeStruct fromMap(Map<String, dynamic> data) => ModelTimeStruct(
        clockID: castToType<int>(data['clock_ID']),
        clockInTime: data['clock_In_Time'] as String?,
        clockOutTime: data['clock_Out_Time'] as String?,
        clockInLocation: data['clock_In_Location'] as String?,
        clockOutLocation: data['clock_Out_Location'] as String?,
        clockInLattitude: data['clock_In_Lattitude'] as String?,
        clockInLongitude: data['clock_In_Longitude'] as String?,
        clockOutLattitude: data['clock_Out_Lattitude'] as String?,
        clockOutLongitude: data['clock_Out_Longitude'] as String?,
        type: data['type'] as String?,
      );

  static ModelTimeStruct? maybeFromMap(dynamic data) => data is Map
      ? ModelTimeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'clock_ID': _clockID,
        'clock_In_Time': _clockInTime,
        'clock_Out_Time': _clockOutTime,
        'clock_In_Location': _clockInLocation,
        'clock_Out_Location': _clockOutLocation,
        'clock_In_Lattitude': _clockInLattitude,
        'clock_In_Longitude': _clockInLongitude,
        'clock_Out_Lattitude': _clockOutLattitude,
        'clock_Out_Longitude': _clockOutLongitude,
        'type': _type,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'clock_ID': serializeParam(
          _clockID,
          ParamType.int,
        ),
        'clock_In_Time': serializeParam(
          _clockInTime,
          ParamType.String,
        ),
        'clock_Out_Time': serializeParam(
          _clockOutTime,
          ParamType.String,
        ),
        'clock_In_Location': serializeParam(
          _clockInLocation,
          ParamType.String,
        ),
        'clock_Out_Location': serializeParam(
          _clockOutLocation,
          ParamType.String,
        ),
        'clock_In_Lattitude': serializeParam(
          _clockInLattitude,
          ParamType.String,
        ),
        'clock_In_Longitude': serializeParam(
          _clockInLongitude,
          ParamType.String,
        ),
        'clock_Out_Lattitude': serializeParam(
          _clockOutLattitude,
          ParamType.String,
        ),
        'clock_Out_Longitude': serializeParam(
          _clockOutLongitude,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
      }.withoutNulls;

  static ModelTimeStruct fromSerializableMap(Map<String, dynamic> data) =>
      ModelTimeStruct(
        clockID: deserializeParam(
          data['clock_ID'],
          ParamType.int,
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
        clockInLocation: deserializeParam(
          data['clock_In_Location'],
          ParamType.String,
          false,
        ),
        clockOutLocation: deserializeParam(
          data['clock_Out_Location'],
          ParamType.String,
          false,
        ),
        clockInLattitude: deserializeParam(
          data['clock_In_Lattitude'],
          ParamType.String,
          false,
        ),
        clockInLongitude: deserializeParam(
          data['clock_In_Longitude'],
          ParamType.String,
          false,
        ),
        clockOutLattitude: deserializeParam(
          data['clock_Out_Lattitude'],
          ParamType.String,
          false,
        ),
        clockOutLongitude: deserializeParam(
          data['clock_Out_Longitude'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ModelTimeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ModelTimeStruct &&
        clockID == other.clockID &&
        clockInTime == other.clockInTime &&
        clockOutTime == other.clockOutTime &&
        clockInLocation == other.clockInLocation &&
        clockOutLocation == other.clockOutLocation &&
        clockInLattitude == other.clockInLattitude &&
        clockInLongitude == other.clockInLongitude &&
        clockOutLattitude == other.clockOutLattitude &&
        clockOutLongitude == other.clockOutLongitude &&
        type == other.type;
  }

  @override
  int get hashCode => const ListEquality().hash([
        clockID,
        clockInTime,
        clockOutTime,
        clockInLocation,
        clockOutLocation,
        clockInLattitude,
        clockInLongitude,
        clockOutLattitude,
        clockOutLongitude,
        type
      ]);
}

ModelTimeStruct createModelTimeStruct({
  int? clockID,
  String? clockInTime,
  String? clockOutTime,
  String? clockInLocation,
  String? clockOutLocation,
  String? clockInLattitude,
  String? clockInLongitude,
  String? clockOutLattitude,
  String? clockOutLongitude,
  String? type,
}) =>
    ModelTimeStruct(
      clockID: clockID,
      clockInTime: clockInTime,
      clockOutTime: clockOutTime,
      clockInLocation: clockInLocation,
      clockOutLocation: clockOutLocation,
      clockInLattitude: clockInLattitude,
      clockInLongitude: clockInLongitude,
      clockOutLattitude: clockOutLattitude,
      clockOutLongitude: clockOutLongitude,
      type: type,
    );
