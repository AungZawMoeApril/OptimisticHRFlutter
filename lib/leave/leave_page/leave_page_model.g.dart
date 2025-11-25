// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeavePageStateImpl _$$LeavePageStateImplFromJson(Map<String, dynamic> json) =>
    _$LeavePageStateImpl(
      isLoading: json['isLoading'] as bool? ?? false,
      isProcessing: json['isProcessing'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$LeavePageStateImplToJson(
        _$LeavePageStateImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'isProcessing': instance.isProcessing,
      'error': instance.error,
    };
