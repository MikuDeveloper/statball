import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/providers/repositories/school_principal_use_case_provider.dart';
import 'package:statball/domain/index.dart' show SchoolPrincipal;

part 'school_principals_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  SchoolPrincipalsNotifier — estado global del catálogo de directores.
//  keepAlive: true para conservar la lista entre navegaciones (el form de
//  escuelas necesita leerla para llenar el dropdown sin re-fetch).
// ════════════════════════════════════════════════════════════════════════════
@Riverpod(keepAlive: true)
class SchoolPrincipals extends _$SchoolPrincipals {
  @override
  Future<List<SchoolPrincipal>> build() {
    return ref.read(schoolPrincipalUseCaseProvider).getAll();
  }

  Future<SchoolPrincipal> create(SchoolPrincipal principal) async {
    final created = await ref
        .read(schoolPrincipalUseCaseProvider)
        .create(principal);
    final next = [...(state.value ?? <SchoolPrincipal>[]), created]
      ..sort(_compare);
    state = AsyncData(next);
    return created;
  }

  Future<SchoolPrincipal> updatePrincipal(SchoolPrincipal principal) async {
    final updated = await ref
        .read(schoolPrincipalUseCaseProvider)
        .update(principal);
    final next = [...(state.value ?? <SchoolPrincipal>[])];
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

  Future<void> remove(int id) async {
    await ref.read(schoolPrincipalUseCaseProvider).delete(id);
    final next = [...(state.value ?? <SchoolPrincipal>[])]
      ..removeWhere((p) => p.id == id);
    state = AsyncData(next);
  }

  Future<void> refresh() async {
    state = const AsyncLoading<List<SchoolPrincipal>>();
    state = await AsyncValue.guard(
      () => ref.read(schoolPrincipalUseCaseProvider).getAll(),
    );
  }

  SchoolPrincipal? byId(int id) {
    final list = state.value;
    if (list == null) return null;
    for (final p in list) {
      if (p.id == id) return p;
    }
    return null;
  }

  // Orden: apellido, luego nombre, ambos case-insensitive
  int _compare(SchoolPrincipal a, SchoolPrincipal b) {
    final byLast = a.lastname.toLowerCase().compareTo(b.lastname.toLowerCase());
    if (byLast != 0) return byLast;
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  }
}
