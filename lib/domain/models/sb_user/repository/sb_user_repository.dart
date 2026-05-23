import 'package:statball/domain/index.dart' show SbUser;

abstract class SbUserRepository {
  Future<SbUser> getUserData();
  Future<SbUser> login({required String email, required String password});
  Future<void> sendResetPassEmail({required String email});
  Future<void> logout();
  bool isLoggedIn();
}
