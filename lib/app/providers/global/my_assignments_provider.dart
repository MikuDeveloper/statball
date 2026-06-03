import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/providers/global/game_matches_provider.dart';
import 'package:statball/app/providers/repositories/scout_match_use_case_provider.dart';
// Sin `show` para que GameMatchX (isUpcoming/isPast) entre en scope.
import 'package:statball/domain/index.dart';

part 'my_assignments_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  myAssignmentsProvider — visorías asignadas al scout del usuario autenticado.
//
//  Llama a la RPC get_my_assignments() y devuelve la lista directamente.
//  Cómo funciona el filtro en DB (scouts.user_id) es un detalle de Supabase;
//  Flutter no necesita saberlo.
//
//  autoDispose: se libera al salir de la pantalla.
//  gameMatchesProvider (keepAlive) se usa para resolver upcoming/past.
// ════════════════════════════════════════════════════════════════════════════
@riverpod
class MyAssignments extends _$MyAssignments {
  @override
  Future<List<ScoutMatch>> build() {
    return ref.read(scoutMatchUseCaseProvider).getMyAssignments();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(build);
  }

  // Asignaciones cuyo partido aún no ha ocurrido.
  List<ScoutMatch> get upcoming {
    final list = state.value ?? const [];
    final matches = ref.read(gameMatchesProvider).value ?? const [];
    return list.where((sm) {
      final m = _matchById(matches, sm.matchId);
      return m != null && m.isUpcoming;
    }).toList();
  }

  // Asignaciones cuyo partido ya ocurrió.
  List<ScoutMatch> get past {
    final list = state.value ?? const [];
    final matches = ref.read(gameMatchesProvider).value ?? const [];
    return list.where((sm) {
      final m = _matchById(matches, sm.matchId);
      return m != null && m.isPast;
    }).toList();
  }

  GameMatch? _matchById(List<GameMatch> matches, int id) {
    for (final m in matches) {
      if (m.id == id) return m;
    }
    return null;
  }
}
