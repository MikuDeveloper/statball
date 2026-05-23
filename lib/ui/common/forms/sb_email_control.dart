import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SbEmailControl extends StatelessWidget {
  const SbEmailControl({
    super.key,
    this.controlName = 'email',
    this.isLast = false,
  });

  final String controlName;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      keyboardType: .emailAddress,
      formControlName: controlName,
      textInputAction: isLast ? .done : .next,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: const InputDecoration(
        hintText: 'correo@example.com',
        prefixIcon: Icon(Icons.alternate_email_rounded),
      ),
      validationMessages: {
        ValidationMessage.required: (error) => 'El correo es requerido',
        ValidationMessage.email: (error) => 'Ingresa un correo válido',
      },
    );
  }
}
