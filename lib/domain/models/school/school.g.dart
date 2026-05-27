// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_School _$SchoolFromJson(Map<String, dynamic> json) => _School(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  site: json['site'] as String?,
  facebook: json['facebook'] as String?,
  instagram: json['instagram'] as String?,
  phoneNumber: json['phone_number'] as String?,
  email: json['email'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  principalId: (json['principal_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$SchoolToJson(_School instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'site': instance.site,
  'facebook': instance.facebook,
  'instagram': instance.instagram,
  'phone_number': instance.phoneNumber,
  'email': instance.email,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'principal_id': instance.principalId,
};
