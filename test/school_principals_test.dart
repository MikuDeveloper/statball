import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/providers/forms/school_principal_form_provider.dart';
import 'package:statball/domain/index.dart'
    show SchoolPrincipal, SchoolPrincipalX;

void main() {
  group('SchoolPrincipal — Modelo', () {
    test('displayName combina nombre y apellido; JSON roundtrip', () {
      const p = SchoolPrincipal(id: 1, name: 'Juan', lastname: 'García');
      expect(p.displayName, 'Juan García');
      final back = SchoolPrincipal.fromJson(p.toJson());
      expect(back.displayName, 'Juan García');
    });
  });

  group('SchoolPrincipal — Form', () {
    late ProviderContainer container;
    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('name y lastname son required', () {
      final r = container.read(schoolPrincipalFormProvider);
      expect(r.form.valid, isFalse);
      r.form.patchValue({'name': 'Juan', 'lastname': 'García'});
      expect(r.form.valid, isTrue);
    });
  });
}
