import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_match.freezed.dart';
part 'game_match.g.dart';

// Renombrado a GameMatch (no Match) para evitar choque con dart:core.Match
// que viene de RegExp y aparece en cualquier archivo que importe material/dart.
@freezed
abstract class GameMatch with _$GameMatch {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GameMatch({
    int? id,
    required DateTime date,
    required String localTeamId,
    required String visitorTeamId,
  }) = _GameMatch;

  factory GameMatch.empty() =>
      _GameMatch(date: DateTime.now(), localTeamId: '', visitorTeamId: '');

  factory GameMatch.fromJson(Map<String, dynamic> json) =>
      _$GameMatchFromJson(json);
}

extension GameMatchX on GameMatch {
  // Etiqueta humana relativa al "ahora" para listados.
  // Ej: "Hoy 18:00", "Mañana 10:30", "Hace 2 días", "En 3 días"
  String get relativeLabel {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final matchDay = DateTime(date.year, date.month, date.day);
    final diffDays = matchDay.difference(today).inDays;
    final hh = date.hour.toString().padLeft(2, '0');
    final mm = date.minute.toString().padLeft(2, '0');
    final time = '$hh:$mm';

    if (diffDays == 0) return 'Hoy $time';
    if (diffDays == 1) return 'Mañana $time';
    if (diffDays == -1) return 'Ayer $time';
    if (diffDays > 1 && diffDays <= 7) return 'En $diffDays días · $time';
    if (diffDays < -1 && diffDays >= -7) return 'Hace ${-diffDays} días';

    // Fechas lejanas: usamos formato corto dd/MM/yyyy
    final dd = date.day.toString().padLeft(2, '0');
    final mo = date.month.toString().padLeft(2, '0');
    return '$dd/$mo/${date.year} · $time';
  }

  bool get isUpcoming => date.isAfter(DateTime.now());
  bool get isPast => !isUpcoming;
}
