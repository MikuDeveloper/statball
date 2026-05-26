import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/global/enums.dart' show FootPreference;

part 'player_form_provider.g.dart';

// Form para crear / editar un jugador. El schema marca casi todo NOT NULL;
// solo teamId es opcional. preferredFoot arranca en Derecha (más común).
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
      'birthday': FormControl<DateTime>(
        value: null,
        validators: [Validators.required],
      ),
      'height': FormControl<double>(
        value: null,
        validators: [Validators.required, Validators.min(0.5)],
      ),
      'weight': FormControl<double>(
        value: null,
        validators: [Validators.required, Validators.min(1)],
      ),
      'notes': FormControl<String>(value: ''),
      'preferredFoot': FormControl<FootPreference>(
        value: FootPreference.derecha,
        validators: [Validators.required],
      ),
      'basicForces': FormControl<bool>(value: false),
      'city': FormControl<String>(value: '', validators: [Validators.required]),
      'country': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'photo': FormControl<String>(value: ''),
      'teamId': FormControl<String>(value: null),
    }),
  );
}
