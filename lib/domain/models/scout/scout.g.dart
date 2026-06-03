// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Scout _$ScoutFromJson(Map<String, dynamic> json) => _Scout(
  id: json['id'] as String?,
  name: json['name'] as String,
  lastname: json['lastname'] as String,
  birthday: DateTime.parse(json['birthday'] as String),
  phoneNumber: json['phone_number'] as String,
  address: json['address'] as String,
  photo: json['photo'] as String,
);

Map<String, dynamic> _$ScoutToJson(_Scout instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'lastname': instance.lastname,
  'birthday': instance.birthday.toIso8601String(),
  'phone_number': instance.phoneNumber,
  'address': instance.address,
  'photo': instance.photo,
};
