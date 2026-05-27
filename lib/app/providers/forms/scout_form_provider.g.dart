// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scout_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scoutForm)
final scoutFormProvider = ScoutFormProvider._();

final class ScoutFormProvider
    extends
        $FunctionalProvider<
          ({FormGroup form, String key}),
          ({FormGroup form, String key}),
          ({FormGroup form, String key})
        >
    with $Provider<({FormGroup form, String key})> {
  ScoutFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scoutFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scoutFormHash();

  @$internal
  @override
  $ProviderElement<({FormGroup form, String key})> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ({FormGroup form, String key}) create(Ref ref) {
    return scoutForm(ref);
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

String _$scoutFormHash() => r'3541e9fdcfa685328e0cda4e520d406e35135c84';
