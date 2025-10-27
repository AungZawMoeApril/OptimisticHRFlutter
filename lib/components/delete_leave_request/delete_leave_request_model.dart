import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class DeleteLeaveRequestState with _$DeleteLeaveRequestState {
  const factory DeleteLeaveRequestState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _DeleteLeaveRequestState;

  factory DeleteLeaveRequestState.fromJson(Map<String, dynamic> json) =>
      _$DeleteLeaveRequestStateFromJson(json);
}
