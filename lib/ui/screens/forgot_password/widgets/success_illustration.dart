// ── Ilustración de éxito con anillos concéntricos ──────────────────────────
import 'package:flutter/material.dart';
import 'package:statball/app/config/themes/app_colors.dart';

class SuccessIllustration extends StatelessWidget {
  const SuccessIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Anillo exterior
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
          ),
          // Anillo medio
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.20),
                width: 1,
              ),
            ),
          ),
          // Círculo relleno central
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent.withValues(alpha: 0.10),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.45),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              color: AppColors.accent,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
