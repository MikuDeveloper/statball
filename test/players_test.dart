import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/global/enums.dart' show FootPreference;
import 'package:statball/app/providers/forms/player_form_provider.dart';
import 'package:statball/domain/index.dart' show Player, PlayerX;

void main() {
  group('Player — Modelo', () {
    test('fullName + age con birthday; campos nullable', () {
      final p = Player(
        firstname: 'Andrés',
        lastname: 'García',
        birthday: DateTime(DateTime.now().year - 16, 1, 1),
        preferredFoot: FootPreference.derecha,
        basicForces: true,
        scoutId: 'scout-uuid',
      );
      expect(p.fullName, 'Andrés García');
      expect(p.age, anyOf(15, 16));
    });

    test('sin birthday → age null; JSON roundtrip mínimo', () {
      const p = Player(
        firstname: 'X',
        lastname: 'Y',
        preferredFoot: FootPreference.izquierda,
        basicForces: false,
        scoutId: 'scout-uuid',
      );
      expect(p.age, isNull, reason: 'Sin birthday → age null');
      final back = Player.fromJson(p.toJson());
      expect(back.firstname, 'X');
    });

    test('JSON roundtrip conserva scout_id (snake_case)', () {
      const p = Player(
        firstname: 'Lionel',
        lastname: 'Messi',
        preferredFoot: FootPreference.izquierda,
        basicForces: true,
        teamId: 'team-uuid',
        scoutId: 'scout-123',
      );
      final json = p.toJson();
      expect(json['scout_id'], 'scout-123', reason: 'FieldRename.snake');

      final back = Player.fromJson(json);
      expect(back.scoutId, 'scout-123');
      expect(back.teamId, 'team-uuid');
    });
  });

  group('Player — Form', () {
    late ProviderContainer container;
    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('con firstname/lastname/scoutId el form es válido', () {
      final r = container.read(playerFormProvider);
      r.form.patchValue({
        'firstname': 'A',
        'lastname': 'B',
        'scoutId': 'scout-uuid',
      });
      expect(
        r.form.valid,
        isTrue,
        reason: 'firstname/lastname/preferredFoot/scoutId completos',
      );
    });

    test('scoutId es required — sin scout el form es inválido', () {
      final r = container.read(playerFormProvider);
      r.form.patchValue({'firstname': 'A', 'lastname': 'B'});
      expect(r.form.valid, isFalse, reason: 'Falta scoutId (NOT NULL en DB)');
      expect(r.form.control('scoutId').valid, isFalse);

      // Al elegir scout, el form se vuelve válido.
      r.form.control('scoutId').value = 'scout-uuid';
      expect(r.form.valid, isTrue);
    });
  });
}
