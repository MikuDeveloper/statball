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

    test('userId nullable — JSON roundtrip con y sin vínculo', () {
      // Con userId
      final linked = Scout(
        id: 'uuid-s',
        name: 'Ana',
        lastname: 'López',
        birthday: DateTime(1995, 5, 20),
        phoneNumber: '+52 111',
        address: 'Av. 5',
        photo: 'https://img.test',
        userId: 'profile-uuid-abc',
      );
      final json = linked.toJson();
      expect(json['user_id'], 'profile-uuid-abc');
      final back = Scout.fromJson(json);
      expect(back.userId, 'profile-uuid-abc');
      expect(back, equals(linked));

      // Sin userId (null)
      final unlinked = Scout(
        id: 'uuid-u',
        name: 'Pedro',
        lastname: 'Gómez',
        birthday: DateTime(1988, 3, 10),
        phoneNumber: '+52 222',
        address: 'Calle 8',
        photo: '',
      );
      final json2 = unlinked.toJson();
      // user_id puede estar presente como null o ausente según la config de
      // json_serializable. Lo importante es que fromJson lo trate como null.
      final back2 = Scout.fromJson(json2);
      expect(back2.userId, isNull);
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
