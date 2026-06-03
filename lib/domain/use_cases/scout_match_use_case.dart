import 'package:statball/domain/index.dart'
    show ScoutMatchRepository, ScoutMatch;

class ScoutMatchUseCase {
  const ScoutMatchUseCase({required ScoutMatchRepository repository})
    : _repository = repository;

  final ScoutMatchRepository _repository;

  Future<List<ScoutMatch>> getByMatch(int matchId) =>
      _repository.getByMatch(matchId);

  Future<ScoutMatch> create(ScoutMatch scoutMatch) =>
      _repository.create(scoutMatch);

  Future<ScoutMatch> update(ScoutMatch scoutMatch) =>
      _repository.update(scoutMatch);

  Future<void> delete(int id) => _repository.delete(id);

  Future<List<ScoutMatch>> getMyAssignments() => _repository.getMyAssignments();
}
