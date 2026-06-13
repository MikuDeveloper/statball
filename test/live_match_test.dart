import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/global/enums.dart'
    show EvaluationStatus, PlayerPosition;
import 'package:statball/app/providers/global/live_match_provider.dart';
import 'package:statball/app/providers/global/my_assignments_provider.dart';
import 'package:statball/app/providers/repositories/match_event_use_case_provider.dart';
import 'package:statball/app/providers/repositories/matches_player_use_case_provider.dart';
import 'package:statball/app/providers/repositories/scout_match_use_case_provider.dart';
import 'package:statball/domain/index.dart' show ScoutMatch, ScoutMatchUseCase;
import 'package:statball/domain/models/match_event/match_event.dart';
import 'package:statball/domain/models/matches_player/matches_player.dart';

import '_helpers/fakes.dart';

// ─── Fake local: ScoutMatchUseCase con asignación predefinida ─────────────────
// Permite que myAssignmentsProvider resuelva sin llamar a Supabase, devolviendo
// una asignación ya existente (lista no-vacía → no pasa por _hasScoutLink).
class _FakeScoutWithAssignment implements ScoutMatchUseCase {
  const _FakeScoutWithAssignment({
    required this.matchId,
    required this.scoutMatchId,
  });

  final int matchId;
  final int scoutMatchId;

  @override
  Future<List<ScoutMatch>> getMyAssignments() async => [
    ScoutMatch(
      id: scoutMatchId,
      matchId: matchId,
      scoutId: 'scout-uuid',
      notes: '',
    ),
  ];

  @override
  Future<List<ScoutMatch>> getByMatch(int m) async => [];

  @override
  Future<ScoutMatch> create(ScoutMatch sm) => throw UnimplementedError();

  @override
  Future<ScoutMatch> update(ScoutMatch sm) => throw UnimplementedError();

  @override
  Future<void> delete(int id) => throw UnimplementedError();
}

