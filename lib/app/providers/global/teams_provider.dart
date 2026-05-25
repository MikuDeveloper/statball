import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/providers/repositories/team_use_case_provider.dart';
import 'package:statball/domain/index.dart' show Team;

part 'teams_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  TeamsNotifier — estado global del catálogo de equipos.
//  keepAlive: true → preserva la lista entre navegaciones; matches y players
//  necesitarán leerla para sus dropdowns sin re-fetch.
// ════════════════════════════════════════════════════════════════════════════
@Riverpod(keepAlive: true)
class Teams extends _$Teams {
  @override
  Future<List<Team>> build() {
    return ref.read(teamUseCaseProvider).getAll();
  }

  Future<Team> create(Team team) async {
    final created = await ref.read(teamUseCaseProvider).create(team);
    final next = [...(state.value ?? <Team>[]), created]..sort(_compare);
    state = AsyncData(next);
    return created;
  }

  Future<Team> update(Team team) async {
    final updated = await ref.read(teamUseCaseProvider).update(team);
    final next = [...(state.value ?? <Team>[])];
    final idx = next.indexWhere((t) => t.id == updated.id);
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
    await ref.read(teamUseCaseProvider).delete(id);
    final next = [...(state.value ?? <Team>[])]..removeWhere((t) => t.id == id);
    state = AsyncData(next);
  }

  Future<void> refresh() async {
    state = const AsyncLoading<List<Team>>();
    state = await AsyncValue.guard(
      () => ref.read(teamUseCaseProvider).getAll(),
    );
  }

  Team? byId(String id) {
    final list = state.value;
    if (list == null) return null;
    for (final t in list) {
      if (t.id == id) return t;
    }
    return null;
  }

  // Helper síncrono para filtrar por escuela desde el cache local
  List<Team> bySchool(int schoolId) {
    final list = state.value ?? const <Team>[];
    return list.where((t) => t.schoolId == schoolId).toList();
  }

  int _compare(Team a, Team b) =>
      a.name.toLowerCase().compareTo(b.name.toLowerCase());
}
