import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveRequiredPassword extends StatefulWidget {
  const ReactiveRequiredPassword({
    super.key,
    this.controlName,
    this.isLastField = true,
  });

  final String? controlName;
  final bool isLastField;

  @override
  State<ReactiveRequiredPassword> createState() =>
      _ReactiveRequiredPasswordState();
}

class _ReactiveRequiredPasswordState extends State<ReactiveRequiredPassword> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: widget.controlName ?? 'password',
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.isLastField ? .done : .next,
      obscureText: _hidden,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        hintText: _hidden ? '●●●●●●●●' : 'example',
        prefixIcon: const Icon(Icons.key_rounded),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _hidden = !_hidden),
          icon: Icon(
            _hidden ? Icons.visibility_off_rounded : Icons.visibility_rounded,
          ),
        ),
      ),
    );
  }
}
