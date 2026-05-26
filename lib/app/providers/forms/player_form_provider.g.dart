// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(playerForm)
final playerFormProvider = PlayerFormProvider._();

final class PlayerFormProvider
    extends
        $FunctionalProvider<
          ({FormGroup form, String key}),
          ({FormGroup form, String key}),
          ({FormGroup form, String key})
        >
    with $Provider<({FormGroup form, String key})> {
  PlayerFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerFormHash();

  @$internal
  @override
  $ProviderElement<({FormGroup form, String key})> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ({FormGroup form, String key}) create(Ref ref) {
    return playerForm(ref);
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

String _$playerFormHash() => r'dce13aecf75037ad4e221bdf0250cc009bb2e145';
