import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:statball/app/providers/global/scouts_provider.dart';
import 'package:statball/domain/index.dart' show SbUser, Scout;

part 'unlinked_scout_profiles_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  unlinkedScoutProfilesProvider — profiles con role='scout' que aún NO están
//  vinculados a ningún registro del catálogo scouts (scouts.user_id IS NULL
//  o apunta a otro profile).
//
//  Implementación client-side:
//    1. Trae profiles con role='scout' desde Supabase.
//    2. Obtiene user_ids ya ocupados desde scoutsProvider (keepAlive).
//    3. Filtra en Dart los profiles cuyo id ya aparece en scouts.user_id.
//
//  Parámetro excludeScoutId: en modo edición, excluye este scout del conjunto
//  "ya vinculados" para que su propio profile vuelva a aparecer disponible.
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

  // IDs de profiles ya ocupados (excepto el scout que se está editando)
  final scouts = ref.watch(scoutsProvider).value ?? const <Scout>[];
  final linkedIds = scouts
      .where((s) => s.userId != null && s.id != excludeScoutId)
      .map((s) => s.userId!)
      .toSet();

  return profiles.where((p) => !linkedIds.contains(p.id)).toList();
}
