import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class OvertimeAttachmentModelsState with _$OvertimeAttachmentModelsState {
  const factory OvertimeAttachmentModelsState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _OvertimeAttachmentModelsState;

  factory OvertimeAttachmentModelsState.fromJson(Map<String, dynamic> json) =>
      _$OvertimeAttachmentModelsStateFromJson(json);
}
