import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statball/domain/index.dart' show ScoutUseCase;
import 'package:statball/infrastructure/index.dart' show ScoutApi;

part 'scout_use_case_provider.g.dart';

@Riverpod(keepAlive: true)
ScoutUseCase scoutUseCase(Ref ref) {
  return ScoutUseCase(repository: ScoutApi());
}
