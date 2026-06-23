// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Player _$PlayerFromJson(Map<String, dynamic> json) => _Player(
  id: json['id'] as String?,
  firstname: json['firstname'] as String,
  lastname: json['lastname'] as String,
  birthday: json['birthday'] == null
      ? null
      : DateTime.parse(json['birthday'] as String),
  height: _numFromJson(json['height']),
  weight: _numFromJson(json['weight']),
  notes: json['notes'] as String?,
  preferredFoot: _footFromJson(json['preferred_foot'] as String),
  basicForces: json['basic_forces'] as bool,
  city: json['city'] as String?,
  country: json['country'] as String?,
  photo: json['photo'] as String?,
  teamId: json['team_id'] as String?,
  scoutId: json['scout_id'] as String,
  defaultPosition: _positionFromJson(json['default_position'] as String),
);

Map<String, dynamic> _$PlayerToJson(_Player instance) => <String, dynamic>{
  'id': instance.id,
  'firstname': instance.firstname,
  'lastname': instance.lastname,
  'birthday': instance.birthday?.toIso8601String(),
  'height': _numToJson(instance.height),
  'weight': _numToJson(instance.weight),
  'notes': instance.notes,
  'preferred_foot': _footToJson(instance.preferredFoot),
  'basic_forces': instance.basicForces,
  'city': instance.city,
  'country': instance.country,
  'photo': instance.photo,
  'team_id': instance.teamId,
  'scout_id': instance.scoutId,
  'default_position': _positionToJson(instance.defaultPosition),
};
