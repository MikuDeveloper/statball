// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(schoolForm)
final schoolFormProvider = SchoolFormProvider._();

final class SchoolFormProvider
    extends
        $FunctionalProvider<
          ({FormGroup form, String key}),
          ({FormGroup form, String key}),
          ({FormGroup form, String key})
        >
    with $Provider<({FormGroup form, String key})> {
  SchoolFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'schoolFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$schoolFormHash();

  @$internal
  @override
  $ProviderElement<({FormGroup form, String key})> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ({FormGroup form, String key}) create(Ref ref) {
    return schoolForm(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({FormGroup form, String key}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<({FormGroup form, String key})>(
        value,
      ),
    );
  }
}

String _$schoolFormHash() => r'49b89b56c6ae467dab87fddec72f603fc4eda7bf';
