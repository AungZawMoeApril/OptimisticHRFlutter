// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeavePageState _$LeavePageStateFromJson(Map<String, dynamic> json) {
  return _LeavePageState.fromJson(json);
}

/// @nodoc
mixin _$LeavePageState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this LeavePageState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeavePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeavePageStateCopyWith<LeavePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeavePageStateCopyWith<$Res> {
  factory $LeavePageStateCopyWith(
          LeavePageState value, $Res Function(LeavePageState) then) =
      _$LeavePageStateCopyWithImpl<$Res, LeavePageState>;
  @useResult
  $Res call({bool isLoading, bool isProcessing, String? error});
}

/// @nodoc
class _$LeavePageStateCopyWithImpl<$Res, $Val extends LeavePageState>
    implements $LeavePageStateCopyWith<$Res> {
  _$LeavePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeavePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProcessing = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeavePageStateImplCopyWith<$Res>
    implements $LeavePageStateCopyWith<$Res> {
  factory _$$LeavePageStateImplCopyWith(_$LeavePageStateImpl value,
          $Res Function(_$LeavePageStateImpl) then) =
      __$$LeavePageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, bool isProcessing, String? error});
}

/// @nodoc
class __$$LeavePageStateImplCopyWithImpl<$Res>
    extends _$LeavePageStateCopyWithImpl<$Res, _$LeavePageStateImpl>
    implements _$$LeavePageStateImplCopyWith<$Res> {
  __$$LeavePageStateImplCopyWithImpl(
      _$LeavePageStateImpl _value, $Res Function(_$LeavePageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeavePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProcessing = null,
    Object? error = freezed,
  }) {
    return _then(_$LeavePageStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeavePageStateImpl
    with DiagnosticableTreeMixin
    implements _LeavePageState {
  const _$LeavePageStateImpl(
      {this.isLoading = false, this.isProcessing = false, this.error});

  factory _$LeavePageStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeavePageStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isProcessing;
  @override
  final String? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LeavePageState(isLoading: $isLoading, isProcessing: $isProcessing, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LeavePageState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isProcessing', isProcessing))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeavePageStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isProcessing, error);

  /// Create a copy of LeavePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeavePageStateImplCopyWith<_$LeavePageStateImpl> get copyWith =>
      __$$LeavePageStateImplCopyWithImpl<_$LeavePageStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeavePageStateImplToJson(
      this,
    );
  }
}

abstract class _LeavePageState implements LeavePageState {
  const factory _LeavePageState(
      {final bool isLoading,
      final bool isProcessing,
      final String? error}) = _$LeavePageStateImpl;

  factory _LeavePageState.fromJson(Map<String, dynamic> json) =
      _$LeavePageStateImpl.fromJson;

  @override
  bool get isLoading;
  @override
  bool get isProcessing;
  @override
  String? get error;

  /// Create a copy of LeavePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeavePageStateImplCopyWith<_$LeavePageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
