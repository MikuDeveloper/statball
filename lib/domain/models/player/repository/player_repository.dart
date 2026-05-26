import 'package:statball/domain/index.dart' show Player;

abstract class PlayerRepository {
  Future<List<Player>> getAll();
  Future<List<Player>> getByTeam(String teamId);
  Future<Player> getById(String id);
  Future<Player> create(Player player);
  Future<Player> update(Player player);
  Future<void> delete(String id);
}
