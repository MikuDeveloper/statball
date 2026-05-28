import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statball/domain/index.dart' show ScoutMatchUseCase;
import 'package:statball/infrastructure/index.dart' show ScoutMatchApi;

part 'scout_match_use_case_provider.g.dart';

@Riverpod(keepAlive: true)
ScoutMatchUseCase scoutMatchUseCase(Ref ref) {
  return ScoutMatchUseCase(repository: ScoutMatchApi());
}
