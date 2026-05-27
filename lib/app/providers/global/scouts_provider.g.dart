// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scouts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Scouts)
final scoutsProvider = ScoutsProvider._();

final class ScoutsProvider extends $AsyncNotifierProvider<Scouts, List<Scout>> {
  ScoutsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scoutsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scoutsHash();

  @$internal
  @override
  Scouts create() => Scouts();
}

String _$scoutsHash() => r'f6b4dee5668505e0928c26a447779ecfbcee5636';

abstract class _$Scouts extends $AsyncNotifier<List<Scout>> {
  FutureOr<List<Scout>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Scout>>, List<Scout>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Scout>>, List<Scout>>,
              AsyncValue<List<Scout>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
