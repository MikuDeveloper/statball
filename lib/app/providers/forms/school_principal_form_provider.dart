import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'school_principal_form_provider.g.dart';

// Form para crear / editar un director. Name y lastname son obligatorios;
// el resto (contacto y redes) es opcional.
@riverpod
({String key, FormGroup form}) schoolPrincipalForm(Ref ref) {
  return (
    key: 'school_principal_form',
    form: FormGroup({
      'name': FormControl<String>(value: '', validators: [Validators.required]),
      'lastname': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'email': FormControl<String>(value: '', validators: [Validators.email]),
      'phoneNumber': FormControl<String>(value: ''),
      'instagram': FormControl<String>(value: ''),
      'facebook': FormControl<String>(value: ''),
    }),
  );
}
