// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scout_match_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scoutMatchForm)
final scoutMatchFormProvider = ScoutMatchFormProvider._();

final class ScoutMatchFormProvider
    extends
        $FunctionalProvider<
          ({FormGroup form, String key}),
          ({FormGroup form, String key}),
          ({FormGroup form, String key})
        >
    with $Provider<({FormGroup form, String key})> {
  ScoutMatchFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scoutMatchFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scoutMatchFormHash();

  @$internal
  @override
  $ProviderElement<({FormGroup form, String key})> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ({FormGroup form, String key}) create(Ref ref) {
    return scoutMatchForm(ref);
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

String _$scoutMatchFormHash() => r'ee9e947453a5119b8310ae5dbd604bb1fe850c7d';
