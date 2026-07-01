import 'package:flutter/material.dart';

import 'package:statball/app/config/routes/router.dart';
import 'package:statball/app/config/routes/routes.dart' show loginPath;
import 'package:statball/app/config/theme/theme_colors.dart';
import 'package:statball/app/global/utils.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => routemaster.push(loginPath),
      style: ElevatedButton.styleFrom(minimumSize: const Size(500, 65)),
      child: Text(
        'COMENZAR',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: Utils.setColorForTheme(
            context: context,
            light: ThemeColors.onAccent,
            dark: ThemeColors.onAccentAlt,
          ),
        ),
      ),
    );
  }
}
