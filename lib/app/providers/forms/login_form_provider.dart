import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_form_provider.g.dart';

@riverpod
({String key, FormGroup form}) loginForm(Ref ref) {
  return (
    key: 'login_form',
    form: FormGroup({
      'email': FormControl<String>(
        value: '',
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
    }),
  );
}
