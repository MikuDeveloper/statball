import 'package:flutter/material.dart';

import 'package:statball/app/config/theme/theme_colors.dart';
import 'package:statball/app/global/utils.dart';

class StatballWidget extends StatelessWidget {
  const StatballWidget({super.key, this.before, this.style});

  final String? before;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: style ?? Theme.of(context).textTheme.displayLarge,
      textAlign: .center,
      TextSpan(
        text: before,
        style: TextStyle(
          color: Utils.setColorForTheme(
            context: context,
            light: ThemeColors.textMutedLight,
            dark: ThemeColors.textMutedDark,
          ),
          letterSpacing: 1.4,
        ),
        children: [
          TextSpan(
            text: 'STAT',
            style: TextStyle(
              color: Utils.setColorForTheme(
                context: context,
                light: ThemeColors.accent,
                dark: ThemeColors.accentDark,
              ),
              letterSpacing: 1.4,
            ),
          ),
          TextSpan(
            text: 'BALL',
            style: TextStyle(
              color: Utils.setColorForTheme(
                context: context,
                light: ThemeColors.textPrimaryLight,
                dark: ThemeColors.textPrimaryDark,
              ),
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
