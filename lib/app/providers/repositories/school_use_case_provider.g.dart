// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(schoolUseCase)
final schoolUseCaseProvider = SchoolUseCaseProvider._();

final class SchoolUseCaseProvider
    extends $FunctionalProvider<SchoolUseCase, SchoolUseCase, SchoolUseCase>
    with $Provider<SchoolUseCase> {
  SchoolUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'schoolUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$schoolUseCaseHash();

  @$internal
  @override
  $ProviderElement<SchoolUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SchoolUseCase create(Ref ref) {
    return schoolUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SchoolUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SchoolUseCase>(value),
    );
  }
}

String _$schoolUseCaseHash() => r'9da56ae60454419e57881669fffea470d25a9d46';
