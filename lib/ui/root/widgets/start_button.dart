import 'package:flutter/material.dart';

import 'package:statball/app/config/routes/router.dart';
import 'package:statball/app/config/routes/routes.dart' show loginPath;

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => routemaster.push(loginPath),
      style: ElevatedButton.styleFrom(minimumSize: const Size(500, 65)),
      child: Text(
        'COMENZAR',
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(letterSpacing: 2),
      ),
    );
  }
}
