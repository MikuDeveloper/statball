import 'package:statball/domain/index.dart' show GameMatch;

abstract class GameMatchRepository {
  Future<List<GameMatch>> getAll();
  Future<GameMatch> getById(int id);
  Future<GameMatch> create(GameMatch match);
  Future<GameMatch> update(GameMatch match);
  Future<void> delete(int id);
}
