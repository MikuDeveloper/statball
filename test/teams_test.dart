import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/global/enums.dart' show TeamGender;
import 'package:statball/app/providers/forms/team_form_provider.dart';
import 'package:statball/domain/index.dart' show Team;

void main() {
  group('Team — Modelo', () {
    test('enum gender se serializa al string de Postgres', () {
      const t = Team(
        id: 'uuid-1',
        name: 'Sub-17',
        category: 'U-17',
        gender: TeamGender.femenino,
        coachName: 'Coach',
        schoolId: 1,
      );
      final json = t.toJson();
      expect(json['gender'], 'Femenino');
      final back = Team.fromJson(json);
      expect(back.gender, TeamGender.femenino);
    });
  });

  group('Team — Form', () {
    late ProviderContainer container;
    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('todos los campos son required', () {
      final r = container.read(teamFormProvider);
      r.form.patchValue({
        'name': 'A',
        'category': 'U-17',
        'gender': TeamGender.masculino,
        'coachName': 'Coach',
        'schoolId': 1,
      });
      expect(r.form.valid, isTrue);
    });
  });
}
