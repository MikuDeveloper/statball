import 'package:flutter/material.dart' show Offset;

enum SlideFrom { top, right, bottom, left }

extension SlideFromDirection on SlideFrom {
  Offset get offset {
    switch (this) {
      case .top:
        return const Offset(0, -1);
      case .right:
        return const Offset(1, 0);
      case .bottom:
        return const Offset(0, 1);
      case .left:
        return const Offset(-1, 0);
    }
  }
}

enum DataStatus { initial, loading, success, error }

// ─── TeamGender ─────────────────────────────────────────────────────────────
// Coincide con el enum `team_gender_enum` de Postgres. El valor `dbValue` es el
// string exacto que viaja a/desde Supabase (capitalizado en español).
enum TeamGender {
  masculino('Masculino'),
  femenino('Femenino'),
  mixto('Mixto');

  const TeamGender(this.dbValue);

  final String dbValue;

  static TeamGender fromDb(String value) {
    for (final g in TeamGender.values) {
      if (g.dbValue == value) return g;
    }
    throw ArgumentError('Género de equipo desconocido: $value');
  }

  String get label => dbValue;
}

// ─── FootPreference ─────────────────────────────────────────────────────────
// Coincide con el enum `foot_enum` de Postgres (pierna preferida del jugador).
enum FootPreference {
  izquierda('Izquierda'),
  derecha('Derecha'),
  ambidiestro('Ambidiestro');

  const FootPreference(this.dbValue);

  final String dbValue;

  static FootPreference fromDb(String value) {
    for (final f in FootPreference.values) {
      if (f.dbValue == value) return f;
    }
    throw ArgumentError('Pie preferido desconocido: $value');
  }

  String get label => dbValue;
}

// ─── PlayerPosition ──────────────────────────────────────────────────────────
// Coincide con el enum `position_enum` de Postgres (posición del jugador en
// un partido). Valor dbValue = string exacto almacenado en matches_players.
enum PlayerPosition {
  portero('PORTERO'),
  lateral('LATERAL'),
  central('CENTRAL'),
  contencion('CONTENCION'),
  mediocentro('MEDIOCENTRO'),
  mediapunta('MEDIAPUNTA'),
  extremo('EXTREMO'),
  delantero('DELANTERO');

  const PlayerPosition(this.dbValue);

  final String dbValue;

  static PlayerPosition fromDb(String value) {
    for (final p in PlayerPosition.values) {
      if (p.dbValue == value) return p;
    }
    throw ArgumentError('Posición desconocida: $value');
  }

  String get label => switch (this) {
    .portero => 'Portero',
    .lateral => 'Lateral',
    .central => 'Central',
    .contencion => 'Contención',
    .mediocentro => 'Mediocentro',
    .mediapunta => 'Mediapunta',
    .extremo => 'Extremo',
    .delantero => 'Delantero',
  };

  String get shortLabel => switch (this) {
    .portero => 'POR',
    .lateral => 'LAT',
    .central => 'CEN',
    .contencion => 'CDM',
    .mediocentro => 'MED',
    .mediapunta => 'CAM',
    .extremo => 'EXT',
    .delantero => 'DEL',
  };
}

// ─── EvaluationStatus ────────────────────────────────────────────────────────
// Coincide con el CHECK constraint de matches_players.evaluation_status.
enum EvaluationStatus {
  enEvaluacion('en_evaluacion'),
  completada('completada'),
  salioDeEvaluacion('salio_de_evaluacion');

  const EvaluationStatus(this.dbValue);

  final String dbValue;

  static EvaluationStatus fromDb(String value) {
    for (final s in EvaluationStatus.values) {
      if (s.dbValue == value) return s;
    }
    throw ArgumentError('Status desconocido: $value');
  }

  String get label => switch (this) {
    .enEvaluacion => 'En evaluación',
    .completada => 'Completada',
    .salioDeEvaluacion => 'Salió',
  };
}
