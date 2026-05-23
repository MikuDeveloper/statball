import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:statball/app/global/constants.dart' show defaultPadding;

import 'package:statball/ui/common/widgets/sb_info_card.dart';

import 'success_illustration.dart';

class SuccessView extends StatelessWidget {
  final String email;
  const SuccessView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: defaultPadding,
      children: [
        const SuccessIllustration(),
        const SizedBox(height: 20),
        const SbInfoCard(
          icon: Icons.email,
          text:
              'El enlace fue enviado a tu correo electrónico. Si no lo encuentras, revisa tu carpeta de spam.',
        ),
        const SizedBox.shrink(),
        const SbInfoCard(
          icon: Icons.replay_rounded,
          text:
              '¿No recibiste nada? Espera unos segundos y vuelve a intentarlo.',
        ),
        const SizedBox(height: 36),
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Volver al inicio de sesión'),
        ),
        const SizedBox.shrink(),
      ],
    );
  }
}
