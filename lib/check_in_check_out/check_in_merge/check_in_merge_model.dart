import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class CheckInMergeState with _$CheckInMergeState {
  const factory CheckInMergeState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _CheckInMergeState;

  factory CheckInMergeState.fromJson(Map<String, dynamic> json) =>
      _$CheckInMergeStateFromJson(json);
}
