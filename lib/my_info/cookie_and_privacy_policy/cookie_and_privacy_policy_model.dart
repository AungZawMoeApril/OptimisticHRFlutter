import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'cookie_and_privacy_policy_model.freezed.dart';
part 'cookie_and_privacy_policy_model.g.dart';

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
