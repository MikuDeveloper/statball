// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matches_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchesPlayer _$MatchesPlayerFromJson(
  Map<String, dynamic> json,
) => _MatchesPlayer(
  id: (json['id'] as num?)?.toInt(),
  matchId: (json['match_id'] as num).toInt(),
  playerId: json['player_id'] as String,
  position: _positionFromJson(json['position'] as String),
  statsPhysics:
      json['stats_physics'] as Map<String, dynamic>? ??
      const <String, dynamic>{},
  statsQual:
      json['stats_qual'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  statsTech:
      json['stats_tech'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  evaluationStatus: json['evaluation_status'] == null
      ? EvaluationStatus.enEvaluacion
      : _statusFromJson(json['evaluation_status'] as String),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$MatchesPlayerToJson(_MatchesPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'match_id': instance.matchId,
      'player_id': instance.playerId,
      'position': _positionToJson(instance.position),
      'stats_physics': instance.statsPhysics,
      'stats_qual': instance.statsQual,
      'stats_tech': instance.statsTech,
      'evaluation_status': _statusToJson(instance.evaluationStatus),
      'notes': instance.notes,
    };
