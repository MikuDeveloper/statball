import 'package:freezed_annotation/freezed_annotation.dart';

part 'school.freezed.dart';
part 'school.g.dart';

@freezed
abstract class School with _$School {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory School({
    int? id,
    required String name,
    String? site,
    String? facebook,
    String? instagram,
    String? phoneNumber,
    String? email,
    String? city,
    String? state,
    String? country,
    int? principalId,
  }) = _School;

  factory School.empty() => const _School(name: '');

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);
}
