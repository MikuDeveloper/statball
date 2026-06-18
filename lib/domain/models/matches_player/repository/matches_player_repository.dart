import 'package:statball/app/global/enums.dart' show EvaluationStatus;
import 'package:statball/domain/models/matches_player/matches_player.dart';

abstract class MatchesPlayerRepository {
  Future<List<MatchesPlayer>> getByMatch(int matchId);
  Future<MatchesPlayer> create(MatchesPlayer player);
  Future<MatchesPlayer> update(MatchesPlayer player);
  Future<MatchesPlayer> updateStatus(int id, EvaluationStatus status);
  Future<void> delete(int id);
}
