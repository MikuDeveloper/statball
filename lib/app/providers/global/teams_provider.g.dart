// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Teams)
final teamsProvider = TeamsProvider._();

final class TeamsProvider extends $AsyncNotifierProvider<Teams, List<Team>> {
  TeamsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamsHash();

  @$internal
  @override
  Teams create() => Teams();
}

String _$teamsHash() => r'10cb642148de3b1df96592039eab32892237ed79';

abstract class _$Teams extends $AsyncNotifier<List<Team>> {
  FutureOr<List<Team>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Team>>, List<Team>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Team>>, List<Team>>,
              AsyncValue<List<Team>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
