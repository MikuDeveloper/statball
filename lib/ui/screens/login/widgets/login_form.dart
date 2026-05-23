import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/global/constants.dart' show defaultPadding;
import 'package:statball/app/providers/forms/login_form_provider.dart';
import 'package:statball/app/providers/global/is_loading_provider.dart';
import 'package:statball/app/providers/repositories/sb_user_use_case_provider.dart';
import 'package:statball/ui/common/forms/sb_email_control.dart';
import 'package:statball/ui/common/forms/sb_field_label.dart';
import 'package:statball/ui/common/forms/sb_simple_password_control.dart';
import 'package:statball/ui/common/forms/sb_submit_button.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

class LoginForm extends ConsumerWidget with SnackbarsMixin {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formProvider = ref.watch(loginFormProvider);
    final form = formProvider.form;
    final isLoading = ref.watch(isLoadingProvider(formProvider.key));

    return ReactiveForm(
      formGroup: form,
      child: Column(
        spacing: defaultPadding,
        crossAxisAlignment: .start,
        children: [
          const SbFieldLabel(text: 'Correo electrónico'),
          const SbEmailControl(controlName: 'email'),
          const SizedBox(height: 16),
          const SbFieldLabel(text: 'Contraseña'),
          const SbSimplePasswordControl(isLast: true),
          Align(
            alignment: .centerRight,
            child: TextButton(
              onPressed: () =>
                  const ForgotPasswordRoute().pushRelative<void>(context),
              child: const Text('Olvidé mi contraseña'),
            ),
          ),
          const SizedBox(height: 35),
          SbSubmitButton(
            isLoading: isLoading,
            onSubmit: () => login(context, ref),
            text: 'Ingresar',
          ),
        ],
      ),
    );
  }

  Future<void> login(BuildContext context, WidgetRef ref) async {
    final formProvider = ref.read(loginFormProvider);
    final form = formProvider.form;

    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }

    final isLoading = ref.read(isLoadingProvider(formProvider.key).notifier);
    form.markAsDisabled();
    isLoading.setTrue();

    try {
      final email = form.control('email').value as String;
      final password = form.control('password').value as String;
      await ref
          .read(sbUserUseCaseProvider)
          .login(email: email, password: password);
      if (context.mounted) const HomeRoute().go(context);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(errorSnackBar(message: e.toString()));
    } finally {
      isLoading.setFalse();
      form.markAsEnabled();
    }
  }
}
