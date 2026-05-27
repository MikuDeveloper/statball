// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_principals_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SchoolPrincipals)
final schoolPrincipalsProvider = SchoolPrincipalsProvider._();

final class SchoolPrincipalsProvider
    extends $AsyncNotifierProvider<SchoolPrincipals, List<SchoolPrincipal>> {
  SchoolPrincipalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'schoolPrincipalsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$schoolPrincipalsHash();

  @$internal
  @override
  SchoolPrincipals create() => SchoolPrincipals();
}

String _$schoolPrincipalsHash() => r'93f12f0e2c7e385ac266dac01548262780112292';

abstract class _$SchoolPrincipals
    extends $AsyncNotifier<List<SchoolPrincipal>> {
  FutureOr<List<SchoolPrincipal>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<SchoolPrincipal>>, List<SchoolPrincipal>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<SchoolPrincipal>>,
                List<SchoolPrincipal>
              >,
              AsyncValue<List<SchoolPrincipal>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
