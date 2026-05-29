import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/providers/forms/game_match_form_provider.dart';
import 'package:statball/app/providers/global/game_matches_provider.dart';
import 'package:statball/app/providers/repositories/game_match_use_case_provider.dart';
import 'package:statball/domain/index.dart' show GameMatch, GameMatchX;

import '_helpers/fakes.dart';

void main() {
  group('GameMatch — Modelo', () {
    test('relativeLabel + isUpcoming/isPast + JSON roundtrip', () {
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

      final back = GameMatch.fromJson(m1.toJson());
      expect(back.localTeamId, 'team-a');
      expect(back.visitorTeamId, 'team-b');
    });
  });

  group('GameMatch — Form', () {
    late ProviderContainer container;
    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('valida local ≠ visitor (cross-field sameTeam)', () {
      final r = container.read(gameMatchFormProvider);
      expect(r.form.valid, isFalse);
      r.form.patchValue({
        'date': DateTime.now().add(const Duration(days: 1)),
        'localTeamId': 'uuid-x',
        'visitorTeamId': 'uuid-x',
      });
      expect(r.form.valid, isFalse, reason: 'Mismo equipo no debe pasar');
      expect(r.form.errors['sameTeam'], isTrue);
      r.form.control('visitorTeamId').value = 'uuid-y';
      expect(r.form.valid, isTrue);
    });
  });

  group('GameMatch — Provider', () {
    test('getters upcoming/past compilan y filtran', () async {
      // Este test EXISTE específicamente porque el provider usaba
      // `import ... show GameMatch` y las extensions `isUpcoming/isPast`
      // no entraban en scope, bloqueando la compilación en Windows. Si pasa,
      // el provider compiló con las extensions resueltas.
      final fakeUseCase = FakeGameMatchUseCase([
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
    });
  });
}
