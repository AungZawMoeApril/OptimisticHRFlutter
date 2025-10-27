import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class OvertimeAttachmentModelState with _$OvertimeAttachmentModelState {
  const factory OvertimeAttachmentModelState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _OvertimeAttachmentModelState;

  factory OvertimeAttachmentModelState.fromJson(Map<String, dynamic> json) =>
      _$OvertimeAttachmentModelStateFromJson(json);
}
