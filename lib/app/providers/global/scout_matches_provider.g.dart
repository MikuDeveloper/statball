// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scout_matches_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScoutMatches)
final scoutMatchesProvider = ScoutMatchesFamily._();

final class ScoutMatchesProvider
    extends $AsyncNotifierProvider<ScoutMatches, List<ScoutMatch>> {
  ScoutMatchesProvider._({
    required ScoutMatchesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'scoutMatchesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$scoutMatchesHash();

  @override
  String toString() {
    return r'scoutMatchesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ScoutMatches create() => ScoutMatches();

  @override
  bool operator ==(Object other) {
    return other is ScoutMatchesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$scoutMatchesHash() => r'8d6f9613b496af0e353bcc81099558e92277f1be';

final class ScoutMatchesFamily extends $Family
    with
        $ClassFamilyOverride<
          ScoutMatches,
          AsyncValue<List<ScoutMatch>>,
          List<ScoutMatch>,
          FutureOr<List<ScoutMatch>>,
          int
        > {
  ScoutMatchesFamily._()
    : super(
        retry: null,
        name: r'scoutMatchesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ScoutMatchesProvider call(int matchId) =>
      ScoutMatchesProvider._(argument: matchId, from: this);

  @override
  String toString() => r'scoutMatchesProvider';
}

abstract class _$ScoutMatches extends $AsyncNotifier<List<ScoutMatch>> {
  late final _$args = ref.$arg as int;
  int get matchId => _$args;

  FutureOr<List<ScoutMatch>> build(int matchId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ScoutMatch>>, List<ScoutMatch>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ScoutMatch>>, List<ScoutMatch>>,
              AsyncValue<List<ScoutMatch>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
