import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statball/domain/use_cases/matches_player_use_case.dart';
import 'package:statball/infrastructure/driven_adapter/matches_player/matches_player_api.dart';

part 'matches_player_use_case_provider.g.dart';

@Riverpod(keepAlive: true)
MatchesPlayerUseCase matchesPlayerUseCase(Ref ref) {
  return MatchesPlayerUseCase(repository: MatchesPlayerApi());
}
