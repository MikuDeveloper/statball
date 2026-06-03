import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/app/providers/global/scouts_provider.dart';
import 'package:statball/domain/index.dart' show SbUser, Scout;

part 'unlinked_scout_profiles_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  unlinkedScoutProfilesProvider — perfiles con rol 'scout' que aún NO están
//  vinculados a ningún scout del catálogo (scouts.user_id IS NULL o distinto).
//
//  Implementación client-side:
//    1. Trae todos los profiles con role='scout' desde Supabase.
//    2. Obtiene los scouts ya vinculados desde scoutsProvider (keepAlive).
//    3. Filtra en Dart los profiles cuyo id ya aparece en scouts.user_id.
//
//  Parámetro excludeScoutId: si se está editando un scout, excluirlo del filtro
//  para que su propio profile aparezca disponible en el dropdown de edición.
// ════════════════════════════════════════════════════════════════════════════
@riverpod
Future<List<SbUser>> unlinkedScoutProfiles(
  Ref ref, {
  String? excludeScoutId,
}) async {
  final supabase = Supabase.instance.client;

  final rawProfiles = await supabase
      .from('profiles')
      .select()
      .eq('role', 'scout')
      .order('email', ascending: true);

  final profiles = (rawProfiles as List)
      .map((e) => SbUser.fromJson(e as Map<String, dynamic>))
      .toList();

  // IDs de profiles ya vinculados (excepto el scout que estamos editando)
  final scouts = ref.watch(scoutsProvider).value ?? const <Scout>[];
  final linkedUserIds = scouts
      .where((s) => s.userId != null && s.id != excludeScoutId)
      .map((s) => s.userId!)
      .toSet();

  return profiles.where((p) => !linkedUserIds.contains(p.id)).toList();
}
