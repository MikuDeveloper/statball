// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_loading_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsLoading)
final isLoadingProvider = IsLoadingFamily._();

final class IsLoadingProvider extends $NotifierProvider<IsLoading, bool> {
  IsLoadingProvider._({
    required IsLoadingFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'isLoadingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isLoadingHash();

  @override
  String toString() {
    return r'isLoadingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IsLoading create() => IsLoading();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsLoadingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isLoadingHash() => r'fb97f6a85ec11ce251b763230bf47938863ed50c';

final class IsLoadingFamily extends $Family
    with $ClassFamilyOverride<IsLoading, bool, bool, bool, String> {
  IsLoadingFamily._()
    : super(
        retry: null,
        name: r'isLoadingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsLoadingProvider call(String key) =>
      IsLoadingProvider._(argument: key, from: this);

  @override
  String toString() => r'isLoadingProvider';
}

abstract class _$IsLoading extends $Notifier<bool> {
  late final _$args = ref.$arg as String;
  String get key => _$args;

  bool build(String key);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
