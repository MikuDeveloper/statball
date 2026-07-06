import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveRequiredEmail extends StatelessWidget {
  const ReactiveRequiredEmail({
    super.key,
    this.controlName,
    this.hintText,
    this.prefixIcon,
    this.isLastField = false,
  });

  final String? controlName;
  final String? hintText;
  final IconData? prefixIcon;
  final bool isLastField;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: controlName ?? 'email',
      textInputAction: isLastField ? .done : .next,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hintText ?? 'example@email.com',
        prefixIcon: Icon(prefixIcon ?? Icons.email_rounded),
      ),
    );
  }
}
