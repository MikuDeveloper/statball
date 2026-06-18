// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_event_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(matchEventUseCase)
final matchEventUseCaseProvider = MatchEventUseCaseProvider._();

final class MatchEventUseCaseProvider
    extends
        $FunctionalProvider<
          MatchEventUseCase,
          MatchEventUseCase,
          MatchEventUseCase
        >
    with $Provider<MatchEventUseCase> {
  MatchEventUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'matchEventUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$matchEventUseCaseHash();

  @$internal
  @override
  $ProviderElement<MatchEventUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MatchEventUseCase create(Ref ref) {
    return matchEventUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MatchEventUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MatchEventUseCase>(value),
    );
  }
}

String _$matchEventUseCaseHash() => r'2954260cf0a3d2ae8862ccdbc3ead68be08c8540';
