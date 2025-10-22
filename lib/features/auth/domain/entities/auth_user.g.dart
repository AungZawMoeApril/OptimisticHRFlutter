// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserImpl _$$AuthUserImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      profileImage: json['profileImage'] as String?,
      isPinCodeSet: json['isPinCodeSet'] as bool,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
    );

Map<String, dynamic> _$$AuthUserImplToJson(_$AuthUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'profileImage': instance.profileImage,
      'isPinCodeSet': instance.isPinCodeSet,
      'roles': instance.roles,
      'isEmailVerified': instance.isEmailVerified,
      'lastLogin': instance.lastLogin?.toIso8601String(),
    };
