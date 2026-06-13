import 'package:statball/app/global/enums.dart' show EvaluationStatus;
import 'package:statball/domain/models/matches_player/matches_player.dart';
import 'package:statball/domain/models/matches_player/repository/matches_player_repository.dart';

class MatchesPlayerUseCase {
  const MatchesPlayerUseCase({required MatchesPlayerRepository repository})
    : _repository = repository;

  final MatchesPlayerRepository _repository;

  Future<List<MatchesPlayer>> getByMatch(int matchId) =>
      _repository.getByMatch(matchId);

  Future<MatchesPlayer> create(MatchesPlayer player) =>
      _repository.create(player);

  Future<MatchesPlayer> update(MatchesPlayer player) =>
      _repository.update(player);

  Future<MatchesPlayer> updateStatus(int id, EvaluationStatus status) =>
      _repository.updateStatus(id, status);

  Future<void> delete(int id) => _repository.delete(id);
}
