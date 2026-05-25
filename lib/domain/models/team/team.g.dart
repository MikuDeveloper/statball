// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Team _$TeamFromJson(Map<String, dynamic> json) => _Team(
  id: json['id'] as String?,
  name: json['name'] as String,
  category: json['category'] as String,
  gender: _genderFromJson(json['gender'] as String),
  coachName: json['coach_name'] as String,
  schoolId: (json['school_id'] as num).toInt(),
);

Map<String, dynamic> _$TeamToJson(_Team instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'gender': _genderToJson(instance.gender),
  'coach_name': instance.coachName,
  'school_id': instance.schoolId,
};
