import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/providers/repositories/player_use_case_provider.dart';
import 'package:statball/domain/index.dart' show Player;

part 'players_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  PlayersNotifier — estado global del catálogo de jugadores.
//  keepAlive: true → preserva la lista entre navegaciones; matches y events
//  necesitarán leerla para sus dropdowns sin re-fetch.
// ════════════════════════════════════════════════════════════════════════════
@Riverpod(keepAlive: true)
class Players extends _$Players {
  @override
  Future<List<Player>> build() {
    return ref.read(playerUseCaseProvider).getAll();
  }

  Future<Player> create(Player player) async {
    final created = await ref.read(playerUseCaseProvider).create(player);
    final next = [...(state.value ?? <Player>[]), created]..sort(_compare);
    state = AsyncData(next);
    return created;
  }

  Future<Player> update(Player player) async {
    final updated = await ref.read(playerUseCaseProvider).update(player);
    final next = [...(state.value ?? <Player>[])];
    final idx = next.indexWhere((p) => p.id == updated.id);
    if (idx == -1) {
      next.add(updated);
    } else {
      next[idx] = updated;
    }
    next.sort(_compare);
    state = AsyncData(next);
    return updated;
  }

  Future<void> remove(String id) async {
    await ref.read(playerUseCaseProvider).delete(id);
    final next = [...(state.value ?? <Player>[])]
      ..removeWhere((p) => p.id == id);
    state = AsyncData(next);
  }

  Future<void> refresh() async {
    state = const AsyncLoading<List<Player>>();
    state = await AsyncValue.guard(
      () => ref.read(playerUseCaseProvider).getAll(),
    );
  }

  Player? byId(String id) {
    final list = state.value;
    if (list == null) return null;
    for (final p in list) {
      if (p.id == id) return p;
    }
    return null;
  }

  // Helper síncrono para filtrar por equipo desde el cache local
  List<Player> byTeam(String teamId) {
    final list = state.value ?? const <Player>[];
    return list.where((p) => p.teamId == teamId).toList();
  }

  // Orden: apellido, luego nombre (case-insensitive)
  int _compare(Player a, Player b) {
    final byLast = a.lastname.toLowerCase().compareTo(b.lastname.toLowerCase());
    if (byLast != 0) return byLast;
    return a.firstname.toLowerCase().compareTo(b.firstname.toLowerCase());
  }
}
