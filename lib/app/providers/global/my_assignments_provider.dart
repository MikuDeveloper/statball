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
  noScoutLink, // El usuario auth no tiene un scout vinculado
  noAssignments, // Tiene scout pero no hay visorías asignadas
}

// ════════════════════════════════════════════════════════════════════════════
//  myAssignmentsProvider — visorías asignadas al scout del usuario autenticado.
//
//  autoDispose: se libera al salir de la pantalla. keepAlive solo en
//  gameMatchesProvider (que ya es keepAlive) para resolver nombres de equipos.
//
//  Estado: (assignments: List<ScoutMatch>, emptyReason: MyAssignmentsEmptyReason?)
//    · emptyReason == null  → hay al menos una asignación
//    · emptyReason != null  → lista vacía; el valor explica por qué
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

    // Lista vacía: determinar si es por falta de vínculo scout↔cuenta
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

  // Filtra las asignaciones cuyo partido aún no ha ocurrido.
  List<ScoutMatch> get upcoming {
    final list = state.value?.assignments ?? const [];
    final matches = ref.read(gameMatchesProvider).value ?? const [];
    return list.where((sm) {
      final m = _matchById(matches, sm.matchId);
      return m != null && m.isUpcoming;
    }).toList();
  }

  // Filtra las asignaciones cuyo partido ya ocurrió.
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

  // Consulta directa: ¿hay algún scout con user_id = auth.uid()?
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
