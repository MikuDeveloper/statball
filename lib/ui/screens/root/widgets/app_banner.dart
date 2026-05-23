import 'package:flutter/material.dart';
import 'package:statball/app/config/themes/app_colors.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'STAT',
                style: TextStyle(
                  color: AppColors.textPrimaryDark,
                  fontSize: 54,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.5,
                  height: 1.0,
                ),
              ),
              TextSpan(
                text: 'BALL',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 54,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.5,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Gestiona y visualiza estadísticas de fútbol en tiempo real.',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            height: 1.5,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}
