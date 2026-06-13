// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matches_players_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MatchesPlayers)
final matchesPlayersProvider = MatchesPlayersFamily._();

final class MatchesPlayersProvider
    extends $AsyncNotifierProvider<MatchesPlayers, List<MatchesPlayer>> {
  MatchesPlayersProvider._({
    required MatchesPlayersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'matchesPlayersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$matchesPlayersHash();

  @override
  String toString() {
    return r'matchesPlayersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MatchesPlayers create() => MatchesPlayers();

  @override
  bool operator ==(Object other) {
    return other is MatchesPlayersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$matchesPlayersHash() => r'b926f74c39afd8bf408ce5a54614012f2c03b50f';

final class MatchesPlayersFamily extends $Family
    with
        $ClassFamilyOverride<
          MatchesPlayers,
          AsyncValue<List<MatchesPlayer>>,
          List<MatchesPlayer>,
          FutureOr<List<MatchesPlayer>>,
          int
        > {
  MatchesPlayersFamily._()
    : super(
        retry: null,
        name: r'matchesPlayersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MatchesPlayersProvider call(int matchId) =>
      MatchesPlayersProvider._(argument: matchId, from: this);

  @override
  String toString() => r'matchesPlayersProvider';
}

abstract class _$MatchesPlayers extends $AsyncNotifier<List<MatchesPlayer>> {
  late final _$args = ref.$arg as int;
  int get matchId => _$args;

  FutureOr<List<MatchesPlayer>> build(int matchId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<MatchesPlayer>>, List<MatchesPlayer>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MatchesPlayer>>, List<MatchesPlayer>>,
              AsyncValue<List<MatchesPlayer>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
