// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(playerUseCase)
final playerUseCaseProvider = PlayerUseCaseProvider._();

final class PlayerUseCaseProvider
    extends $FunctionalProvider<PlayerUseCase, PlayerUseCase, PlayerUseCase>
    with $Provider<PlayerUseCase> {
  PlayerUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerUseCaseHash();

  @$internal
  @override
  $ProviderElement<PlayerUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlayerUseCase create(Ref ref) {
    return playerUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerUseCase>(value),
    );
  }
}

String _$playerUseCaseHash() => r'6b643f12c160964c3a95c76116e2b375d58804f2';
