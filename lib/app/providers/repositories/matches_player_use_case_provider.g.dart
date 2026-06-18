// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matches_player_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(matchesPlayerUseCase)
final matchesPlayerUseCaseProvider = MatchesPlayerUseCaseProvider._();

final class MatchesPlayerUseCaseProvider
    extends
        $FunctionalProvider<
          MatchesPlayerUseCase,
          MatchesPlayerUseCase,
          MatchesPlayerUseCase
        >
    with $Provider<MatchesPlayerUseCase> {
  MatchesPlayerUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'matchesPlayerUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$matchesPlayerUseCaseHash();

  @$internal
  @override
  $ProviderElement<MatchesPlayerUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MatchesPlayerUseCase create(Ref ref) {
    return matchesPlayerUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MatchesPlayerUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MatchesPlayerUseCase>(value),
    );
  }
}

String _$matchesPlayerUseCaseHash() =>
    r'9ec1fe55ceafd86269af9d953b4e93d407829855';
