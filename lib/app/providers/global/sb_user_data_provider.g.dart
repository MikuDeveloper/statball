// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sb_user_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SbUserData)
final sbUserDataProvider = SbUserDataProvider._();

final class SbUserDataProvider
    extends $AsyncNotifierProvider<SbUserData, SbUser> {
  SbUserDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sbUserDataProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sbUserDataHash();

  @$internal
  @override
  SbUserData create() => SbUserData();
}

String _$sbUserDataHash() => r'00741a5f6da8c99d3e3f4e4f6e31fd951fd3bcda';

abstract class _$SbUserData extends $AsyncNotifier<SbUser> {
  FutureOr<SbUser> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SbUser>, SbUser>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SbUser>, SbUser>,
              AsyncValue<SbUser>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
