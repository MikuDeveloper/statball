import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_loading_provider.g.dart';

@riverpod
class IsLoading extends _$IsLoading {
  @override
  bool build(String key) => false;

  void setTrue() => state = true;
  void setFalse() => state = false;
}
