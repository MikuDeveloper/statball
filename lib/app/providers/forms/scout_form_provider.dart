import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scout_form_provider.g.dart';

// Form para crear / editar un scout (visoreador). Todos los campos son
// requeridos por el schema; si en práctica resulta restrictivo, conviene
// relajar nullability en DB (mismo pattern que players).
@riverpod
({String key, FormGroup form}) scoutForm(Ref ref) {
  return (
    key: 'scout_form',
    form: FormGroup({
      'name': FormControl<String>(value: '', validators: [Validators.required]),
      'lastname': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'birthday': FormControl<DateTime>(
        value: null,
        validators: [Validators.required],
      ),
      'phoneNumber': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'address': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'photo': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
    }),
  );
}
