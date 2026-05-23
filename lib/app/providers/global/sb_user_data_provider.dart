import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statball/app/providers/repositories/sb_user_use_case_provider.dart';
import 'package:statball/domain/index.dart' show SbUser, SbUserUseCase;

part 'sb_user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class SbUserData extends _$SbUserData {
  late final SbUserUseCase _useCase = ref.watch(sbUserUseCaseProvider);

  @override
  FutureOr<SbUser> build() {
    return SbUser.empty();
  }

  Future<void> fetchData() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _useCase.getUserData();
    });
  }

  Future<void> logout() async {
    state = await AsyncValue.guard(() async {
      await _useCase.logout();
      return SbUser.empty();
    });
  }
}
