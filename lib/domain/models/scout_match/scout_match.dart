import 'package:freezed_annotation/freezed_annotation.dart';

part 'scout_match.freezed.dart';
part 'scout_match.g.dart';

// Asignación de un scout a un partido (tabla puente scouts_matches).
@freezed
abstract class ScoutMatch with _$ScoutMatch {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ScoutMatch({
    int? id,
    required int matchId,
    required String scoutId,
    required String notes,
  }) = _ScoutMatch;

  factory ScoutMatch.empty() =>
      const _ScoutMatch(matchId: 0, scoutId: '', notes: '');

  factory ScoutMatch.fromJson(Map<String, dynamic> json) =>
      _$ScoutMatchFromJson(json);
}
