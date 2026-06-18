// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_match_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveMatch)
final liveMatchProvider = LiveMatchFamily._();

final class LiveMatchProvider
    extends $NotifierProvider<LiveMatch, LiveMatchData> {
  LiveMatchProvider._({
    required LiveMatchFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'liveMatchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$liveMatchHash();

  @override
  String toString() {
    return r'liveMatchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LiveMatch create() => LiveMatch();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveMatchData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveMatchData>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LiveMatchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$liveMatchHash() => r'00ada10b0d357d57d73bce0279620d751ad84aef';

final class LiveMatchFamily extends $Family
    with
        $ClassFamilyOverride<
          LiveMatch,
          LiveMatchData,
          LiveMatchData,
          LiveMatchData,
          int
        > {
  LiveMatchFamily._()
    : super(
        retry: null,
        name: r'liveMatchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LiveMatchProvider call(int matchId) =>
      LiveMatchProvider._(argument: matchId, from: this);

  @override
  String toString() => r'liveMatchProvider';
}

abstract class _$LiveMatch extends $Notifier<LiveMatchData> {
  late final _$args = ref.$arg as int;
  int get matchId => _$args;

  LiveMatchData build(int matchId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LiveMatchData, LiveMatchData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LiveMatchData, LiveMatchData>,
              LiveMatchData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
