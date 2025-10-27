import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class ApprovalRejectFigmaDesignState with _$ApprovalRejectFigmaDesignState {
  const factory ApprovalRejectFigmaDesignState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _ApprovalRejectFigmaDesignState;

  factory ApprovalRejectFigmaDesignState.fromJson(Map<String, dynamic> json) =>
      _$ApprovalRejectFigmaDesignStateFromJson(json);
}
