// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class AddressLatLngDataModelStruct extends BaseStruct {
  AddressLatLngDataModelStruct({
    double? latitude,
    double? longitude,
    bool? status,
  })  : _latitude = latitude,
        _longitude = longitude,
        _status = status;

  // "Latitude" field.
  double? _latitude;
  double get latitude => _latitude ?? 0.0;
  set latitude(double? val) => _latitude = val;

  void incrementLatitude(double amount) => latitude = latitude + amount;

  bool hasLatitude() => _latitude != null;

  // "Longitude" field.
  double? _longitude;
  double get longitude => _longitude ?? 0.0;
  set longitude(double? val) => _longitude = val;

  void incrementLongitude(double amount) => longitude = longitude + amount;

  bool hasLongitude() => _longitude != null;

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  set status(bool? val) => _status = val;

  bool hasStatus() => _status != null;

  static AddressLatLngDataModelStruct fromMap(Map<String, dynamic> data) =>
      AddressLatLngDataModelStruct(
        latitude: castToType<double>(data['Latitude']),
        longitude: castToType<double>(data['Longitude']),
        status: data['status'] as bool?,
      );

  static AddressLatLngDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? AddressLatLngDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Latitude': _latitude,
        'Longitude': _longitude,
        'status': _status,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Latitude': serializeParam(
          _latitude,
          ParamType.double,
        ),
        'Longitude': serializeParam(
          _longitude,
          ParamType.double,
        ),
        'status': serializeParam(
          _status,
          ParamType.bool,
        ),
      }.withoutNulls;

  static AddressLatLngDataModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      AddressLatLngDataModelStruct(
        latitude: deserializeParam(
          data['Latitude'],
          ParamType.double,
          false,
        ),
        longitude: deserializeParam(
          data['Longitude'],
          ParamType.double,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'AddressLatLngDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AddressLatLngDataModelStruct &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality().hash([latitude, longitude, status]);
}

AddressLatLngDataModelStruct createAddressLatLngDataModelStruct({
  double? latitude,
  double? longitude,
  bool? status,
}) =>
    AddressLatLngDataModelStruct(
      latitude: latitude,
      longitude: longitude,
      status: status,
    );
