import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statball/domain/use_cases/match_event_use_case.dart';
import 'package:statball/infrastructure/driven_adapter/match_event/match_event_api.dart';

part 'match_event_use_case_provider.g.dart';

@Riverpod(keepAlive: true)
MatchEventUseCase matchEventUseCase(Ref ref) {
  return MatchEventUseCase(repository: MatchEventApi());
}
