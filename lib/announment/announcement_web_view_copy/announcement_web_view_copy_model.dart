import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class AnnouncementWebViewCopyState with _$AnnouncementWebViewCopyState {
  const factory AnnouncementWebViewCopyState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _AnnouncementWebViewCopyState;

  factory AnnouncementWebViewCopyState.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementWebViewCopyStateFromJson(json);
}
