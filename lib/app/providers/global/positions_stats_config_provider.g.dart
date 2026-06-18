// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'positions_stats_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(positionsStatsConfig)
final positionsStatsConfigProvider = PositionsStatsConfigProvider._();

final class PositionsStatsConfigProvider
    extends
        $FunctionalProvider<
          AsyncValue<PositionsStatsConfig>,
          PositionsStatsConfig,
          FutureOr<PositionsStatsConfig>
        >
    with
        $FutureModifier<PositionsStatsConfig>,
        $FutureProvider<PositionsStatsConfig> {
  PositionsStatsConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'positionsStatsConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$positionsStatsConfigHash();

  @$internal
  @override
  $FutureProviderElement<PositionsStatsConfig> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PositionsStatsConfig> create(Ref ref) {
    return positionsStatsConfig(ref);
  }
}

String _$positionsStatsConfigHash() =>
    r'c3d9e352ee035df05446b5fc5887730bdce3e51a';
