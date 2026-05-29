// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scout_match_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scoutMatchUseCase)
final scoutMatchUseCaseProvider = ScoutMatchUseCaseProvider._();

final class ScoutMatchUseCaseProvider
    extends
        $FunctionalProvider<
          ScoutMatchUseCase,
          ScoutMatchUseCase,
          ScoutMatchUseCase
        >
    with $Provider<ScoutMatchUseCase> {
  ScoutMatchUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scoutMatchUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scoutMatchUseCaseHash();

  @$internal
  @override
  $ProviderElement<ScoutMatchUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ScoutMatchUseCase create(Ref ref) {
    return scoutMatchUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScoutMatchUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScoutMatchUseCase>(value),
    );
  }
}

String _$scoutMatchUseCaseHash() => r'23b540ea5392307be3a3e0fa70fabbc87627aaa8';
