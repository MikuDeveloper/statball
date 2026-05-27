import 'package:statball/domain/index.dart' show Team;

abstract class TeamRepository {
  Future<List<Team>> getAll();
  Future<List<Team>> getBySchool(int schoolId);
  Future<Team> getById(String id);
  Future<Team> create(Team team);
  Future<Team> update(Team team);
  Future<void> delete(String id);
}
