import 'package:statball/domain/models/match_event/match_event.dart';

abstract class MatchEventRepository {
  Future<List<MatchEvent>> getByMatchPlayer(int matchPlayerId);
  Future<MatchEvent> create(MatchEvent event);
}
