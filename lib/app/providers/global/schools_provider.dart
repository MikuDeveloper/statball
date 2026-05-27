import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/providers/repositories/school_use_case_provider.dart';
import 'package:statball/domain/index.dart' show School;

part 'schools_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  SchoolsNotifier — estado global de la lista de escuelas.
//  keepAlive: true → conserva la caché entre navegaciones para evitar
//  re-fetches y proteger contra pérdida de datos por mistouches.
// ════════════════════════════════════════════════════════════════════════════
@Riverpod(keepAlive: true)
class Schools extends _$Schools {
  @override
  Future<List<School>> build() {
    return ref.read(schoolUseCaseProvider).getAll();
  }

  Future<School> create(School school) async {
    final created = await ref.read(schoolUseCaseProvider).create(school);
    final next = [...(state.value ?? <School>[]), created]
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    state = AsyncData(next);
    return created;
  }

  Future<School> updateSchool(School school) async {
    final updated = await ref.read(schoolUseCaseProvider).update(school);
    final next = [...(state.value ?? <School>[])];
    final idx = next.indexWhere((s) => s.id == updated.id);
    if (idx == -1) {
      next.add(updated);
    } else {
      next[idx] = updated;
    }
    next.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    state = AsyncData(next);
    return updated;
  }

  Future<void> remove(int id) async {
    await ref.read(schoolUseCaseProvider).delete(id);
    final next = [...(state.value ?? <School>[])]
      ..removeWhere((s) => s.id == id);
    state = AsyncData(next);
  }

  Future<void> refresh() async {
    state = const AsyncLoading<List<School>>();
    state = await AsyncValue.guard(
      () => ref.read(schoolUseCaseProvider).getAll(),
    );
  }

  // Helper síncrono para hidratar el form de edición desde la lista cacheada
  School? byId(int id) {
    final list = state.value;
    if (list == null) return null;
    for (final s in list) {
      if (s.id == id) return s;
    }
    return null;
  }
}
