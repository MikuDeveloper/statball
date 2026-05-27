import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'school_form_provider.g.dart';

// Form para crear / editar una escuela. Solo `name` es obligatorio;
// el resto son metadatos opcionales (ubicación, contacto, redes).
@riverpod
({String key, FormGroup form}) schoolForm(Ref ref) {
  return (
    key: 'school_form',
    form: FormGroup({
      'name': FormControl<String>(value: '', validators: [Validators.required]),
      'site': FormControl<String>(value: ''),
      'facebook': FormControl<String>(value: ''),
      'instagram': FormControl<String>(value: ''),
      'phoneNumber': FormControl<String>(value: ''),
      'email': FormControl<String>(value: '', validators: [Validators.email]),
      'city': FormControl<String>(value: ''),
      'state': FormControl<String>(value: ''),
      'country': FormControl<String>(value: ''),
      'principalId': FormControl<int>(value: null),
    }),
  );
}
