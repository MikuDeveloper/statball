// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameMatch _$GameMatchFromJson(Map<String, dynamic> json) => _GameMatch(
  id: (json['id'] as num?)?.toInt(),
  date: DateTime.parse(json['date'] as String),
  localTeamId: json['local_team_id'] as String,
  visitorTeamId: json['visitor_team_id'] as String,
);

Map<String, dynamic> _$GameMatchToJson(_GameMatch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'local_team_id': instance.localTeamId,
      'visitor_team_id': instance.visitorTeamId,
    };
