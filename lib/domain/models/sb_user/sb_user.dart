import 'package:freezed_annotation/freezed_annotation.dart';

part 'sb_user.freezed.dart';
part 'sb_user.g.dart';

@freezed
abstract class SbUser with _$SbUser {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SbUser({
    required String id,
    required String email,
    required String role,
    required DateTime createdAt,
  }) = _SbUser;

  factory SbUser.empty() =>
      _SbUser(id: '', email: '', role: 'guest', createdAt: DateTime.now());

  factory SbUser.fromJson(Map<String, dynamic> json) => _$SbUserFromJson(json);
}
