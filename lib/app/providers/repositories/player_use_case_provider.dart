import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statball/domain/index.dart' show PlayerUseCase;
import 'package:statball/infrastructure/index.dart' show PlayerApi;

part 'player_use_case_provider.g.dart';

@Riverpod(keepAlive: true)
PlayerUseCase playerUseCase(Ref ref) {
  return PlayerUseCase(repository: PlayerApi());
}
