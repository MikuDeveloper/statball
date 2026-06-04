import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/providers/global/game_matches_provider.dart';
import 'package:statball/app/providers/global/my_assignments_provider.dart';
import 'package:statball/app/providers/repositories/game_match_use_case_provider.dart';
import 'package:statball/app/providers/repositories/scout_match_use_case_provider.dart';
import 'package:statball/domain/index.dart'
    show GameMatch, ScoutMatch, ScoutMatchUseCase;

import '_helpers/fakes.dart';

// ─── Fake especializado: getMyAssignments devuelve datos prefijados ──────────
// _hasScoutLink() en el provider hace una query directa a Supabase que no
// podemos interceptar en tests unitarios; por eso testeamos solo el camino
// "con asignaciones" donde esa rama no se ejecuta.
class _FakeScoutMatchUseCase implements ScoutMatchUseCase {
  _FakeScoutMatchUseCase(this._myAssignments);
  final List<ScoutMatch> _myAssignments;

  @override
  Future<List<ScoutMatch>> getMyAssignments() async => _myAssignments;

  @override
  Future<List<ScoutMatch>> getByMatch(int matchId) async => [];

  @override
  Future<ScoutMatch> create(ScoutMatch sm) => throw UnimplementedError();

  @override
  Future<ScoutMatch> update(ScoutMatch sm) => throw UnimplementedError();

  @override
  Future<void> delete(int id) => throw UnimplementedError();
}

void main() {
  // ── Fixture de matches ──────────────────────────────────────────────────
  final upcomingMatch = GameMatch(
    id: 10,
    date: DateTime.now().add(const Duration(days: 2)),
    localTeamId: 'team-a',
    visitorTeamId: 'team-b',
  );
  final pastMatch = GameMatch(
    id: 20,
    date: DateTime.now().subtract(const Duration(days: 3)),
    localTeamId: 'team-c',
    visitorTeamId: 'team-d',
  );

  // ── Fixture de asignaciones ─────────────────────────────────────────────
  const upcomingAssignment = ScoutMatch(
    id: 1,
    matchId: 10,
    scoutId: 'scout-uuid',
    notes: 'Enfocarse en mediocampo',
  );
  const pastAssignment = ScoutMatch(
    id: 2,
    matchId: 20,
    scoutId: 'scout-uuid',
    notes: '',
  );

  ProviderContainer makeContainer(List<ScoutMatch> assignments) {
    return ProviderContainer(
      overrides: [
        scoutMatchUseCaseProvider.overrideWithValue(
          _FakeScoutMatchUseCase(assignments),
        ),
        gameMatchUseCaseProvider.overrideWithValue(
          FakeGameMatchUseCase([upcomingMatch, pastMatch]),
        ),
      ],
    );
  }

  group('MyAssignmentsEmptyReason — enum', () {
    test('tiene los valores noScoutLink y noAssignments', () {
      expect(MyAssignmentsEmptyReason.values.length, 2);
      expect(
        MyAssignmentsEmptyReason.values,
        containsAll([
          MyAssignmentsEmptyReason.noScoutLink,
          MyAssignmentsEmptyReason.noAssignments,
        ]),
      );
    });
  });

  group('myAssignmentsProvider — con asignaciones', () {
    test('estado carga assignments y emptyReason es null', () async {
      final c = makeContainer([upcomingAssignment, pastAssignment]);
      addTearDown(c.dispose);

      await c.read(gameMatchesProvider.future);
      final s = await c.read(myAssignmentsProvider.future);

      expect(s.assignments.length, 2);
      expect(s.emptyReason, isNull);
    });

    test('getter upcoming filtra por partidos futuros', () async {
      final c = makeContainer([upcomingAssignment, pastAssignment]);
      addTearDown(c.dispose);

      await c.read(gameMatchesProvider.future);
      await c.read(myAssignmentsProvider.future);

      final notifier = c.read(myAssignmentsProvider.notifier);
      expect(notifier.upcoming.length, 1);
      expect(notifier.upcoming.first.matchId, 10);
    });

    test('getter past filtra por partidos pasados', () async {
      final c = makeContainer([upcomingAssignment, pastAssignment]);
      addTearDown(c.dispose);

      await c.read(gameMatchesProvider.future);
      await c.read(myAssignmentsProvider.future);

      final notifier = c.read(myAssignmentsProvider.notifier);
      expect(notifier.past.length, 1);
      expect(notifier.past.first.matchId, 20);
    });

    test('solo upcoming — past vacío', () async {
      final c = makeContainer([upcomingAssignment]);
      addTearDown(c.dispose);

      await c.read(gameMatchesProvider.future);
      await c.read(myAssignmentsProvider.future);

      final notifier = c.read(myAssignmentsProvider.notifier);
      expect(notifier.upcoming.length, 1);
      expect(notifier.past, isEmpty);
    });

    test('solo past — upcoming vacío', () async {
      final c = makeContainer([pastAssignment]);
      addTearDown(c.dispose);

      await c.read(gameMatchesProvider.future);
      await c.read(myAssignmentsProvider.future);

      final notifier = c.read(myAssignmentsProvider.notifier);
      expect(notifier.past.length, 1);
      expect(notifier.upcoming, isEmpty);
    });
  });

  group('FakeScoutMatchUseCase — getMyAssignments', () {
    test('devuelve el store completo', () async {
      final fake = FakeScoutMatchUseCase();
      await fake.create(
        const ScoutMatch(matchId: 1, scoutId: 'scout-1', notes: ''),
      );
      await fake.create(
        const ScoutMatch(matchId: 2, scoutId: 'scout-2', notes: 'test'),
      );
      final all = await fake.getMyAssignments();
      expect(all.length, 2);
    });
  });
}
