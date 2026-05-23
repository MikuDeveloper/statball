// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SbUser _$SbUserFromJson(Map<String, dynamic> json) => _SbUser(
  id: json['id'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$SbUserToJson(_SbUser instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'role': instance.role,
  'created_at': instance.createdAt.toIso8601String(),
};
