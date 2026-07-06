import 'package:flutter/material.dart';
import 'package:statball/app/config/theme/theme_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultPadding;
import 'package:statball/app/global/utils.dart';
import 'package:statball/ui/shared/widgets/statball_widget.dart';

class StatballBanner extends StatelessWidget {
  const StatballBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: defaultPadding,
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        const StatballWidget(),
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
