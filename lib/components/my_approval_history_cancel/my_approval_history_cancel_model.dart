import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class MyApprovalHistoryCancelState with _$MyApprovalHistoryCancelState {
  const factory MyApprovalHistoryCancelState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _MyApprovalHistoryCancelState;

  factory MyApprovalHistoryCancelState.fromJson(Map<String, dynamic> json) =>
      _$MyApprovalHistoryCancelStateFromJson(json);
}
