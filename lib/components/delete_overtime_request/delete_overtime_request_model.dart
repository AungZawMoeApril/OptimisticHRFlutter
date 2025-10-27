import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class DeleteOvertimeRequestState with _$DeleteOvertimeRequestState {
  const factory DeleteOvertimeRequestState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _DeleteOvertimeRequestState;

  factory DeleteOvertimeRequestState.fromJson(Map<String, dynamic> json) =>
      _$DeleteOvertimeRequestStateFromJson(json);
}
