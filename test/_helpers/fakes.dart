// Fakes in-memory compartidos entre tests. Evitan tocar Supabase real al
// overridear los use case providers en un ProviderContainer.

import 'package:statball/app/global/enums.dart' show EvaluationStatus;
import 'package:statball/domain/index.dart'
    show GameMatch, GameMatchUseCase, ScoutMatch, ScoutMatchUseCase;
import 'package:statball/domain/models/match_event/match_event.dart';
import 'package:statball/domain/models/matches_player/matches_player.dart';
import 'package:statball/domain/use_cases/match_event_use_case.dart';
import 'package:statball/domain/use_cases/matches_player_use_case.dart';
import 'package:statball/infrastructure/helpers/exceptions/matches_player_api_exception.dart'
    show MatchesPlayerApiException;

// Fake mínimo del use case de partidos: solo `getAll` devuelve datos (lo que
// el provider llama en build). El resto lanza si se invoca por error.
class FakeGameMatchUseCase implements GameMatchUseCase {
  FakeGameMatchUseCase(this._data);
  final List<GameMatch> _data;

  @override
  Future<List<GameMatch>> getAll() async => _data;

  @override
  Future<GameMatch> getById(int id) => throw UnimplementedError();
  @override
  Future<GameMatch> create(GameMatch m) => throw UnimplementedError();
  @override
  Future<GameMatch> update(GameMatch m) => throw UnimplementedError();
  @override
  Future<void> delete(int id) => throw UnimplementedError();
  @override
  Future<int> autoInitializeMatchPlayers(int matchId) async => 0;
}

// Fake in-memory del use case de asignaciones scout↔partido: simula create
// (id incremental), getByMatch (lo acumulado por match) y delete.
class FakeScoutMatchUseCase implements ScoutMatchUseCase {
  final List<ScoutMatch> _store = [];
  int _seq = 0;

  @override
  Future<List<ScoutMatch>> getByMatch(int matchId) async =>
      _store.where((s) => s.matchId == matchId).toList();

  @override
  Future<ScoutMatch> create(ScoutMatch sm) async {
    final created = ScoutMatch(
      id: ++_seq,
      matchId: sm.matchId,
      scoutId: sm.scoutId,
      notes: sm.notes,
    );
    _store.add(created);
    return created;
  }

  @override
  Future<ScoutMatch> update(ScoutMatch sm) async {
    final idx = _store.indexWhere((s) => s.id == sm.id);
    if (idx != -1) _store[idx] = sm;
    return sm;
  }

  @override
  Future<void> delete(int id) async => _store.removeWhere((s) => s.id == id);

  @override
  Future<List<ScoutMatch>> getMyAssignments() async => List.of(_store);
}

// ── FakeMatchesPlayerUseCase ──────────────────────────────────────────────────
// In-memory store para matches_players en tests.
class FakeMatchesPlayerUseCase implements MatchesPlayerUseCase {
  FakeMatchesPlayerUseCase([List<MatchesPlayer>? initial])
    : _store = List.of(initial ?? const []);

  final List<MatchesPlayer> _store;
  int _seq = 0;

  @override
  Future<List<MatchesPlayer>> getByMatch(int matchId) async =>
      _store.where((p) => p.matchId == matchId).toList();

  @override
  Future<MatchesPlayer> create(MatchesPlayer player) async {
    final created = player.copyWith(id: ++_seq);
    _store.add(created);
    return created;
  }

  @override
  Future<MatchesPlayer> update(MatchesPlayer player) async {
    final idx = _store.indexWhere((p) => p.id == player.id);
    if (idx != -1) _store[idx] = player;
    return player;
  }

  @override
  Future<MatchesPlayer> updateStatus(int id, EvaluationStatus status) async {
    final idx = _store.indexWhere((p) => p.id == id);
    if (idx == -1) throw MatchesPlayerApiException('not_found');
    final updated = _store[idx].copyWith(evaluationStatus: status);
    _store[idx] = updated;
    return updated;
  }

  @override
  Future<void> delete(int id) async => _store.removeWhere((p) => p.id == id);
}

// ── FakeMatchEventUseCase ─────────────────────────────────────────────────────
class FakeMatchEventUseCase implements MatchEventUseCase {
  FakeMatchEventUseCase([List<MatchEvent>? initial])
    : _store = List.of(initial ?? const []);

  final List<MatchEvent> _store;
  int _seq = 0;

  @override
  Future<List<MatchEvent>> getByMatchPlayer(int matchPlayerId) async =>
      _store.where((e) => e.matchPlayerId == matchPlayerId).toList();

  @override
  Future<MatchEvent> create(MatchEvent event) async {
    final created = event.copyWith(id: ++_seq);
    _store.add(created);
    return created;
  }
}
