// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookie_and_privacy_policy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CookieAndPrivacyPolicyStateImpl _$$CookieAndPrivacyPolicyStateImplFromJson(
        Map<String, dynamic> json) =>
    _$CookieAndPrivacyPolicyStateImpl(
      isLoading: json['isLoading'] as bool? ?? false,
      isProcessing: json['isProcessing'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$CookieAndPrivacyPolicyStateImplToJson(
        _$CookieAndPrivacyPolicyStateImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'isProcessing': instance.isProcessing,
      'error': instance.error,
    };
