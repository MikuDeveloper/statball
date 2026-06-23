import 'package:statball/domain/index.dart' show GameMatch;

abstract class GameMatchRepository {
  Future<List<GameMatch>> getAll();
  Future<GameMatch> getById(int id);
  Future<GameMatch> create(GameMatch match);
  Future<GameMatch> update(GameMatch match);
  Future<void> delete(int id);

  // Llama la RPC que precarga matches_players con los players del catálogo
  // cuyo team_id sea el local o visitor del match. Devuelve cuántos creó.
  Future<int> autoInitializeMatchPlayers(int matchId);
}
