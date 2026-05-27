// Smoke test de FASE 1: verifica que los modelos serialicen/deserialicen,
// que las extensions sigan en scope (PlayerX, ScoutX, etc.) y que los
// FormGroup providers se construyan sin lanzar.
//
// No prueba Supabase (eso requiere mocks o integración). Es un check rápido
// para detectar regresiones de tipos y JSON tras los fixes de bugs.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/global/enums.dart';
import 'package:statball/app/providers/forms/player_form_provider.dart';
import 'package:statball/app/providers/forms/school_form_provider.dart';
import 'package:statball/app/providers/forms/school_principal_form_provider.dart';
import 'package:statball/app/providers/forms/scout_form_provider.dart';
import 'package:statball/app/providers/forms/team_form_provider.dart';
import 'package:statball/domain/index.dart';

void main() {
  group('Models — JSON roundtrip y extensions', () {
    test('School', () {
      const s = School(id: 1, name: 'Academia Morelia', city: 'Morelia');
      final json = s.toJson();
      expect(json['name'], 'Academia Morelia');
      expect(json['city'], 'Morelia');
      final back = School.fromJson(json);
      expect(back, equals(s));
    });

    test('SchoolPrincipal + displayName', () {
      const p = SchoolPrincipal(id: 1, name: 'Juan', lastname: 'García');
      expect(p.displayName, 'Juan García');
      final back = SchoolPrincipal.fromJson(p.toJson());
      expect(back.displayName, 'Juan García');
    });

    test('Team con enum gender', () {
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

    test('Player nullable fields + extensions fullName/age', () {
      final p = Player(
        firstname: 'Andrés',
        lastname: 'García',
        birthday: DateTime(DateTime.now().year - 16, 1, 1),
        preferredFoot: FootPreference.derecha,
        basicForces: true,
      );
      expect(p.fullName, 'Andrés García');
      expect(p.age, anyOf(15, 16));

      const p2 = Player(
        firstname: 'X',
        lastname: 'Y',
        preferredFoot: FootPreference.izquierda,
        basicForces: false,
      );
      expect(p2.age, isNull, reason: 'Sin birthday → age null');
      final back = Player.fromJson(p2.toJson());
      expect(back.firstname, 'X');
    });

    test('Scout + displayName + age', () {
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

    test('Enums fromDb match valores Postgres exactos', () {
      expect(TeamGender.fromDb('Masculino'), TeamGender.masculino);
      expect(TeamGender.fromDb('Femenino'), TeamGender.femenino);
      expect(TeamGender.fromDb('Mixto'), TeamGender.mixto);
      expect(FootPreference.fromDb('Izquierda'), FootPreference.izquierda);
      expect(FootPreference.fromDb('Derecha'), FootPreference.derecha);
      expect(FootPreference.fromDb('Ambidiestro'), FootPreference.ambidiestro);
    });
  });

  group('Form providers — construyen FormGroup válido', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() => container.dispose());

    test('schoolForm', () {
      final r = container.read(schoolFormProvider);
      expect(r.key, 'school_form');
      expect(r.form, isA<FormGroup>());
      r.form.control('name').value = 'X';
      expect(r.form.valid, isTrue);
    });

    test('schoolPrincipalForm', () {
      final r = container.read(schoolPrincipalFormProvider);
      r.form.patchValue({'name': 'Juan', 'lastname': 'García'});
      expect(r.form.valid, isTrue);
    });

    test('teamForm', () {
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

    test('playerForm — campos opcionales NO bloquean valid', () {
      final r = container.read(playerFormProvider);
      r.form.patchValue({'firstname': 'A', 'lastname': 'B'});
      expect(
        r.form.valid,
        isTrue,
        reason: 'Solo firstname/lastname/preferredFoot son required',
      );
    });

    test('scoutForm — todos los campos requeridos por schema', () {
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
