import 'package:flutter/material.dart';

class SbFieldLabel extends StatelessWidget {
  const SbFieldLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.labelLarge?.copyWith(letterSpacing: 0.2),
    );
  }
}
