import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class WrongPinCodeComponentState with _$WrongPinCodeComponentState {
  const factory WrongPinCodeComponentState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _WrongPinCodeComponentState;

  factory WrongPinCodeComponentState.fromJson(Map<String, dynamic> json) =>
      _$WrongPinCodeComponentStateFromJson(json);
}
