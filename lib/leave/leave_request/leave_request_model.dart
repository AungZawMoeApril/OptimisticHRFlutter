import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class LeaveRequestState with _$LeaveRequestState {
  const factory LeaveRequestState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _LeaveRequestState;

  factory LeaveRequestState.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestStateFromJson(json);
}
