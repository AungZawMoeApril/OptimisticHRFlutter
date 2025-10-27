import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class ChangeLanguageComponentState with _$ChangeLanguageComponentState {
  const factory ChangeLanguageComponentState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _ChangeLanguageComponentState;

  factory ChangeLanguageComponentState.fromJson(Map<String, dynamic> json) =>
      _$ChangeLanguageComponentStateFromJson(json);
}
