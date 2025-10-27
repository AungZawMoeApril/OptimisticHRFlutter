import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class EditOvertimeRequestState with _$EditOvertimeRequestState {
  const factory EditOvertimeRequestState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _EditOvertimeRequestState;

  factory EditOvertimeRequestState.fromJson(Map<String, dynamic> json) =>
      _$EditOvertimeRequestStateFromJson(json);
}
