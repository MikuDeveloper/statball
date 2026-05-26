import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/global/enums.dart' show FootPreference;

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
      'height': FormControl<double>(
        value: null,
        // Si el usuario captura algo, debe ser razonable; pero el campo en sí
        // es opcional. min se evalúa solo cuando hay valor.
        validators: [Validators.min(0.5)],
      ),
      'weight': FormControl<double>(
        value: null,
        validators: [Validators.min(1)],
      ),
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
    }),
  );
}
