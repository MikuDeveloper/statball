import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/providers/forms/scout_match_form_provider.dart';
import 'package:statball/app/providers/global/scout_matches_provider.dart';
import 'package:statball/app/providers/repositories/scout_match_use_case_provider.dart';
import 'package:statball/domain/index.dart' show ScoutMatch;
import 'package:statball/infrastructure/index.dart' show ScoutMatchApiException;

import '_helpers/fakes.dart';

void main() {
  group('ScoutMatch — Modelo', () {
    test('JSON roundtrip (snake_case match_id/scout_id)', () {
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
  });

  group('ScoutMatch — Form', () {
    late ProviderContainer container;
    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('scout required, notes opcional', () {
      final r = container.read(scoutMatchFormProvider);
      expect(r.form.valid, isFalse, reason: 'Sin scout no es válido');
      r.form.control('scoutId').value = 'uuid-scout';
      expect(
        r.form.valid,
        isTrue,
        reason: 'Con scout y sin notas debe ser válido',
      );
    });
  });

  group('ScoutMatch — Exceptions', () {
    test('already_assigned tiene mensaje legible', () {
      final e = ScoutMatchApiException('already_assigned');
      expect(e.message, 'Este scout ya está asignado a este partido');
      expect(e.toString(), e.message);
    });

    test('código desconocido cae al mensaje genérico con el código', () {
      final e = ScoutMatchApiException('algo_raro');
      expect(e.message, contains('Código: algo_raro'));
    });
  });

  group('ScoutMatch — Provider', () {
    test('family por matchId: assign/remove actualizan estado', () async {
      final fake = FakeScoutMatchUseCase();
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

      final created = c.read(scoutMatchesProvider(matchId)).value!.first;
      await notifier.remove(created.id!);
      expect(notifier.assignedScoutIds, isEmpty);
    });
  });
}
