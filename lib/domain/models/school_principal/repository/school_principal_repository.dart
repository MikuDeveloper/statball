import 'package:statball/domain/index.dart' show SchoolPrincipal;

abstract class SchoolPrincipalRepository {
  Future<List<SchoolPrincipal>> getAll();
  Future<SchoolPrincipal> getById(int id);
  Future<SchoolPrincipal> create(SchoolPrincipal principal);
  Future<SchoolPrincipal> update(SchoolPrincipal principal);
  Future<void> delete(int id);
}
