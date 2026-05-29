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
      );
      expect(p.age, isNull, reason: 'Sin birthday → age null');
      final back = Player.fromJson(p.toJson());
      expect(back.firstname, 'X');
    });
  });

  group('Player — Form', () {
    late ProviderContainer container;
    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('campos opcionales NO bloquean valid', () {
      final r = container.read(playerFormProvider);
      r.form.patchValue({'firstname': 'A', 'lastname': 'B'});
      expect(
        r.form.valid,
        isTrue,
        reason: 'Solo firstname/lastname/preferredFoot son required',
      );
    });
  });
}
