import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:statball/app/global/constants.dart';

class SbSimplePasswordControl extends StatefulWidget {
  const SbSimplePasswordControl({
    super.key,
    this.controlName = 'password',
    this.isLast = false,
  });

  final String controlName;
  final bool isLast;

  @override
  State<SbSimplePasswordControl> createState() =>
      _SbSimplePasswordControlState();
}

class _SbSimplePasswordControlState extends State<SbSimplePasswordControl> {
  bool _hiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: widget.controlName,
      obscureText: _hiddenPassword,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.isLast
          ? TextInputAction.done
          : TextInputAction.next,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        hintText: '••••••••',
        prefixIcon: const Icon(Icons.key_rounded),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: defaultPadding * 1.5),
          child: IconButton(
            icon: Icon(
              _hiddenPassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () => setState(() => _hiddenPassword = !_hiddenPassword),
          ),
        ),
      ),
      validationMessages: {
        ValidationMessage.required: (_) => 'La contraseña es requerida',
      },
    );
  }
}