// Container con asignación para matchId=1, scoutMatchId=99.
ProviderContainer _makeContainer() {
  return ProviderContainer(
    overrides: [
      scoutMatchUseCaseProvider.overrideWithValue(
        const _FakeScoutWithAssignment(matchId: 1, scoutMatchId: 99),
      ),
      matchesPlayerUseCaseProvider.overrideWithValue(
        FakeMatchesPlayerUseCase(),
      ),
      matchEventUseCaseProvider.overrideWithValue(FakeMatchEventUseCase()),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────

void main() {
  // ══════════════════════════════════════════════════════════════════════════
  //  GRUPO: Modelos — JSON roundtrip
  // ══════════════════════════════════════════════════════════════════════════
  group('MatchesPlayer — modelo', () {
    test('JSON roundtrip preserva todos los campos', () {
      final mp = MatchesPlayer(
        id: 7,
        matchId: 10,
        playerId: 'player-uuid-abc',
        position: PlayerPosition.mediocentro,
        evaluationStatus: EvaluationStatus.enEvaluacion,
        statsPhysics: const {'velocidad': 8},
        notes: 'Observación de prueba',
      );

      final json = mp.toJson();
      final back = MatchesPlayer.fromJson(json);

      expect(back.id, 7);
      expect(back.matchId, 10);
      expect(back.playerId, 'player-uuid-abc');
      expect(back.position, PlayerPosition.mediocentro);
      expect(back.evaluationStatus, EvaluationStatus.enEvaluacion);
      expect(back.statsPhysics['velocidad'], 8);
      expect(back.notes, 'Observación de prueba');
    });

    test('defaults correctos cuando no se pasan stats ni nota', () {
      final mp = MatchesPlayer(
        matchId: 1,
        playerId: 'uuid',
        position: PlayerPosition.portero,
      );

      expect(mp.evaluationStatus, EvaluationStatus.enEvaluacion);
      expect(mp.statsPhysics, isEmpty);
      expect(mp.statsQual, isEmpty);
      expect(mp.statsTech, isEmpty);
      expect(mp.notes, isNull);
    });

    test('serializa position y evaluation_status con sus dbValues', () {
      final mp = MatchesPlayer(
        matchId: 2,
        playerId: 'uuid',
        position: PlayerPosition.delantero,
        evaluationStatus: EvaluationStatus.completada,
      );

      final json = mp.toJson();
      expect(json['position'], 'DELANTERO');
      expect(json['evaluation_status'], 'completada');
    });
  });

  group('MatchEvent — modelo', () {
    test('JSON roundtrip preserva todos los campos', () {
      final event = MatchEvent(
        id: 3,
        type: 'gol',
        location: '3C',
        minute: 47,
        details: const {'cabeza': true, 'tipo_jugada': 'personal'},
        matchPlayerId: 12,
        scoutMatchId: 99,
      );

      final json = event.toJson();
      final back = MatchEvent.fromJson(json);

      expect(back.id, 3);
      expect(back.type, 'gol');
      expect(back.location, '3C');
      expect(back.minute, 47);
      expect(back.details['cabeza'], true);
      expect(back.details['tipo_jugada'], 'personal');
      expect(back.matchPlayerId, 12);
      expect(back.scoutMatchId, 99);
    });

    test('defaults correctos (details vacío)', () {
      final event = MatchEvent(
        type: 'pase',
        location: '2C',
        minute: 22,
        matchPlayerId: 5,
        scoutMatchId: 1,
      );
      expect(event.details, isEmpty);
      expect(event.id, isNull);
    });
  });

  // ══════════════════════════════════════════════════════════════════════════
  //  GRUPO: LiveMatch provider — mutaciones de estado UI
  // ══════════════════════════════════════════════════════════════════════════
  group('liveMatchProvider — estado UI', () {
    late ProviderContainer container;

    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('estado inicial correcto', () async {
      await container.read(myAssignmentsProvider.future);
      final state = container.read(liveMatchProvider(1));

      expect(state.matchId, 1);
      expect(state.scoutMatchId, 99);
      expect(state.selectedPlayerId, isNull);
      expect(state.selectedEventType, isNull);
      expect(state.selectedZone, isNull);
      expect(state.clockRunning, isFalse);
      expect(state.currentMinute, 0);
    });

    test('selectPlayer actualiza selectedPlayerId y limpia form', () async {
      await container.read(myAssignmentsProvider.future);
      final notifier = container.read(liveMatchProvider(1).notifier);

      // Precarga tipo de evento y zona
      notifier.selectEventType('gol');
      notifier.selectZone('3C');

      notifier.selectPlayer(42);

      final state = container.read(liveMatchProvider(1));
      expect(state.selectedPlayerId, 42);
      expect(state.selectedEventType, isNull);
      expect(state.selectedZone, isNull);
      expect(state.eventDetails, isEmpty);
      expect(state.quickNote, '');
    });

    test('selectEventType actualiza tipo y limpia zona y detalles', () async {
      await container.read(myAssignmentsProvider.future);
      final notifier = container.read(liveMatchProvider(1).notifier);

      notifier.selectPlayer(5);
      notifier.selectEventType('asistencia');
      notifier.selectZone('2C');
      notifier.toggleDetailBool('centro');

      notifier.selectEventType('pase');

      final state = container.read(liveMatchProvider(1));
      expect(state.selectedEventType, 'pase');
      expect(state.selectedZone, isNull);
      expect(state.eventDetails, isEmpty);
      expect(state.selectedPlayerId, 5); // jugador se mantiene
    });

    test('selectZone actualiza selectedZone', () async {
      await container.read(myAssignmentsProvider.future);
      final notifier = container.read(liveMatchProvider(1).notifier);

      notifier.selectPlayer(3);
      notifier.selectEventType('tiro');
      notifier.selectZone('3D');

      expect(container.read(liveMatchProvider(1)).selectedZone, '3D');
    });

    test(
      'clearEventForm limpia tipo, zona, detalles y nota (no el jugador)',
      () async {
        await container.read(myAssignmentsProvider.future);
        final notifier = container.read(liveMatchProvider(1).notifier);

        notifier.selectPlayer(7);
        notifier.selectEventType('duelo');
        notifier.selectZone('1C');
        notifier.setQuickNote('nota de prueba');
        notifier.clearEventForm();

        final state = container.read(liveMatchProvider(1));
        expect(state.selectedEventType, isNull);
        expect(state.selectedZone, isNull);
        expect(state.eventDetails, isEmpty);
        expect(state.quickNote, '');
        expect(state.selectedPlayerId, 7); // jugador no se borra
      },
    );

    test('toggleDetailBool alterna boolean en eventDetails', () async {
      await container.read(myAssignmentsProvider.future);
      final notifier = container.read(liveMatchProvider(1).notifier);

      notifier.selectEventType('gol');
      notifier.toggleDetailBool('cabeza');
      expect(
        container.read(liveMatchProvider(1)).eventDetails['cabeza'],
        isTrue,
      );

      notifier.toggleDetailBool('cabeza');
      expect(
        container.read(liveMatchProvider(1)).eventDetails['cabeza'],
        isFalse,
      );
    });

    test('setDetailEnum registra valor en eventDetails', () async {
      await container.read(myAssignmentsProvider.future);
      final notifier = container.read(liveMatchProvider(1).notifier);

      notifier.selectEventType('gol');
      notifier.setDetailEnum('tipo_jugada', 'personal');

      expect(
        container.read(liveMatchProvider(1)).eventDetails['tipo_jugada'],
        'personal',
      );
    });

    test('saveEvent lanza ArgumentError si falta tipo o zona', () async {
      await container.read(myAssignmentsProvider.future);
      final notifier = container.read(liveMatchProvider(1).notifier);

      notifier.selectPlayer(10);
      // Sin selectEventType ni selectZone → debe fallar
      expect(notifier.saveEvent(), throwsArgumentError);
    });
  });
}
