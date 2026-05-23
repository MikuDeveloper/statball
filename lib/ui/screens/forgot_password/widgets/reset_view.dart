import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:statball/app/global/constants.dart' show defaultPadding;
import 'package:statball/app/providers/forms/forgot_password_form_provider.dart';
import 'package:statball/app/providers/global/is_loading_provider.dart';
import 'package:statball/app/providers/repositories/sb_user_use_case_provider.dart';
import 'package:statball/ui/common/forms/sb_email_control.dart';
import 'package:statball/ui/common/forms/sb_field_label.dart';
import 'package:statball/ui/common/forms/sb_submit_button.dart';
import 'package:statball/ui/common/utils/snackbars_mixin.dart';

class ResetView extends ConsumerWidget with SnackbarsMixin {
  const ResetView({super.key, required this.onEmailSent});

  final ValueChanged<String> onEmailSent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formProvider = ref.watch(forgotPasswordFormProvider);
    final isLoading = ref.watch(isLoadingProvider(formProvider.key));

    return ReactiveForm(
      formGroup: formProvider.form,
      child: Column(
        spacing: defaultPadding,
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          const SbFieldLabel(text: 'Correo electrónico'),
          const SbEmailControl(isLast: true),
          const SizedBox(height: 16),
          SbSubmitButton(
            isLoading: isLoading,
            onSubmit: () => sendEmail(context, ref),
            text: 'Enviar correo de recuperación',
            icon: Icons.send_rounded,
          ),
          const SizedBox(height: 32),
          Center(
            child: TextButton(
              onPressed: () => context.pop(),
              child: const Text('Volver a inicio de sesión'),
            ),
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }

  Future<void> sendEmail(BuildContext context, WidgetRef ref) async {
    final formProvider = ref.read(forgotPasswordFormProvider);
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
      await ref.read(sbUserUseCaseProvider).sendResetPassEmail(email: email);
      onEmailSent(email);
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
