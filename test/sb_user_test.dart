import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/providers/global/sb_user_data_provider.dart';
import 'package:statball/app/providers/repositories/sb_user_use_case_provider.dart';
import 'package:statball/domain/index.dart' show SbUser, SbUserUseCase, SbUserRepository;

// ─── Fake que completa logout sin tocar Supabase ──────────────────────────────
class _FakeSbUserRepository implements SbUserRepository {
  @override
  Future<void> logout() async {}

  @override
  Future<SbUser> getUserData() async => SbUser.empty();

  @override
  Future<SbUser> login({required String email, required String password}) =>
      throw UnimplementedError();

  @override
  Future<void> sendResetPassEmail({required String email}) =>
      throw UnimplementedError();

  @override
  bool isLoggedIn() => false;
}

class _FakeSbUserUseCase extends SbUserUseCase {
  _FakeSbUserUseCase()
      : super(repository: _FakeSbUserRepository());
}

void main() {
  group('sbUserDataProvider — logout', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          sbUserUseCaseProvider.overrideWithValue(_FakeSbUserUseCase()),
        ],
      );
    });
    tearDown(() => container.dispose());

    test('logout() setea el estado a SbUser.empty()', () async {
      // Primero forzamos un estado con datos para que el logout sea observable
      final notifier = container.read(sbUserDataProvider.notifier);
      await notifier.logout();

      final state = container.read(sbUserDataProvider);
      expect(state.hasValue, isTrue);
      expect(state.value?.id, '');
      expect(state.value?.email, '');
      expect(state.value?.role, 'guest');
    });

    test('logout() no lanza si el repositorio completa sin error', () async {
      final notifier = container.read(sbUserDataProvider.notifier);
      await expectLater(notifier.logout(), completes);
    });
  });
}
