import 'package:statball/domain/index.dart' show ScoutMatch;

abstract class ScoutMatchRepository {
  Future<List<ScoutMatch>> getByMatch(int matchId);
  Future<ScoutMatch> create(ScoutMatch scoutMatch);
  Future<ScoutMatch> update(ScoutMatch scoutMatch);
  Future<void> delete(int id);
}
