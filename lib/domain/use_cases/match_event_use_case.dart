import 'package:statball/domain/models/match_event/match_event.dart';
import 'package:statball/domain/models/match_event/repository/match_event_repository.dart';

class MatchEventUseCase {
  const MatchEventUseCase({required MatchEventRepository repository})
    : _repository = repository;

  final MatchEventRepository _repository;

  Future<List<MatchEvent>> getByMatchPlayer(int matchPlayerId) =>
      _repository.getByMatchPlayer(matchPlayerId);

  Future<MatchEvent> create(MatchEvent event) => _repository.create(event);
}
