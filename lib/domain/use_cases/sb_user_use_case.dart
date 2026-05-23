import 'package:statball/domain/index.dart' show SbUserRepository, SbUser;

class SbUserUseCase {
  const SbUserUseCase({required SbUserRepository repository})
    : _repository = repository;

  final SbUserRepository _repository;

  Future<SbUser> getUserData() => _repository.getUserData();

  Future<SbUser> login({required String email, required String password}) {
    return _repository.login(email: email, password: password);
  }

  Future<void> sendResetPassEmail({required String email}) {
    return _repository.sendResetPassEmail(email: email);
  }

  Future<void> logout() => _repository.logout();

  bool isLoggedIn() => _repository.isLoggedIn();
}
