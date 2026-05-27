import 'package:statball/domain/index.dart'
    show SchoolPrincipalRepository, SchoolPrincipal;

class SchoolPrincipalUseCase {
  const SchoolPrincipalUseCase({required SchoolPrincipalRepository repository})
    : _repository = repository;

  final SchoolPrincipalRepository _repository;

  Future<List<SchoolPrincipal>> getAll() => _repository.getAll();

  Future<SchoolPrincipal> getById(int id) => _repository.getById(id);

  Future<SchoolPrincipal> create(SchoolPrincipal principal) =>
      _repository.create(principal);

  Future<SchoolPrincipal> update(SchoolPrincipal principal) =>
      _repository.update(principal);

  Future<void> delete(int id) => _repository.delete(id);
}
