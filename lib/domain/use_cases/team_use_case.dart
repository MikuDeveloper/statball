import 'package:statball/domain/index.dart' show TeamRepository, Team;

class TeamUseCase {
  const TeamUseCase({required TeamRepository repository})
    : _repository = repository;

  final TeamRepository _repository;

  Future<List<Team>> getAll() => _repository.getAll();

  Future<List<Team>> getBySchool(int schoolId) =>
      _repository.getBySchool(schoolId);

  Future<Team> getById(String id) => _repository.getById(id);

  Future<Team> create(Team team) => _repository.create(team);

  Future<Team> update(Team team) => _repository.update(team);

  Future<void> delete(String id) => _repository.delete(id);
}
