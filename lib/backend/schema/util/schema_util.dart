import 'dart:convert';

import 'package:flutter/material.dart';

import '/core/utils/flutter_flow_util.dart';

export 'package:collection/collection.dart' show ListEquality;
export 'package:flutter/material.dart' show Color, Colors;

typedef StructBuilder<T> = T Function(Map<String, dynamic> data);

abstract class BaseStruct {
  Map<String, dynamic> toSerializableMap();
  String serialize() => json.encode(toSerializableMap());
}

dynamic deserializeStructParam<T>(
  dynamic param,
  ParamType paramType,
  bool isList, {
  required StructBuilder<T> structBuilder,
}) {
  if (param == null) {
    return null;
  } else if (isList) {
    final paramValues;
    try {
      paramValues = param is Iterable ? param : json.decode(param);
    } catch (e) {
      return null;
    }
    if (paramValues is! Iterable) {
      return null;
    }
    return paramValues
        .map<T>((e) => deserializeStructParam<T>(e, paramType, false, structBuilder: structBuilder))
        .toList();
  } else if (param is Map<String, dynamic>) {
    return structBuilder(param);
  } else {
    return deserializeParam<T>(
      param,
      paramType,
      isList,
      structBuilder: structBuilder,
    );
  }
}

List<T>? getStructList<T>(
  dynamic value,
  StructBuilder<T> structBuilder,
) =>
    value is! List
        ? null
        : value
            .where((e) => e is Map<String, dynamic>)
            .map((e) => structBuilder(e as Map<String, dynamic>))
            .toList();

Color? getSchemaColor(dynamic value) => value is String
    ? _parseColor(value)
    : value is Color
        ? value
        : null;

// Parse color from hex or css color string
Color? _parseColor(String value) {
  // Try parsing as hex color first
  if (value.startsWith('#')) {
    return Color(int.parse(value.substring(1), radix: 16) + 0xFF000000);
  }
  // Default color if parsing fails
  return Colors.grey;
}

List<Color>? getColorsList(dynamic value) =>
    value is! List ? null : value.map(getSchemaColor).whereType<Color>().toList();

List<T>? getStructDataList<T>(dynamic value) =>
    value is! List ? null : value.map((e) => castToType<T>(e)).whereType<T>().toList();

// Helper for getting data lists from JSON
List<T>? getDataList<T>(dynamic value) => value is! List ? null : value.cast<T>();
