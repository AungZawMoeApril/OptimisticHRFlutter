import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class MyApprovalAttachmentModelState with _$MyApprovalAttachmentModelState {
  const factory MyApprovalAttachmentModelState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _MyApprovalAttachmentModelState;

  factory MyApprovalAttachmentModelState.fromJson(Map<String, dynamic> json) =>
      _$MyApprovalAttachmentModelStateFromJson(json);
}
