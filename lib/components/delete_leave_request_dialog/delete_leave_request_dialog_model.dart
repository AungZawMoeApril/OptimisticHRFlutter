import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class DeleteLeaveRequestDialogState with _$DeleteLeaveRequestDialogState {
  const factory DeleteLeaveRequestDialogState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _DeleteLeaveRequestDialogState;

  factory DeleteLeaveRequestDialogState.fromJson(Map<String, dynamic> json) =>
      _$DeleteLeaveRequestDialogStateFromJson(json);
}
