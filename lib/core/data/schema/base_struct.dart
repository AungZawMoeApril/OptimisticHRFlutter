import 'package:equatable/equatable.dart';

/// Base class for all structs that provides common functionality.
abstract class BaseStruct extends Equatable {
  const BaseStruct();

  /// Convert to a map suitable for serialization.
  Map<String, dynamic> toSerializableMap();

  @override
  List<Object?> get props => [toSerializableMap()];
}

/// Extension to remove null values from a map.
extension MapWithoutNulls on Map<String, dynamic> {
  Map<String, dynamic> get withoutNulls => Map.fromEntries(
        entries.where((e) => e.value != null).map((e) => MapEntry(e.key, e.value)),
      );
}