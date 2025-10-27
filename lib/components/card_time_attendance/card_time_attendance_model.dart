import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class CardTimeAttendanceState with _$CardTimeAttendanceState {
  const factory CardTimeAttendanceState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _CardTimeAttendanceState;

  factory CardTimeAttendanceState.fromJson(Map<String, dynamic> json) =>
      _$CardTimeAttendanceStateFromJson(json);
}
