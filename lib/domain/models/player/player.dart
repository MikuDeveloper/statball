import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:statball/app/global/enums.dart' show FootPreference;

part 'player.freezed.dart';
part 'player.g.dart';

// Converters non-null para el enum foot_enum (NOT NULL en el schema).
String _footToJson(FootPreference f) => f.dbValue;
FootPreference _footFromJson(String raw) => FootPreference.fromDb(raw);

// Postgres devuelve `numeric` como String para no perder precisión.
// Aceptamos String, num o null (la columna es ahora opcional).
double? _numFromJson(Object? raw) {
  if (raw == null) return null;
  if (raw is String) return double.tryParse(raw);
  if (raw is num) return raw.toDouble();
  return null;
}

double? _numToJson(double? v) => v;

@freezed
abstract class Player with _$Player {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Player({
    String? id,
    required String firstname,
    required String lastname,
    DateTime? birthday,
    @JsonKey(fromJson: _numFromJson, toJson: _numToJson) double? height,
    @JsonKey(fromJson: _numFromJson, toJson: _numToJson) double? weight,
    String? notes,
    @JsonKey(fromJson: _footFromJson, toJson: _footToJson)
    required FootPreference preferredFoot,
    required bool basicForces,
    String? city,
    String? country,
    String? photo,
    String? teamId,
    // FK NOT NULL a scouts.id — scout responsable del jugador en el portfolio.
    required String scoutId,
  }) = _Player;

  factory Player.empty() => const _Player(
    firstname: '',
    lastname: '',
    preferredFoot: FootPreference.derecha,
    basicForces: false,
    scoutId: '',
  );

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}

extension PlayerX on Player {
  String get fullName {
    final fn = firstname.trim();
    final ln = lastname.trim();
    if (fn.isEmpty) return ln;
    if (ln.isEmpty) return fn;
    return '$fn $ln';
  }

  // Edad calculada en años completos. Null si birthday no está registrado.
  int? get age {
    final bd = birthday;
    if (bd == null) return null;
    final now = DateTime.now();
    var years = now.year - bd.year;
    final hasHadBirthday =
        (now.month > bd.month) || (now.month == bd.month && now.day >= bd.day);
    if (!hasHadBirthday) years -= 1;
    return years;
  }
}
