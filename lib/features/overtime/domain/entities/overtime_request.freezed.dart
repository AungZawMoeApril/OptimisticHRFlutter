// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'overtime_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OvertimeRequest _$OvertimeRequestFromJson(Map<String, dynamic> json) {
  return _OvertimeRequest.fromJson(json);
}

/// @nodoc
mixin _$OvertimeRequest {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get employeeName => throw _privateConstructorUsedError;
  DateTime get requestDate => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'PENDING', 'APPROVED', 'REJECTED'
  String? get approverNote => throw _privateConstructorUsedError;
  String? get approverId => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this OvertimeRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OvertimeRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OvertimeRequestCopyWith<OvertimeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OvertimeRequestCopyWith<$Res> {
  factory $OvertimeRequestCopyWith(
          OvertimeRequest value, $Res Function(OvertimeRequest) then) =
      _$OvertimeRequestCopyWithImpl<$Res, OvertimeRequest>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String employeeName,
      DateTime requestDate,
      DateTime startTime,
      DateTime endTime,
      String reason,
      String status,
      String? approverNote,
      String? approverId,
      DateTime? approvedAt,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$OvertimeRequestCopyWithImpl<$Res, $Val extends OvertimeRequest>
    implements $OvertimeRequestCopyWith<$Res> {
  _$OvertimeRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OvertimeRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? employeeName = null,
    Object? requestDate = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? reason = null,
    Object? status = null,
    Object? approverNote = freezed,
    Object? approverId = freezed,
    Object? approvedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      requestDate: null == requestDate
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      approverNote: freezed == approverNote
          ? _value.approverNote
          : approverNote // ignore: cast_nullable_to_non_nullable
              as String?,
      approverId: freezed == approverId
          ? _value.approverId
          : approverId // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OvertimeRequestImplCopyWith<$Res>
    implements $OvertimeRequestCopyWith<$Res> {
  factory _$$OvertimeRequestImplCopyWith(_$OvertimeRequestImpl value,
          $Res Function(_$OvertimeRequestImpl) then) =
      __$$OvertimeRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String employeeName,
      DateTime requestDate,
      DateTime startTime,
      DateTime endTime,
      String reason,
      String status,
      String? approverNote,
      String? approverId,
      DateTime? approvedAt,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$OvertimeRequestImplCopyWithImpl<$Res>
    extends _$OvertimeRequestCopyWithImpl<$Res, _$OvertimeRequestImpl>
    implements _$$OvertimeRequestImplCopyWith<$Res> {
  __$$OvertimeRequestImplCopyWithImpl(
      _$OvertimeRequestImpl _value, $Res Function(_$OvertimeRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of OvertimeRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? employeeName = null,
    Object? requestDate = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? reason = null,
    Object? status = null,
    Object? approverNote = freezed,
    Object? approverId = freezed,
    Object? approvedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$OvertimeRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      requestDate: null == requestDate
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      approverNote: freezed == approverNote
          ? _value.approverNote
          : approverNote // ignore: cast_nullable_to_non_nullable
              as String?,
      approverId: freezed == approverId
          ? _value.approverId
          : approverId // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OvertimeRequestImpl implements _OvertimeRequest {
  const _$OvertimeRequestImpl(
      {required this.id,
      required this.userId,
      required this.employeeName,
      required this.requestDate,
      required this.startTime,
      required this.endTime,
      required this.reason,
      required this.status,
      this.approverNote,
      this.approverId,
      this.approvedAt,
      required this.createdAt,
      this.updatedAt});

  factory _$OvertimeRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OvertimeRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String employeeName;
  @override
  final DateTime requestDate;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String reason;
  @override
  final String status;
// 'PENDING', 'APPROVED', 'REJECTED'
  @override
  final String? approverNote;
  @override
  final String? approverId;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'OvertimeRequest(id: $id, userId: $userId, employeeName: $employeeName, requestDate: $requestDate, startTime: $startTime, endTime: $endTime, reason: $reason, status: $status, approverNote: $approverNote, approverId: $approverId, approvedAt: $approvedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OvertimeRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.requestDate, requestDate) ||
                other.requestDate == requestDate) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approverNote, approverNote) ||
                other.approverNote == approverNote) &&
            (identical(other.approverId, approverId) ||
                other.approverId == approverId) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      employeeName,
      requestDate,
      startTime,
      endTime,
      reason,
      status,
      approverNote,
      approverId,
      approvedAt,
      createdAt,
      updatedAt);

  /// Create a copy of OvertimeRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OvertimeRequestImplCopyWith<_$OvertimeRequestImpl> get copyWith =>
      __$$OvertimeRequestImplCopyWithImpl<_$OvertimeRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OvertimeRequestImplToJson(
      this,
    );
  }
}

abstract class _OvertimeRequest implements OvertimeRequest {
  const factory _OvertimeRequest(
      {required final String id,
      required final String userId,
      required final String employeeName,
      required final DateTime requestDate,
      required final DateTime startTime,
      required final DateTime endTime,
      required final String reason,
      required final String status,
      final String? approverNote,
      final String? approverId,
      final DateTime? approvedAt,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$OvertimeRequestImpl;

  factory _OvertimeRequest.fromJson(Map<String, dynamic> json) =
      _$OvertimeRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get employeeName;
  @override
  DateTime get requestDate;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String get reason;
  @override
  String get status; // 'PENDING', 'APPROVED', 'REJECTED'
  @override
  String? get approverNote;
  @override
  String? get approverId;
  @override
  DateTime? get approvedAt;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of OvertimeRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OvertimeRequestImplCopyWith<_$OvertimeRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
