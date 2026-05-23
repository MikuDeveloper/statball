import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgot_password_form_provider.g.dart';

@riverpod
({String key, FormGroup form}) forgotPasswordForm(Ref ref) {
  return (
    key: 'forgot_password_form',
    form: FormGroup({
      'email': FormControl<String>(
        value: '',
        validators: [Validators.required, Validators.email],
      ),
    }),
  );
}
