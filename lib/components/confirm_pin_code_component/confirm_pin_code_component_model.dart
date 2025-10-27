import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class ConfirmPinCodeComponentState with _$ConfirmPinCodeComponentState {
  const factory ConfirmPinCodeComponentState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _ConfirmPinCodeComponentState;

  factory ConfirmPinCodeComponentState.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPinCodeComponentStateFromJson(json);
}
