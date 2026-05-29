import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/providers/forms/school_form_provider.dart';
import 'package:statball/domain/index.dart' show School;

void main() {
  group('School — Modelo', () {
    test('JSON roundtrip conserva campos', () {
      const s = School(id: 1, name: 'Academia Morelia', city: 'Morelia');
      final json = s.toJson();
      expect(json['name'], 'Academia Morelia');
      expect(json['city'], 'Morelia');
      final back = School.fromJson(json);
      expect(back, equals(s));
    });
  });

  group('School — Form', () {
    late ProviderContainer container;
    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('solo name es required', () {
      final r = container.read(schoolFormProvider);
      expect(r.key, 'school_form');
      expect(r.form, isA<FormGroup>());
      expect(r.form.valid, isFalse, reason: 'Sin name no es válido');
      r.form.control('name').value = 'X';
      expect(r.form.valid, isTrue);
    });
  });
}
