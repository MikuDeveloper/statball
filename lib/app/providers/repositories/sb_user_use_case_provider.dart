import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statball/domain/index.dart' show SbUserUseCase;
import 'package:statball/infrastructure/index.dart' show SbUserApi;

part 'sb_user_use_case_provider.g.dart';

@Riverpod(keepAlive: true)
SbUserUseCase sbUserUseCase(Ref ref) {
  return SbUserUseCase(repository: SbUserApi());
}
