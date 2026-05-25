// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schools_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Schools)
final schoolsProvider = SchoolsProvider._();

final class SchoolsProvider
    extends $AsyncNotifierProvider<Schools, List<School>> {
  SchoolsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'schoolsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$schoolsHash();

  @$internal
  @override
  Schools create() => Schools();
}

String _$schoolsHash() => r'96f91068fa82593405771f9833a31c7d1497c0d2';

abstract class _$Schools extends $AsyncNotifier<List<School>> {
  FutureOr<List<School>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<School>>, List<School>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<School>>, List<School>>,
              AsyncValue<List<School>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
