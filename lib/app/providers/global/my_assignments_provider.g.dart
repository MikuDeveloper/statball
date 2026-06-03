// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_assignments_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyAssignments)
final myAssignmentsProvider = MyAssignmentsProvider._();

final class MyAssignmentsProvider
    extends $AsyncNotifierProvider<MyAssignments, List<ScoutMatch>> {
  MyAssignmentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myAssignmentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myAssignmentsHash();

  @$internal
  @override
  MyAssignments create() => MyAssignments();
}

String _$myAssignmentsHash() => r'67a494c8b58dd2ca2f44e990aa46b1eb1d4f64ee';

abstract class _$MyAssignments extends $AsyncNotifier<List<ScoutMatch>> {
  FutureOr<List<ScoutMatch>> build();
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
    element.handleCreate(ref, build);
  }
}
