import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class MyApprovalPendingApproveState with _$MyApprovalPendingApproveState {
  const factory MyApprovalPendingApproveState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _MyApprovalPendingApproveState;

  factory MyApprovalPendingApproveState.fromJson(Map<String, dynamic> json) =>
      _$MyApprovalPendingApproveStateFromJson(json);
}
