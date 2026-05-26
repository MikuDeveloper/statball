// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Players)
final playersProvider = PlayersProvider._();

final class PlayersProvider
    extends $AsyncNotifierProvider<Players, List<Player>> {
  PlayersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playersHash();

  @$internal
  @override
  Players create() => Players();
}

String _$playersHash() => r'2df25d47eb56d35c5a045441cfe1824b9ea821c3';

abstract class _$Players extends $AsyncNotifier<List<Player>> {
  FutureOr<List<Player>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Player>>, List<Player>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Player>>, List<Player>>,
              AsyncValue<List<Player>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
