import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:statball/app/global/enums.dart' show PlayerPosition;
import 'package:statball/domain/models/positions_stats_config/positions_stats_config.dart';

void main() {
  // Cargamos el JSON desde el filesystem (los tests corren en el host con dart:io).
  late PositionsStatsConfig config;

  setUpAll(() {
    final raw = File(
      'assets/config/positions_stats_config.json',
    ).readAsStringSync();
    final json = jsonDecode(raw) as Map<String, dynamic>;
    config = PositionsStatsConfig.fromJson(json);
  });

  // ══════════════════════════════════════════════════════════════════════════
  //  rating_scale
  // ══════════════════════════════════════════════════════════════════════════
  group('PositionsStatsConfig — rating_scale', () {
    test('tiene exactamente 5 valores', () {
      expect(config.ratingScale.length, 5);
    });

    test('todos los valores son enteros positivos entre 1 y 10', () {
      for (final v in config.ratingScale.values) {
        expect(v, greaterThanOrEqualTo(1));
        expect(v, lessThanOrEqualTo(10));
      }
    });

    test('incluye las claves semánticas esperadas', () {
      expect(config.ratingScale.containsKey('muy_eficiente'), isTrue);
      expect(config.ratingScale.containsKey('muy_deficiente'), isTrue);
    });
  });

  // ══════════════════════════════════════════════════════════════════════════
  //  stats_tech — 8 posiciones
  // ══════════════════════════════════════════════════════════════════════════
  group('PositionsStatsConfig — stats_tech', () {
    test('tiene exactamente 8 posiciones', () {
      expect(config.statsTech.length, 8);
    });

    test('las claves coinciden con los dbValues de PlayerPosition', () {
      final techKeys = config.statsTech.keys.toSet();
      final enumDbValues = PlayerPosition.values.map((p) => p.dbValue).toSet();
      expect(techKeys, equals(enumDbValues));
    });

    test('cada posición tiene al menos un field de stats técnicas', () {
      for (final entry in config.statsTech.entries) {
        expect(
          entry.value.fields,
          isNotEmpty,
          reason: '${entry.key} no tiene fields',
        );
      }
    });
  });

  // ══════════════════════════════════════════════════════════════════════════
  //  location_zones
  // ══════════════════════════════════════════════════════════════════════════
  group('PositionsStatsConfig — location_zones', () {
    test('tiene exactamente 9 zonas (grid 3x3)', () {
      expect(config.locationZones.length, 9);
    });

    test('todos los códigos de zona son strings no vacíos', () {
      for (final z in config.locationZones) {
        expect(z.code, isNotEmpty);
        expect(z.label, isNotEmpty);
      }
    });
  });

  // ══════════════════════════════════════════════════════════════════════════
  //  event_types
  // ══════════════════════════════════════════════════════════════════════════
  group('PositionsStatsConfig — event_types', () {
    test('contiene los 7 tipos de evento del MVP', () {
      for (final key in [
        'gol',
        'asistencia',
        'pase',
        'tiro',
        'duelo',
        'centro',
        'recuperacion',
      ]) {
        expect(
          config.eventTypes.containsKey(key),
          isTrue,
          reason: 'Falta el tipo de evento: $key',
        );
      }
    });

    test('cada tipo de evento tiene un label no vacío', () {
      for (final entry in config.eventTypes.entries) {
        expect(
          entry.value.label,
          isNotEmpty,
          reason: '${entry.key}.label está vacío',
        );
      }
    });

    test(
      'los details de gol incluyen cabeza (boolean) y tipo_jugada (enum)',
      () {
        final gol = config.eventTypes['gol']!;
        expect(gol.details.containsKey('cabeza'), isTrue);
        expect(gol.details['cabeza']!.type, 'boolean');
        expect(gol.details.containsKey('tipo_jugada'), isTrue);
        expect(gol.details['tipo_jugada']!.type, 'enum');
        expect(gol.details['tipo_jugada']!.options, contains('personal'));
      },
    );

    test('no hay claves de metadatos (_*) en event_types', () {
      for (final key in config.eventTypes.keys) {
        expect(key.startsWith('_'), isFalse);
      }
    });
  });

  // ══════════════════════════════════════════════════════════════════════════
  //  stats_physics y stats_qual
  // ══════════════════════════════════════════════════════════════════════════
  group('PositionsStatsConfig — stats_physics / stats_qual', () {
    test('stats_physics tiene al menos 5 campos', () {
      expect(config.statsPhysics.length, greaterThanOrEqualTo(5));
    });

    test('stats_qual tiene al menos 3 campos', () {
      expect(config.statsQual.length, greaterThanOrEqualTo(3));
    });

    test('cada campo tiene key y label no vacíos', () {
      for (final f in [...config.statsPhysics, ...config.statsQual]) {
        expect(f.key, isNotEmpty);
        expect(f.label, isNotEmpty);
      }
    });
  });
}
