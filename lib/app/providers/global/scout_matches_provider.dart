import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/providers/repositories/scout_match_use_case_provider.dart';
import 'package:statball/domain/index.dart' show ScoutMatch;

part 'scout_matches_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  ScoutMatchesNotifier — asignaciones scout↔partido, scoped por matchId
//  (family). No keepAlive: se libera al salir del form del partido.
// ════════════════════════════════════════════════════════════════════════════
@riverpod
class ScoutMatches extends _$ScoutMatches {
  @override
  Future<List<ScoutMatch>> build(int matchId) {
    return ref.read(scoutMatchUseCaseProvider).getByMatch(matchId);
  }

  Future<void> assign({required String scoutId, required String notes}) async {
    final created = await ref
        .read(scoutMatchUseCaseProvider)
        .create(ScoutMatch(matchId: matchId, scoutId: scoutId, notes: notes));
    state = AsyncData([...(state.value ?? <ScoutMatch>[]), created]);
  }

  Future<void> updateAssignment(ScoutMatch scoutMatch) async {
    final updated = await ref
        .read(scoutMatchUseCaseProvider)
        .update(scoutMatch);
    final next = [...(state.value ?? <ScoutMatch>[])];
    final idx = next.indexWhere((s) => s.id == updated.id);
    if (idx != -1) next[idx] = updated;
    state = AsyncData(next);
  }

  Future<void> remove(int id) async {
    await ref.read(scoutMatchUseCaseProvider).delete(id);
    final next = [...(state.value ?? <ScoutMatch>[])]
      ..removeWhere((s) => s.id == id);
    state = AsyncData(next);
  }

  // IDs de scouts ya asignados, para filtrar el dropdown y evitar duplicados.
  Set<String> get assignedScoutIds =>
      (state.value ?? const <ScoutMatch>[]).map((s) => s.scoutId).toSet();
}
