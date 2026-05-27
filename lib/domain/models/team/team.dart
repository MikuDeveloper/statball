import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:statball/app/global/enums.dart' show TeamGender;

part 'team.freezed.dart';
part 'team.g.dart';

// El enum llega/sale como string desde Postgres ("Masculino" / "Femenino" /
// "Mixto"). Convertimos manualmente con estos helpers; el campo es non-null
// porque el schema lo exige.
String _genderToJson(TeamGender g) => g.dbValue;
TeamGender _genderFromJson(String raw) => TeamGender.fromDb(raw);

@freezed
abstract class Team with _$Team {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Team({
    String? id,
    required String name,
    required String category,
    @JsonKey(fromJson: _genderFromJson, toJson: _genderToJson)
    required TeamGender gender,
    required String coachName,
    required int schoolId,
  }) = _Team;

  factory Team.empty() => const _Team(
    name: '',
    category: '',
    gender: TeamGender.masculino,
    coachName: '',
    schoolId: 0,
  );

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}
