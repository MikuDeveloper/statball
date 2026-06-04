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
    extends $AsyncNotifierProvider<MyAssignments, MyAssignmentsState> {
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

String _$myAssignmentsHash() => r'793069583c74fafe927d6355ce6adb51670c07a6';

abstract class _$MyAssignments extends $AsyncNotifier<MyAssignmentsState> {
  FutureOr<MyAssignmentsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<MyAssignmentsState>, MyAssignmentsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MyAssignmentsState>, MyAssignmentsState>,
              AsyncValue<MyAssignmentsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
