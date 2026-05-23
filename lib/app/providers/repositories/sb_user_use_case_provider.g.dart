// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_user_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sbUserUseCase)
final sbUserUseCaseProvider = SbUserUseCaseProvider._();

final class SbUserUseCaseProvider
    extends $FunctionalProvider<SbUserUseCase, SbUserUseCase, SbUserUseCase>
    with $Provider<SbUserUseCase> {
  SbUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sbUserUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sbUserUseCaseHash();

  @$internal
  @override
  $ProviderElement<SbUserUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SbUserUseCase create(Ref ref) {
    return sbUserUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SbUserUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SbUserUseCase>(value),
    );
  }
}

String _$sbUserUseCaseHash() => r'c71dca75ba6d51545efecbe66f152c5d8dc99bb2';
