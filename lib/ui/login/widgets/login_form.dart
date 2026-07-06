import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/config/theme/theme_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultPadding;
import 'package:statball/app/providers/forms/login_form_cubit.dart';
import 'package:statball/app/providers/helpers/form_group_state.dart';
import 'package:statball/app/providers/is_logged_cubit.dart';
import 'package:statball/ui/shared/forms/field_label.dart';
import 'package:statball/ui/shared/forms/reactive_required_email.dart';
import 'package:statball/ui/shared/forms/reactive_required_password.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginFormCubit, FormGroupState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.read<IsLoggedCubit>().signIn();
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: ThemeColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return ReactiveForm(
          formGroup: state.formGroup,
          child: Column(
            spacing: defaultPadding / 2,
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              const FieldLabel(label: 'Correo electrónico'),
              const ReactiveRequiredEmail(),
              const SizedBox.shrink(),
              const FieldLabel(label: 'Contraseña'),
              const ReactiveRequiredPassword(),
              const SizedBox(height: defaultPadding),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 55),
                  ),
                  onPressed: state.isLoading
                      ? () {}
                      : () => context.read<LoginFormCubit>().submitForm(),
                  child: state.isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Ingresar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
