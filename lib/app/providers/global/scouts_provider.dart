import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/providers/repositories/scout_use_case_provider.dart';
import 'package:statball/domain/index.dart' show Scout;

part 'scouts_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  ScoutsNotifier — estado global del catálogo de scouts (visoreadores).
//  keepAlive: true para scouts_matches y dropdowns futuros.
// ════════════════════════════════════════════════════════════════════════════
@Riverpod(keepAlive: true)
class Scouts extends _$Scouts {
  @override
  Future<List<Scout>> build() {
    return ref.read(scoutUseCaseProvider).getAll();
  }

  Future<Scout> create(Scout scout) async {
    final created = await ref.read(scoutUseCaseProvider).create(scout);
    final next = [...(state.value ?? <Scout>[]), created]..sort(_compare);
    state = AsyncData(next);
    return created;
  }

  Future<Scout> updateScout(Scout scout) async {
    final updated = await ref.read(scoutUseCaseProvider).update(scout);
    final next = [...(state.value ?? <Scout>[])];
    final idx = next.indexWhere((s) => s.id == updated.id);
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
    await ref.read(scoutUseCaseProvider).delete(id);
    final next = [...(state.value ?? <Scout>[])]
      ..removeWhere((s) => s.id == id);
    state = AsyncData(next);
  }

  Future<void> refresh() async {
    state = const AsyncLoading<List<Scout>>();
    state = await AsyncValue.guard(
      () => ref.read(scoutUseCaseProvider).getAll(),
    );
  }

  Scout? byId(String id) {
    final list = state.value;
    if (list == null) return null;
    for (final s in list) {
      if (s.id == id) return s;
    }
    return null;
  }

  // Orden: apellido, luego nombre (case-insensitive)
  int _compare(Scout a, Scout b) {
    final byLast = a.lastname.toLowerCase().compareTo(b.lastname.toLowerCase());
    if (byLast != 0) return byLast;
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  }
}
