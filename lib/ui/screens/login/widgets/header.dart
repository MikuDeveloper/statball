import 'package:flutter/material.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultRadius;

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(defaultRadius),
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.sports_soccer_rounded,
            color: AppColors.accent,
            size: 26,
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Bienvenido\na ',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  height: 1.15,
                  letterSpacing: -1.0,
                ),
              ),
              TextSpan(
                text: 'STATBALL.',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.accent,
                  height: 1.15,
                  letterSpacing: -1.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Inicia sesión para comenzar a registrar\ntus estadísticas.',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(height: 1.55),
        ),
      ],
    );
  }
}
