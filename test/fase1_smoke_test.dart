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
import 'package:statball/app/providers/forms/game_match_form_provider.dart';
import 'package:statball/app/providers/global/game_matches_provider.dart';
import 'package:statball/app/providers/repositories/game_match_use_case_provider.dart';
import 'package:statball/app/providers/forms/player_form_provider.dart';
import 'package:statball/app/providers/forms/school_form_provider.dart';
import 'package:statball/app/providers/forms/school_principal_form_provider.dart';
import 'package:statball/app/providers/forms/scout_form_provider.dart';
import 'package:statball/app/providers/forms/scout_match_form_provider.dart';
import 'package:statball/app/providers/forms/team_form_provider.dart';
import 'package:statball/app/providers/global/scout_matches_provider.dart';
import 'package:statball/app/providers/repositories/scout_match_use_case_provider.dart';
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

    test('GameMatch + relativeLabel + isUpcoming/isPast', () {
      // Match futuro: en 3 días
      final future = DateTime.now().add(const Duration(days: 3));
      final m1 = GameMatch(
        id: 1,
        date: future,
        localTeamId: 'team-a',
        visitorTeamId: 'team-b',
      );
      expect(m1.isUpcoming, isTrue);
      expect(m1.isPast, isFalse);
      expect(m1.relativeLabel, contains('días'));

      // Match pasado: hace 2 días
      final past = DateTime.now().subtract(const Duration(days: 2));
      final m2 = m1.copyWith(date: past);
      expect(m2.isPast, isTrue);
      expect(m2.relativeLabel, contains('Hace'));

      // JSON roundtrip
      final back = GameMatch.fromJson(m1.toJson());
      expect(back.localTeamId, 'team-a');
      expect(back.visitorTeamId, 'team-b');
    });

    test('ScoutMatch JSON roundtrip (snake_case)', () {
      const sm = ScoutMatch(
        id: 1,
        matchId: 42,
        scoutId: 'uuid-scout',
        notes: 'Enfocarse en mediocampo',
      );
      final json = sm.toJson();
      expect(json['match_id'], 42);
      expect(json['scout_id'], 'uuid-scout');
      final back = ScoutMatch.fromJson(json);
      expect(back, equals(sm));
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

    test(
      'gameMatchesProvider — getters upcoming/past compilan y filtran',
      () async {
        // Este test EXISTE específicamente porque el provider usaba
        // `import ... show GameMatch` y las extensions `isUpcoming/isPast`
        // no entraban en scope, bloqueando la compilación en Windows pero
        // NO en flutter test (porque el archivo de tests sí las importaba).
        // Si esto pasa, el provider compiló con extensions resueltas.
        //
        // Overrideamos el use case para no llamar a Supabase real.
        final fakeUseCase = _FakeGameMatchUseCase([
          GameMatch(
            id: 1,
            date: DateTime.now().add(const Duration(days: 1)),
            localTeamId: 'a',
            visitorTeamId: 'b',
          ),
          GameMatch(
            id: 2,
            date: DateTime.now().subtract(const Duration(days: 1)),
            localTeamId: 'c',
            visitorTeamId: 'd',
          ),
        ]);
        final c = ProviderContainer(
          overrides: [gameMatchUseCaseProvider.overrideWithValue(fakeUseCase)],
        );
        addTearDown(c.dispose);
        await c.read(gameMatchesProvider.future);
        final notifier = c.read(gameMatchesProvider.notifier);
        expect(notifier.upcoming.length, 1);
        expect(notifier.past.length, 1);
      },
    );

    test('gameMatchForm — valida local ≠ visitor (cross-field)', () {
      final r = container.read(gameMatchFormProvider);
      expect(r.form.valid, isFalse);
      // Misma uuid en local y visitor → debe ser invalid con error 'sameTeam'
      r.form.patchValue({
        'date': DateTime.now().add(const Duration(days: 1)),
        'localTeamId': 'uuid-x',
        'visitorTeamId': 'uuid-x',
      });
      expect(r.form.valid, isFalse, reason: 'Mismo equipo no debe pasar');
      expect(r.form.errors['sameTeam'], isTrue);
      // Equipos distintos → valid
      r.form.control('visitorTeamId').value = 'uuid-y';
      expect(r.form.valid, isTrue);
    });

    test('scoutMatchForm — scout required, notes opcional', () {
      final r = container.read(scoutMatchFormProvider);
      expect(r.form.valid, isFalse, reason: 'Sin scout no es válido');
      r.form.control('scoutId').value = 'uuid-scout';
      expect(
        r.form.valid,
        isTrue,
        reason: 'Con scout y sin notas debe ser válido',
      );
    });

    test(
      'scoutMatchesProvider(family) — assign/remove actualizan estado',
      () async {
        // Family provider scoped por matchId. Override del use case para no
        // tocar Supabase. Verifica el ciclo assign → assignedScoutIds → remove.
        final fake = _FakeScoutMatchUseCase();
        final c = ProviderContainer(
          overrides: [scoutMatchUseCaseProvider.overrideWithValue(fake)],
        );
        addTearDown(c.dispose);

        const matchId = 7;
        await c.read(scoutMatchesProvider(matchId).future);
        final notifier = c.read(scoutMatchesProvider(matchId).notifier);

        expect(notifier.assignedScoutIds, isEmpty);
        await notifier.assign(scoutId: 'scout-1', notes: 'nota');
        expect(notifier.assignedScoutIds, contains('scout-1'));

        // El id lo asigna el fake incrementalmente; removemos el primero.
        final created = c.read(scoutMatchesProvider(matchId)).value!.first;
        await notifier.remove(created.id!);
        expect(notifier.assignedScoutIds, isEmpty);
      },
    );
  });
}

// Fake mínimo que solo implementa lo que el provider de matches llama
// (getAll en build). Los demás métodos no se usan en este test.
class _FakeGameMatchUseCase implements GameMatchUseCase {
  _FakeGameMatchUseCase(this._data);
  final List<GameMatch> _data;

  @override
  Future<List<GameMatch>> getAll() async => _data;

  @override
  Future<GameMatch> getById(int id) => throw UnimplementedError();
  @override
  Future<GameMatch> create(GameMatch m) => throw UnimplementedError();
  @override
  Future<GameMatch> update(GameMatch m) => throw UnimplementedError();
  @override
  Future<void> delete(int id) => throw UnimplementedError();
}

// Fake in-memory para scout_match: simula assign (asigna id incremental),
// getByMatch (devuelve lo acumulado) y delete.
class _FakeScoutMatchUseCase implements ScoutMatchUseCase {
  final List<ScoutMatch> _store = [];
  int _seq = 0;

  @override
  Future<List<ScoutMatch>> getByMatch(int matchId) async =>
      _store.where((s) => s.matchId == matchId).toList();

  @override
  Future<ScoutMatch> create(ScoutMatch sm) async {
    final created = ScoutMatch(
      id: ++_seq,
      matchId: sm.matchId,
      scoutId: sm.scoutId,
      notes: sm.notes,
    );
    _store.add(created);
    return created;
  }

  @override
  Future<ScoutMatch> update(ScoutMatch sm) async {
    final idx = _store.indexWhere((s) => s.id == sm.id);
    if (idx != -1) _store[idx] = sm;
    return sm;
  }

  @override
  Future<void> delete(int id) async => _store.removeWhere((s) => s.id == id);
}
