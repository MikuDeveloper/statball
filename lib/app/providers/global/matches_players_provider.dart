import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/global/enums.dart' show EvaluationStatus;
import 'package:statball/app/providers/repositories/matches_player_use_case_provider.dart';
import 'package:statball/domain/models/matches_player/matches_player.dart';

part 'matches_players_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  MatchesPlayersNotifier — jugadores asignados a un partido, scoped por matchId.
//  autoDispose: se libera al salir de la pantalla de live match.
// ════════════════════════════════════════════════════════════════════════════
@riverpod
class MatchesPlayers extends _$MatchesPlayers {
  @override
  Future<List<MatchesPlayer>> build(int matchId) {
    return ref.read(matchesPlayerUseCaseProvider).getByMatch(matchId);
  }

  Future<void> add(MatchesPlayer player) async {
    final created = await ref.read(matchesPlayerUseCaseProvider).create(player);
    state = AsyncData([...(state.value ?? <MatchesPlayer>[]), created]);
  }

  Future<void> updateStatus(int id, EvaluationStatus status) async {
    final updated = await ref
        .read(matchesPlayerUseCaseProvider)
        .updateStatus(id, status);
    final next = [...(state.value ?? <MatchesPlayer>[])];
    final idx = next.indexWhere((p) => p.id == id);
    if (idx != -1) next[idx] = updated;
    state = AsyncData(next);
  }

  Future<void> remove(int id) async {
    await ref.read(matchesPlayerUseCaseProvider).delete(id);
    final next = [...(state.value ?? <MatchesPlayer>[])]
      ..removeWhere((p) => p.id == id);
    state = AsyncData(next);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(matchesPlayerUseCaseProvider).getByMatch(matchId),
    );
  }
}
