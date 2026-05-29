import 'package:flutter_test/flutter_test.dart';

import 'package:statball/app/global/enums.dart';

void main() {
  group('Enums — fromDb', () {
    test('TeamGender mapea los valores exactos de Postgres', () {
      expect(TeamGender.fromDb('Masculino'), TeamGender.masculino);
      expect(TeamGender.fromDb('Femenino'), TeamGender.femenino);
      expect(TeamGender.fromDb('Mixto'), TeamGender.mixto);
    });

    test('FootPreference mapea los valores exactos de Postgres', () {
      expect(FootPreference.fromDb('Izquierda'), FootPreference.izquierda);
      expect(FootPreference.fromDb('Derecha'), FootPreference.derecha);
      expect(FootPreference.fromDb('Ambidiestro'), FootPreference.ambidiestro);
    });
  });
}
