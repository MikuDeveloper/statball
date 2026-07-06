import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../helpers/form_group_state.dart';

class LoginFormCubit extends Cubit<FormGroupState> {
  LoginFormCubit()
    : super(
        FormGroupState(
          isLoading: false,
          formGroup: FormGroup({
            'email': FormControl<String>(
              value: '',
              validators: [Validators.required, Validators.email],
            ),
            'password': FormControl<String>(
              value: '',
              validators: [Validators.required],
            ),
          }),
        ),
      );

  Future<void> submitForm() async {
    if (!state.formGroup.valid) {
      state.formGroup.markAllAsTouched();
      return;
    }
    emit(state.copyWith(isLoading: true, isSuccess: false, clearError: true));
    try {
      // 2. Simulamos la llamada a tu API
      await Future<void>.delayed(const Duration(seconds: 2));

      // Simulamos que la API arrojó un error (Ej: status code 401)
      // final apiArrojaError = true;
      // if (apiArrojaError) {
      //   throw Exception('Credenciales incorrectas');
      // }

      // 3. Si todo sale bien (este código no se ejecutará por el throw de arriba)
      state.formGroup.reset(removeFocus: true);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      // 4. Atrapamos el error

      // Truco PRO con reactive_forms:
      // Le inyectamos un error manual al campo de contraseña para que se ponga rojo.
      // state.formGroup.control('password').setErrors({'incorrect': true});

      // Emitimos el estado con el mensaje de error general
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al iniciar sesión',
        ),
      );
    }
  }
}
