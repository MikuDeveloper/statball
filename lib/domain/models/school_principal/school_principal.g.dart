// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_principal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SchoolPrincipal _$SchoolPrincipalFromJson(Map<String, dynamic> json) =>
    _SchoolPrincipal(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      instagram: json['instagram'] as String?,
      facebook: json['facebook'] as String?,
    );

Map<String, dynamic> _$SchoolPrincipalToJson(_SchoolPrincipal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'instagram': instance.instagram,
      'facebook': instance.facebook,
    };
