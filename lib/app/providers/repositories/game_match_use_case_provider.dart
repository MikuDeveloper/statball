import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statball/domain/index.dart' show GameMatchUseCase;
import 'package:statball/infrastructure/index.dart' show GameMatchApi;

part 'game_match_use_case_provider.g.dart';

@Riverpod(keepAlive: true)
GameMatchUseCase gameMatchUseCase(Ref ref) {
  return GameMatchUseCase(repository: GameMatchApi());
}
