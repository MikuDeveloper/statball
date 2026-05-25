import 'package:freezed_annotation/freezed_annotation.dart';

part 'school_principal.freezed.dart';
part 'school_principal.g.dart';

@freezed
abstract class SchoolPrincipal with _$SchoolPrincipal {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SchoolPrincipal({
    int? id,
    required String name,
    required String lastname,
    String? email,
    String? phoneNumber,
    String? instagram,
    String? facebook,
  }) = _SchoolPrincipal;

  factory SchoolPrincipal.empty() =>
      const _SchoolPrincipal(name: '', lastname: '');

  factory SchoolPrincipal.fromJson(Map<String, dynamic> json) =>
      _$SchoolPrincipalFromJson(json);
}

extension SchoolPrincipalX on SchoolPrincipal {
  // Nombre completo para mostrar en listados y dropdowns
  String get displayName {
    final ln = lastname.trim();
    final fn = name.trim();
    if (ln.isEmpty) return fn;
    if (fn.isEmpty) return ln;
    return '$fn $ln';
  }
}
