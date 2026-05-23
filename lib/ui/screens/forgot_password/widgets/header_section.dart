import 'package:flutter/material.dart';
import 'package:statball/app/config/themes/app_colors.dart';

import 'header_content.dart';

// ════════════════════════════════════════════════════════════════════════════
//  _HEADER SECTION — ícono + título + subtítulo
// ════════════════════════════════════════════════════════════════════════════
class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.emailSent,
    required this.email,
  });

  final bool emailSent;
  final String email;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, anim) =>
          FadeTransition(opacity: anim, child: child),
      child: emailSent
          ? HeaderContent(
              key: const ValueKey('hdr_success'),
              icon: Icons.mark_email_read_outlined,
              iconColor: AppColors.accent,
              title: '¡Correo\nenviado!',
              accentWord: '',
              subtitle:
                  'Revisa tu bandeja de entrada en\n$email\ny sigue las instrucciones.',
            )
          : const HeaderContent(
              key: ValueKey('hdr_form'),
              icon: Icons.lock_reset_rounded,
              iconColor: AppColors.accentAlt,
              title: 'Restablece\ntu ',
              accentWord: 'contraseña.',
              subtitle:
                  'Ingresa tu correo y te enviaremos un\nenlace para recuperar tu acceso.',
            ),
    );
  }
}
