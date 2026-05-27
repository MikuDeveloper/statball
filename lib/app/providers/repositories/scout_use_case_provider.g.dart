// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scout_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scoutUseCase)
final scoutUseCaseProvider = ScoutUseCaseProvider._();

final class ScoutUseCaseProvider
    extends $FunctionalProvider<ScoutUseCase, ScoutUseCase, ScoutUseCase>
    with $Provider<ScoutUseCase> {
  ScoutUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scoutUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scoutUseCaseHash();

  @$internal
  @override
  $ProviderElement<ScoutUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ScoutUseCase create(Ref ref) {
    return scoutUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScoutUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScoutUseCase>(value),
    );
  }
}

String _$scoutUseCaseHash() => r'8dd4d64714373a7a4c8ba9a3d2a1e273c3880572';
