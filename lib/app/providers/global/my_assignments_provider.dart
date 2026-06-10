import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/app/providers/global/game_matches_provider.dart';
import 'package:statball/app/providers/repositories/scout_match_use_case_provider.dart';
// Sin `show` para que GameMatchX (isUpcoming/isPast) entre en scope.
import 'package:statball/domain/index.dart';

part 'my_assignments_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  MyAssignmentsEmptyReason — por qué la lista de visorías está vacía.
// ════════════════════════════════════════════════════════════════════════════
enum MyAssignmentsEmptyReason {
  noScoutLink, // El usuario auth no tiene ningún scout vinculado en scouts.user_id
  noAssignments, // Tiene scout vinculado pero sin visorías asignadas aún
}

// ════════════════════════════════════════════════════════════════════════════
//  myAssignmentsProvider — visorías asignadas al scout del usuario autenticado.
//
//  Flujo:
//    1. Llama a la RPC get_my_assignments() → filtra por auth.uid() vía
//       scouts.user_id internamente en Postgres.
//    2. Si devuelve datos → estado feliz.
//    3. Si devuelve vacío → consulta auxiliar para distinguir el motivo:
//       ¿existe algún scout con user_id = auth.uid()?
//       · No  → noScoutLink  (la pantalla muestra mensaje para contactar al coordinador)
//       · Sí  → noAssignments (scout vinculado, pero sin partidos asignados aún)
//
//  autoDispose: se libera al salir de la pantalla.
//  gameMatchesProvider (keepAlive) se usa para upcoming/past sin re-fetch.
// ════════════════════════════════════════════════════════════════════════════
typedef MyAssignmentsState = ({
  List<ScoutMatch> assignments,
  MyAssignmentsEmptyReason? emptyReason,
});

@riverpod
class MyAssignments extends _$MyAssignments {
  @override
  Future<MyAssignmentsState> build() async {
    final useCase = ref.read(scoutMatchUseCaseProvider);
    final assignments = await useCase.getMyAssignments();

    if (assignments.isNotEmpty) {
      return (assignments: assignments, emptyReason: null);
    }

    // Lista vacía: determinar por qué
    final hasLink = await _hasScoutLink();
    final reason = hasLink
        ? MyAssignmentsEmptyReason.noAssignments
        : MyAssignmentsEmptyReason.noScoutLink;
    return (assignments: const <ScoutMatch>[], emptyReason: reason);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(build);
  }

  // Asignaciones cuyo partido aún no ha ocurrido.
  List<ScoutMatch> get upcoming {
    final list = state.value?.assignments ?? const [];
    final matches = ref.read(gameMatchesProvider).value ?? const [];
    return list.where((sm) {
      final m = _matchById(matches, sm.matchId);
      return m != null && m.isUpcoming;
    }).toList();
  }

  // Asignaciones cuyo partido ya ocurrió.
  List<ScoutMatch> get past {
    final list = state.value?.assignments ?? const [];
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

  // Consulta auxiliar: ¿hay algún scout con user_id = auth.uid()?
  // Necesaria para diferenciar los dos empty states.
  Future<bool> _hasScoutLink() async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      if (uid == null) return false;
      final result = await Supabase.instance.client
          .from('scouts')
          .select('id')
          .eq('user_id', uid)
          .limit(1);
      return (result as List).isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
