import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '${filename.replaceAll('.dart', '.freezed.dart')}';
part '${filename.replaceAll('.dart', '.g.dart')}';

@freezed
class AnnouncementWebViewState with _$AnnouncementWebViewState {
  const factory AnnouncementWebViewState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
    // TODO: Add your state properties here
  }) = _AnnouncementWebViewState;

  factory AnnouncementWebViewState.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementWebViewStateFromJson(json);
}
