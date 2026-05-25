// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_principal_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(schoolPrincipalUseCase)
final schoolPrincipalUseCaseProvider = SchoolPrincipalUseCaseProvider._();

final class SchoolPrincipalUseCaseProvider
    extends
        $FunctionalProvider<
          SchoolPrincipalUseCase,
          SchoolPrincipalUseCase,
          SchoolPrincipalUseCase
        >
    with $Provider<SchoolPrincipalUseCase> {
  SchoolPrincipalUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'schoolPrincipalUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$schoolPrincipalUseCaseHash();

  @$internal
  @override
  $ProviderElement<SchoolPrincipalUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SchoolPrincipalUseCase create(Ref ref) {
    return schoolPrincipalUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SchoolPrincipalUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SchoolPrincipalUseCase>(value),
    );
  }
}

String _$schoolPrincipalUseCaseHash() =>
    r'ff17bca54d222642281077d100dca8f16c1bffaa';
