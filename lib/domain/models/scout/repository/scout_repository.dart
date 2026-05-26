import 'package:statball/domain/index.dart' show Scout;

abstract class ScoutRepository {
  Future<List<Scout>> getAll();
  Future<Scout> getById(String id);
  Future<Scout> create(Scout scout);
  Future<Scout> update(Scout scout);
  Future<void> delete(String id);
}
