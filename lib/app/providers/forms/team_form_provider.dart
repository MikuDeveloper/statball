import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:statball/app/global/enums.dart' show TeamGender;

part 'team_form_provider.g.dart';

// Form para crear / editar un equipo. Todos los campos son requeridos por el
// schema; gender arranca en Masculino para evitar dropdown vacío.
@riverpod
({String key, FormGroup form}) teamForm(Ref ref) {
  return (
    key: 'team_form',
    form: FormGroup({
      'name': FormControl<String>(value: '', validators: [Validators.required]),
      'category': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'gender': FormControl<TeamGender>(
        value: TeamGender.masculino,
        validators: [Validators.required],
      ),
      'coachName': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'schoolId': FormControl<int>(
        value: null,
        validators: [Validators.required],
      ),
    }),
  );
}
