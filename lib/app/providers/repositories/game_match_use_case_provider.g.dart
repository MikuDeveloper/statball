// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_match_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gameMatchUseCase)
final gameMatchUseCaseProvider = GameMatchUseCaseProvider._();

final class GameMatchUseCaseProvider
    extends
        $FunctionalProvider<
          GameMatchUseCase,
          GameMatchUseCase,
          GameMatchUseCase
        >
    with $Provider<GameMatchUseCase> {
  GameMatchUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameMatchUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameMatchUseCaseHash();

  @$internal
  @override
  $ProviderElement<GameMatchUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GameMatchUseCase create(Ref ref) {
    return gameMatchUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameMatchUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameMatchUseCase>(value),
    );
  }
}

String _$gameMatchUseCaseHash() => r'8291bd64db1432a90627b28845b9e23c64def0f1';
