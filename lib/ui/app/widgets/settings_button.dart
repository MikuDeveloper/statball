import 'package:flutter/material.dart';
import 'package:statball/app/config/routes/router.dart';
import 'package:statball/app/config/routes/routes.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => routemaster.push(settingsPath),
      icon: const Icon(Icons.settings_rounded),
    );
  }
}