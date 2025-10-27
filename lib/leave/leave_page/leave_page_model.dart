import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class LeavePageState with _$LeavePageState {
  const factory LeavePageState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _LeavePageState;

  factory LeavePageState.fromJson(Map<String, dynamic> json) =>
      _$LeavePageStateFromJson(json);
}
