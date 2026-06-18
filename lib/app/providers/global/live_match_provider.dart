import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/providers/global/match_events_provider.dart';
import 'package:statball/app/providers/global/my_assignments_provider.dart';
import 'package:statball/domain/models/match_event/match_event.dart';
import 'package:statball/infrastructure/helpers/exceptions/match_event_api_exception.dart';

part 'live_match_provider.freezed.dart';
part 'live_match_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  LiveMatchData — estado UI de la pantalla de captura en vivo.
//  NO se persiste entre sesiones. El cronómetro se reinicia cada vez.
// ════════════════════════════════════════════════════════════════════════════
@freezed
abstract class LiveMatchData with _$LiveMatchData {
  const factory LiveMatchData({
    required int matchId,
    // scouts_matches.id del usuario para este partido (null = usuario sin link)
    int? scoutMatchId,
    // jugador seleccionado en el sidebar (matches_players.id)
    int? selectedPlayerId,
    // tipo de evento seleccionado (key en event_types del JSON)
    String? selectedEventType,
    // zona seleccionada del grid 3×3 (código NX: "1I", "2C", etc.)
    String? selectedZone,
    // detalles del evento en curso (booleans y enums del config JSON)
    @Default(<String, dynamic>{}) Map<String, dynamic> eventDetails,
    // nota rápida editable antes de guardar
    @Default('') String quickNote,
    // minuto actual del cronómetro (no persiste)
    @Default(0) int currentMinute,
    // si el cronómetro está corriendo
    @Default(false) bool clockRunning,
  }) = _LiveMatchData;
}

// ════════════════════════════════════════════════════════════════════════════
//  LiveMatchState — notifier UI para la pantalla de live match.
//  Parameterizado por matchId. autoDispose al salir de la pantalla.
// ════════════════════════════════════════════════════════════════════════════
@riverpod
class LiveMatch extends _$LiveMatch {
  Timer? _clockTimer;

  @override
  LiveMatchData build(int matchId) {
    ref.onDispose(() => _clockTimer?.cancel());

    // Busca el scouts_matches.id del usuario para este partido.
    final assignments =
        ref.watch(myAssignmentsProvider).value?.assignments ?? const [];
    final myAssignment = assignments.where((a) => a.matchId == matchId).firstOrNull;

    return LiveMatchData(matchId: matchId, scoutMatchId: myAssignment?.id);
  }

  // ── Selección de jugador ───────────────────────────────────────────────────
  void selectPlayer(int matchesPlayerId) {
    // Al cambiar de jugador limpiamos el form de evento pero no el minuto.
    state = state.copyWith(
      selectedPlayerId: matchesPlayerId,
      selectedEventType: null,
      selectedZone: null,
      eventDetails: const <String, dynamic>{},
      quickNote: '',
    );
  }

  // ── Selección de tipo de evento ───────────────────────────────────────────
  void selectEventType(String type) {
    state = state.copyWith(
      selectedEventType: type,
      selectedZone: null,
      eventDetails: const <String, dynamic>{},
    );
  }

  // ── Selección de zona ─────────────────────────────────────────────────────
  void selectZone(String code) {
    state = state.copyWith(selectedZone: code);
  }

  // ── Detalle: boolean toggle ───────────────────────────────────────────────
  void toggleDetailBool(String key) {
    final current = state.eventDetails[key] as bool? ?? false;
    state = state.copyWith(
      eventDetails: {...state.eventDetails, key: !current},
    );
  }

  // ── Detalle: enum set ─────────────────────────────────────────────────────
  void setDetailEnum(String key, String value) {
    state = state.copyWith(
      eventDetails: {...state.eventDetails, key: value},
    );
  }

  // ── Nota rápida ───────────────────────────────────────────────────────────
  void setQuickNote(String text) {
    state = state.copyWith(quickNote: text);
  }

  // ── Limpiar form de evento ────────────────────────────────────────────────
  void clearEventForm() {
    state = state.copyWith(
      selectedEventType: null,
      selectedZone: null,
      eventDetails: const <String, dynamic>{},
      quickNote: '',
    );
  }

  // ── Cronómetro ────────────────────────────────────────────────────────────
  void setMinute(int minute) {
    state = state.copyWith(currentMinute: minute);
  }

  void startClock() {
    if (state.clockRunning) return;
    state = state.copyWith(clockRunning: true);
    _clockTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      state = state.copyWith(currentMinute: state.currentMinute + 1);
    });
  }

  void pauseClock() {
    _clockTimer?.cancel();
    state = state.copyWith(clockRunning: false);
  }

  void resetClock() {
    _clockTimer?.cancel();
    state = state.copyWith(currentMinute: 0, clockRunning: false);
  }

  // ── Guardar evento ────────────────────────────────────────────────────────
  // Lanza MatchEventApiException si falla. La pantalla captura el error.
  Future<void> saveEvent() async {
    final playerId = state.selectedPlayerId;
    final type = state.selectedEventType;
    final zone = state.selectedZone;
    final scoutMatchId = state.scoutMatchId;

    if (playerId == null || type == null || zone == null) {
      throw ArgumentError('Faltan campos obligatorios');
    }
    if (scoutMatchId == null) {
      throw MatchEventApiException('permission_denied');
    }

    final event = MatchEvent(
      type: type,
      location: zone,
      minute: state.currentMinute,
      details: Map<String, dynamic>.from(state.eventDetails),
      matchPlayerId: playerId,
      scoutMatchId: scoutMatchId,
    );

    await ref.read(matchEventsProvider(playerId).notifier).add(event);
    clearEventForm();
  }
}
