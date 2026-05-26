import 'package:statball/domain/index.dart' show ScoutRepository, Scout;

class ScoutUseCase {
  const ScoutUseCase({required ScoutRepository repository})
    : _repository = repository;

  final ScoutRepository _repository;

  Future<List<Scout>> getAll() => _repository.getAll();

  Future<Scout> getById(String id) => _repository.getById(id);

  Future<Scout> create(Scout scout) => _repository.create(scout);

  Future<Scout> update(Scout scout) => _repository.update(scout);

  Future<void> delete(String id) => _repository.delete(id);
}
