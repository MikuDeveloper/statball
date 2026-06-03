import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/providers/forms/scout_form_provider.dart';
import 'package:statball/domain/index.dart' show Scout, ScoutX;

void main() {
  group('Scout — Modelo', () {
    test('displayName + age; JSON snake_case', () {
      final s = Scout(
        id: 'uuid-s',
        name: 'Carlos',
        lastname: 'Méndez',
        birthday: DateTime(1990, 1, 1),
        phoneNumber: '+52',
        address: 'Calle 1',
        photo: '',
      );
      expect(s.displayName, 'Carlos Méndez');
      expect(s.age, greaterThan(30));
      final json = s.toJson();
      expect(json['phone_number'], '+52');
    });
  });

  group('Scout — Form', () {
    late ProviderContainer container;
    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('todos los campos requeridos por schema', () {
      final r = container.read(scoutFormProvider);
      expect(r.form.valid, isFalse);
      r.form.patchValue({
        'name': 'X',
        'lastname': 'Y',
        'birthday': DateTime(2000, 1, 1),
        'phoneNumber': '+52',
        'address': 'Calle',
        'photo': 'https://x',
      });
      expect(r.form.valid, isTrue);
    });
  });
}
