import 'package:freezed_annotation/freezed_annotation.dart';

part 'scout.freezed.dart';
part 'scout.g.dart';

@freezed
abstract class Scout with _$Scout {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Scout({
    String? id,
    required String name,
    required String lastname,
    required DateTime birthday,
    required String phoneNumber,
    required String address,
    required String photo,
    // FK nullable a profiles.id. Vincula el scout a una cuenta de la app.
    // Catálogo y cuentas son entidades distintas — no es el shared-UUID pattern.
    String? userId,
  }) = _Scout;

  factory Scout.empty() => _Scout(
    name: '',
    lastname: '',
    birthday: DateTime.now(),
    phoneNumber: '',
    address: '',
    photo: '',
  );

  factory Scout.fromJson(Map<String, dynamic> json) => _$ScoutFromJson(json);
}

extension ScoutX on Scout {
  String get displayName {
    final fn = name.trim();
    final ln = lastname.trim();
    if (fn.isEmpty) return ln;
    if (ln.isEmpty) return fn;
    return '$fn $ln';
  }

  // Edad en años completos a partir de birthday.
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
