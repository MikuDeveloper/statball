import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/providers/repositories/match_event_use_case_provider.dart';
import 'package:statball/domain/models/match_event/match_event.dart';

part 'match_events_provider.g.dart';

// ════════════════════════════════════════════════════════════════════════════
//  MatchEventsNotifier — eventos de un jugador en un partido, scoped por
//  matchPlayerId (family). autoDispose: se libera al desseleccionar el jugador.
// ════════════════════════════════════════════════════════════════════════════
@riverpod
class MatchEvents extends _$MatchEvents {
  @override
  Future<List<MatchEvent>> build(int matchPlayerId) {
    return ref.read(matchEventUseCaseProvider).getByMatchPlayer(matchPlayerId);
  }

  Future<MatchEvent> add(MatchEvent event) async {
    final created = await ref.read(matchEventUseCaseProvider).create(event);
    state = AsyncData([...(state.value ?? <MatchEvent>[]), created]);
    return created;
  }

  int get count => state.value?.length ?? 0;
}
