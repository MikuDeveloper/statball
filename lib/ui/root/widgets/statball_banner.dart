import 'package:flutter/material.dart';
import 'package:statball/app/config/theme/theme_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultPadding;
import 'package:statball/app/global/utils.dart';

class StatballBanner extends StatelessWidget {
  const StatballBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: defaultPadding,
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Text.rich(
          TextSpan(
            text: 'STAT',
            style: const TextStyle(
              color: ThemeColors.accent,
              letterSpacing: 1.4,
            ),
            children: [
              TextSpan(
                text: 'BALL',
                style: TextStyle(
                  color: Utils.setColorForTheme(
                    context: context,
                    light: ThemeColors.textPrimaryLight,
                    dark: ThemeColors.textPrimaryDark,
                  ),
                ),
              ),
            ],
          ),
          style: Theme.of(
            context,
          ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Visorias de fútbol en tiempo real',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Utils.setColorForTheme(
              context: context,
              light: ThemeColors.textMutedLight,
              dark: ThemeColors.textMutedDark,
            ),
          ),
        ),
      ],
    );
  }
}
