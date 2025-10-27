import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class DeleteOTRequestDialogState with _$DeleteOTRequestDialogState {
  const factory DeleteOTRequestDialogState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _DeleteOTRequestDialogState;

  factory DeleteOTRequestDialogState.fromJson(Map<String, dynamic> json) =>
      _$DeleteOTRequestDialogStateFromJson(json);
}
