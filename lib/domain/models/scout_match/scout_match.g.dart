// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scout_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScoutMatch _$ScoutMatchFromJson(Map<String, dynamic> json) => _ScoutMatch(
  id: (json['id'] as num?)?.toInt(),
  matchId: (json['match_id'] as num).toInt(),
  scoutId: json['scout_id'] as String,
  notes: json['notes'] as String,
);

Map<String, dynamic> _$ScoutMatchToJson(_ScoutMatch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'match_id': instance.matchId,
      'scout_id': instance.scoutId,
      'notes': instance.notes,
    };
