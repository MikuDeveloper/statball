import 'package:statball/domain/index.dart' show SchoolRepository, School;

class SchoolUseCase {
  const SchoolUseCase({required SchoolRepository repository})
    : _repository = repository;

  final SchoolRepository _repository;

  Future<List<School>> getAll() => _repository.getAll();

  Future<School> getById(int id) => _repository.getById(id);

  Future<School> create(School school) => _repository.create(school);

  Future<School> update(School school) => _repository.update(school);

  Future<void> delete(int id) => _repository.delete(id);
}
