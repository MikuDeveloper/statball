import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statball/domain/index.dart' show TeamUseCase;
import 'package:statball/infrastructure/index.dart' show TeamApi;

part 'team_use_case_provider.g.dart';

@Riverpod(keepAlive: true)
TeamUseCase teamUseCase(Ref ref) {
  return TeamUseCase(repository: TeamApi());
}
