// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlinked_scout_profiles_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(unlinkedScoutProfiles)
final unlinkedScoutProfilesProvider = UnlinkedScoutProfilesFamily._();

final class UnlinkedScoutProfilesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SbUser>>,
          List<SbUser>,
          FutureOr<List<SbUser>>
        >
    with $FutureModifier<List<SbUser>>, $FutureProvider<List<SbUser>> {
  UnlinkedScoutProfilesProvider._({
    required UnlinkedScoutProfilesFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'unlinkedScoutProfilesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$unlinkedScoutProfilesHash();

  @override
  String toString() {
    return r'unlinkedScoutProfilesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SbUser>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SbUser>> create(Ref ref) {
    final argument = this.argument as String?;
    return unlinkedScoutProfiles(ref, excludeScoutId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UnlinkedScoutProfilesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$unlinkedScoutProfilesHash() =>
    r'685f3baafc13829b557c750a2f23b1968fd78cb2';

final class UnlinkedScoutProfilesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SbUser>>, String?> {
  UnlinkedScoutProfilesFamily._()
    : super(
        retry: null,
        name: r'unlinkedScoutProfilesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UnlinkedScoutProfilesProvider call({String? excludeScoutId}) =>
      UnlinkedScoutProfilesProvider._(argument: excludeScoutId, from: this);

  @override
  String toString() => r'unlinkedScoutProfilesProvider';
}
