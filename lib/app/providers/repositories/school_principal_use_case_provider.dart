import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statball/domain/index.dart' show SchoolPrincipalUseCase;
import 'package:statball/infrastructure/index.dart' show SchoolPrincipalApi;

part 'school_principal_use_case_provider.g.dart';

@Riverpod(keepAlive: true)
SchoolPrincipalUseCase schoolPrincipalUseCase(Ref ref) {
  return SchoolPrincipalUseCase(repository: SchoolPrincipalApi());
}
