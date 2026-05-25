import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statball/domain/index.dart' show SchoolUseCase;
import 'package:statball/infrastructure/index.dart' show SchoolApi;

part 'school_use_case_provider.g.dart';

@Riverpod(keepAlive: true)
SchoolUseCase schoolUseCase(Ref ref) {
  return SchoolUseCase(repository: SchoolApi());
}
