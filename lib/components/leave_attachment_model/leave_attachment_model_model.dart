import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class LeaveAttachmentModelState with _$LeaveAttachmentModelState {
  const factory LeaveAttachmentModelState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _LeaveAttachmentModelState;

  factory LeaveAttachmentModelState.fromJson(Map<String, dynamic> json) =>
      _$LeaveAttachmentModelStateFromJson(json);
}
