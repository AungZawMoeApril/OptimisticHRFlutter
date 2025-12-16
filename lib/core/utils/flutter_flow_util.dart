/// FlutterFlow utility functions for serialization and type casting

// ParamType enum for serialization
enum ParamType {
  int,
  double,
  String,
  bool,
  DateTime,
  DateTimeTz,
  JSON,
  Document,
  DataStruct,
}

// Safe type casting
T? castToType<T>(dynamic value) {
  if (value == null) return null;

  try {
    if (T == int) {
      if (value is int) return value as T;
      if (value is double) return value.toInt() as T;
      if (value is String) return int.tryParse(value) as T?;
    } else if (T == double) {
      if (value is double) return value as T;
      if (value is int) return value.toDouble() as T;
      if (value is String) return double.tryParse(value) as T?;
    } else if (T == String) {
      return value.toString() as T;
    } else if (T == bool) {
      if (value is bool) return value as T;
      if (value is String) return (value.toLowerCase() == 'true') as T;
      if (value is int) return (value != 0) as T;
    } else if (value is T) {
      return value;
    }
  } catch (e) {
    return null;
  }

  return null;
}

// Serialize parameter for API calls
dynamic serializeParam(
  dynamic value,
  ParamType paramType, {
  bool isList = false,
}) {
  if (value == null) return null;

  if (isList) {
    if (value is! List) return null;
    return value.map((item) => serializeParam(item, paramType)).toList();
  }

  switch (paramType) {
    case ParamType.int:
    case ParamType.double:
    case ParamType.String:
    case ParamType.bool:
      return value;
    case ParamType.DateTime:
      if (value is DateTime) {
        return value.toIso8601String();
      }
      return value;
    case ParamType.DateTimeTz:
      if (value is DateTime) {
        return value.toUtc().toIso8601String();
      }
      return value;
    case ParamType.JSON:
    case ParamType.DataStruct:
      return value;
    default:
      return value;
  }
}

// Deserialize parameter from API responses
T? deserializeParam<T>(
  dynamic value,
  ParamType paramType,
  bool isList, {
  StructBuilder<T>? structBuilder,
}) {
  if (value == null) return null;

  if (isList) {
    if (value is! List) return null;
    return value
        .map((item) => deserializeParam<T>(item, paramType, false, structBuilder: structBuilder))
        .where((item) => item != null)
        .cast<T>()
        .toList() as T?;
  }

  try {
    switch (paramType) {
      case ParamType.int:
        return castToType<int>(value) as T?;
      case ParamType.double:
        return castToType<double>(value) as T?;
      case ParamType.String:
        return castToType<String>(value) as T?;
      case ParamType.bool:
        return castToType<bool>(value) as T?;
      case ParamType.DateTime:
      case ParamType.DateTimeTz:
        if (value is String) {
          return DateTime.tryParse(value) as T?;
        }
        return value as T?;
      case ParamType.DataStruct:
        if (structBuilder != null && value is Map<String, dynamic>) {
          return structBuilder(value);
        }
        return value as T?;
      default:
        return value as T?;
    }
  } catch (e) {
    return null;
  }
}

// Type for struct builder functions
typedef StructBuilder<T> = T Function(Map<String, dynamic> data);

// Extension to remove null values from maps
extension MapExtensions on Map<String, dynamic> {
  Map<String, dynamic> get withoutNulls {
    return Map.fromEntries(
      entries.where((entry) => entry.value != null),
    );
  }
}
