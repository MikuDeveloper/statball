import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/providers/repositories/game_match_use_case_provider.dart';
// Sin `show GameMatch` para que GameMatchX (isUpcoming/isPast) entre en scope.
import 'package:statball/domain/index.dart';

part 'game_matches_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  GameMatchesNotifier — estado global de la programación de partidos.
//  keepAlive: true para que la lista persista entre navegaciones (scouts_matches
//  y matches_events leerán de aquí sin re-fetch).
//
//  Nota update*() en lugar de update() para no chocar con AsyncNotifier.update
//  (mismo patrón que adoptamos en FASE 1 tras el review).
// ════════════════════════════════════════════════════════════════════════════
@Riverpod(keepAlive: true)
class GameMatches extends _$GameMatches {
  @override
  Future<List<GameMatch>> build() {
    return ref.read(gameMatchUseCaseProvider).getAll();
  }

  Future<GameMatch> create(GameMatch match) async {
    final created = await ref.read(gameMatchUseCaseProvider).create(match);
    final next = [...(state.value ?? <GameMatch>[]), created]..sort(_compare);
    state = AsyncData(next);
    return created;
  }

  Future<GameMatch> updateMatch(GameMatch match) async {
    final updated = await ref.read(gameMatchUseCaseProvider).update(match);
    final next = [...(state.value ?? <GameMatch>[])];
    final idx = next.indexWhere((m) => m.id == updated.id);
    if (idx == -1) {
      next.add(updated);
    } else {
      next[idx] = updated;
    }
    next.sort(_compare);
    state = AsyncData(next);
    return updated;
  }

  Future<void> remove(int id) async {
    await ref.read(gameMatchUseCaseProvider).delete(id);
    final next = [...(state.value ?? <GameMatch>[])]
      ..removeWhere((m) => m.id == id);
    state = AsyncData(next);
  }

  Future<void> refresh() async {
    state = const AsyncLoading<List<GameMatch>>();
    state = await AsyncValue.guard(
      () => ref.read(gameMatchUseCaseProvider).getAll(),
    );
  }

  GameMatch? byId(int id) {
    final list = state.value;
    if (list == null) return null;
    for (final m in list) {
      if (m.id == id) return m;
    }
    return null;
  }

  List<GameMatch> get upcoming =>
      (state.value ?? const <GameMatch>[]).where((m) => m.isUpcoming).toList();

  List<GameMatch> get past =>
      (state.value ?? const <GameMatch>[]).where((m) => m.isPast).toList();

  // Más reciente primero (fecha desc). Los pasados quedan al final.
  int _compare(GameMatch a, GameMatch b) => b.date.compareTo(a.date);
}
