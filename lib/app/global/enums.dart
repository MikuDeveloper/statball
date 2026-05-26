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
