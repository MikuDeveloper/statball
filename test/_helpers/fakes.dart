// Fakes in-memory compartidos entre tests. Evitan tocar Supabase real al
// overridear los use case providers en un ProviderContainer.

import 'package:statball/domain/index.dart'
    show GameMatch, GameMatchUseCase, ScoutMatch, ScoutMatchUseCase;

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
