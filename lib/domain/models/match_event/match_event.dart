import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_event.freezed.dart';
part 'match_event.g.dart';

@freezed
abstract class MatchEvent with _$MatchEvent {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MatchEvent({
    int? id,
    required String type,
    required String location,
    required int minute,
    @Default(<String, dynamic>{}) Map<String, dynamic> details,
    required int matchPlayerId,
    required int scoutMatchId,
  }) = _MatchEvent;

  factory MatchEvent.fromJson(Map<String, dynamic> json) =>
      _$MatchEventFromJson(json);
}
