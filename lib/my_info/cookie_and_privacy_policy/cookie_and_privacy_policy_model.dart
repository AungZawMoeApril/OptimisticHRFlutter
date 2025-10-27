import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class CookieAndPrivacyPolicyState with _$CookieAndPrivacyPolicyState {
  const factory CookieAndPrivacyPolicyState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _CookieAndPrivacyPolicyState;

  factory CookieAndPrivacyPolicyState.fromJson(Map<String, dynamic> json) =>
      _$CookieAndPrivacyPolicyStateFromJson(json);
}
