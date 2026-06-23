import 'package:statball/domain/index.dart' show GameMatchRepository, GameMatch;

class GameMatchUseCase {
  const GameMatchUseCase({required GameMatchRepository repository})
    : _repository = repository;

  final GameMatchRepository _repository;

  Future<List<GameMatch>> getAll() => _repository.getAll();

  Future<GameMatch> getById(int id) => _repository.getById(id);

  Future<GameMatch> create(GameMatch match) => _repository.create(match);

  Future<GameMatch> update(GameMatch match) => _repository.update(match);

  Future<void> delete(int id) => _repository.delete(id);

  Future<int> autoInitializeMatchPlayers(int matchId) =>
      _repository.autoInitializeMatchPlayers(matchId);
}
