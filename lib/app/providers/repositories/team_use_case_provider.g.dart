// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teamUseCase)
final teamUseCaseProvider = TeamUseCaseProvider._();

final class TeamUseCaseProvider
    extends $FunctionalProvider<TeamUseCase, TeamUseCase, TeamUseCase>
    with $Provider<TeamUseCase> {
  TeamUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamUseCaseHash();

  @$internal
  @override
  $ProviderElement<TeamUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeamUseCase create(Ref ref) {
    return teamUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeamUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeamUseCase>(value),
    );
  }
}

String _$teamUseCaseHash() => r'124e985990f5152907f7d6e4b67d724cfb234eed';
