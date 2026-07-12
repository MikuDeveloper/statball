import 'package:flutter/material.dart';

import 'widgets/setting.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: SafeArea(
        child: ListView(
          children: [
            const Setting(
              title: 'Tema de la aplicación',
              description: 'Cambia el tema de la aplicación',
              icon: Icons.palette_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
