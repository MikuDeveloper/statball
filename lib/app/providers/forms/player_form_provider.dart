import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/global/enums.dart'
    show FootPreference, PlayerPosition;

part 'player_form_provider.g.dart';

// Form para crear / editar un jugador. Solo nombre, apellido, pie preferido y
// "fuerzas básicas" son obligatorios; el resto se puede completar después.
@riverpod
({String key, FormGroup form}) playerForm(Ref ref) {
  return (
    key: 'player_form',
    form: FormGroup({
      'firstname': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'lastname': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'birthday': FormControl<DateTime>(value: null),
      // Sin validators: height/weight son opcionales. Antes tenía
      // Validators.min(0.5/1) pensando que solo aplicarían a valores
      // capturados, pero reactive_forms lo aplica también a null/0 y
      // bloquea el form indefinidamente. Si quieres validar rangos sólo
      // cuando hay valor, conviene un validator custom condicional.
      'height': FormControl<double>(value: null),
      'weight': FormControl<double>(value: null),
      'notes': FormControl<String>(value: ''),
      'preferredFoot': FormControl<FootPreference>(
        value: FootPreference.derecha,
        validators: [Validators.required],
      ),
      'basicForces': FormControl<bool>(value: false),
      'city': FormControl<String>(value: ''),
      'country': FormControl<String>(value: ''),
      'photo': FormControl<String>(value: ''),
      'teamId': FormControl<String>(value: null),
      // Scout responsable obligatorio (players.scout_id es NOT NULL en DB).
      'scoutId': FormControl<String>(
        value: null,
        validators: [Validators.required],
      ),
      // Posición principal (players.default_position NOT NULL DEFAULT MEDIOCENTRO).
      'defaultPosition': FormControl<PlayerPosition>(
        value: PlayerPosition.mediocentro,
        validators: [Validators.required],
      ),
    }),
  );
}
