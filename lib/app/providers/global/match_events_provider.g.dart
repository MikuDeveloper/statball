// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_events_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MatchEvents)
final matchEventsProvider = MatchEventsFamily._();

final class MatchEventsProvider
    extends $AsyncNotifierProvider<MatchEvents, List<MatchEvent>> {
  MatchEventsProvider._({
    required MatchEventsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'matchEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$matchEventsHash();

  @override
  String toString() {
    return r'matchEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MatchEvents create() => MatchEvents();

  @override
  bool operator ==(Object other) {
    return other is MatchEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$matchEventsHash() => r'ba649b3a40e3673364aa8a4ebd544845f4a1bd8f';

final class MatchEventsFamily extends $Family
    with
        $ClassFamilyOverride<
          MatchEvents,
          AsyncValue<List<MatchEvent>>,
          List<MatchEvent>,
          FutureOr<List<MatchEvent>>,
          int
        > {
  MatchEventsFamily._()
    : super(
        retry: null,
        name: r'matchEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MatchEventsProvider call(int matchPlayerId) =>
      MatchEventsProvider._(argument: matchPlayerId, from: this);

  @override
  String toString() => r'matchEventsProvider';
}

abstract class _$MatchEvents extends $AsyncNotifier<List<MatchEvent>> {
  late final _$args = ref.$arg as int;
  int get matchPlayerId => _$args;

  FutureOr<List<MatchEvent>> build(int matchPlayerId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<MatchEvent>>, List<MatchEvent>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MatchEvent>>, List<MatchEvent>>,
              AsyncValue<List<MatchEvent>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
