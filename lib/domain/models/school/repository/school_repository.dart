import 'package:statball/domain/index.dart' show School;

abstract class SchoolRepository {
  Future<List<School>> getAll();
  Future<School> getById(int id);
  Future<School> create(School school);
  Future<School> update(School school);
  Future<void> delete(int id);
}
