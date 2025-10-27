import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class MyApprovalPendingRejectState with _$MyApprovalPendingRejectState {
  const factory MyApprovalPendingRejectState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _MyApprovalPendingRejectState;

  factory MyApprovalPendingRejectState.fromJson(Map<String, dynamic> json) =>
      _$MyApprovalPendingRejectStateFromJson(json);
}
