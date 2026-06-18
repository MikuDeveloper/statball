import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:statball/app/global/enums.dart'
    show EvaluationStatus, PlayerPosition;

part 'matches_player.freezed.dart';
part 'matches_player.g.dart';

String _positionToJson(PlayerPosition p) => p.dbValue;
PlayerPosition _positionFromJson(String raw) => PlayerPosition.fromDb(raw);
String _statusToJson(EvaluationStatus s) => s.dbValue;
EvaluationStatus _statusFromJson(String raw) => EvaluationStatus.fromDb(raw);

@freezed
abstract class MatchesPlayer with _$MatchesPlayer {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MatchesPlayer({
    int? id,
    required int matchId,
    required String playerId,
    @JsonKey(fromJson: _positionFromJson, toJson: _positionToJson)
    required PlayerPosition position,
    @Default(<String, dynamic>{}) Map<String, dynamic> statsPhysics,
    @Default(<String, dynamic>{}) Map<String, dynamic> statsQual,
    @Default(<String, dynamic>{}) Map<String, dynamic> statsTech,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    @Default(EvaluationStatus.enEvaluacion)
    EvaluationStatus evaluationStatus,
    String? notes,
  }) = _MatchesPlayer;

  factory MatchesPlayer.fromJson(Map<String, dynamic> json) =>
      _$MatchesPlayerFromJson(json);
}
