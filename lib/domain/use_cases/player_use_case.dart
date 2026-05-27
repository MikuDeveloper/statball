import 'package:statball/domain/index.dart' show PlayerRepository, Player;

class PlayerUseCase {
  const PlayerUseCase({required PlayerRepository repository})
    : _repository = repository;

  final PlayerRepository _repository;

  Future<List<Player>> getAll() => _repository.getAll();

  Future<List<Player>> getByTeam(String teamId) =>
      _repository.getByTeam(teamId);

  Future<Player> getById(String id) => _repository.getById(id);

  Future<Player> create(Player player) => _repository.create(player);

  Future<Player> update(Player player) => _repository.update(player);

  Future<void> delete(String id) => _repository.delete(id);
}
