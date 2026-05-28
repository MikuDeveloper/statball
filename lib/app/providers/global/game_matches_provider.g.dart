// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_matches_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GameMatches)
final gameMatchesProvider = GameMatchesProvider._();

final class GameMatchesProvider
    extends $AsyncNotifierProvider<GameMatches, List<GameMatch>> {
  GameMatchesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameMatchesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameMatchesHash();

  @$internal
  @override
  GameMatches create() => GameMatches();
}

String _$gameMatchesHash() => r'877253ac66e45e89f5898d1230141e7f39fa6bf3';

abstract class _$GameMatches extends $AsyncNotifier<List<GameMatch>> {
  FutureOr<List<GameMatch>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<GameMatch>>, List<GameMatch>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<GameMatch>>, List<GameMatch>>,
              AsyncValue<List<GameMatch>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
