import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:statball/app/global/enums.dart' show FootPreference;

part 'player.freezed.dart';
part 'player.g.dart';

// Converters non-null para el enum foot_enum (NOT NULL en el schema).
String _footToJson(FootPreference f) => f.dbValue;
FootPreference _footFromJson(String raw) => FootPreference.fromDb(raw);

// Postgres devuelve `numeric` como String para no perder precisión. Convertimos
// a double aceptando tanto String como num por si la lib serializa distinto.
double _numFromJson(Object raw) =>
    raw is String ? double.parse(raw) : (raw as num).toDouble();

@freezed
abstract class Player with _$Player {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Player({
    String? id,
    required String firstname,
    required String lastname,
    required DateTime birthday,
    @JsonKey(fromJson: _numFromJson) required double height,
    @JsonKey(fromJson: _numFromJson) required double weight,
    required String notes,
    @JsonKey(fromJson: _footFromJson, toJson: _footToJson)
    required FootPreference preferredFoot,
    required bool basicForces,
    required String city,
    required String country,
    required String photo,
    String? teamId,
  }) = _Player;

  factory Player.empty() => _Player(
    firstname: '',
    lastname: '',
    birthday: DateTime.now(),
    height: 0,
    weight: 0,
    notes: '',
    preferredFoot: FootPreference.derecha,
    basicForces: false,
    city: '',
    country: '',
    photo: '',
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

  // Edad calculada a partir de birthday (años completos).
  int get age {
    final now = DateTime.now();
    var years = now.year - birthday.year;
    final hasHadBirthday =
        (now.month > birthday.month) ||
        (now.month == birthday.month && now.day >= birthday.day);
    if (!hasHadBirthday) years -= 1;
    return years;
  }
}
