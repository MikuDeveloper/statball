// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchEvent _$MatchEventFromJson(Map<String, dynamic> json) => _MatchEvent(
  id: (json['id'] as num?)?.toInt(),
  type: json['type'] as String,
  location: json['location'] as String,
  minute: (json['minute'] as num).toInt(),
  details:
      json['details'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  matchPlayerId: (json['match_player_id'] as num).toInt(),
  scoutMatchId: (json['scout_match_id'] as num).toInt(),
);

Map<String, dynamic> _$MatchEventToJson(_MatchEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'location': instance.location,
      'minute': instance.minute,
      'details': instance.details,
      'match_player_id': instance.matchPlayerId,
      'scout_match_id': instance.scoutMatchId,
    };
