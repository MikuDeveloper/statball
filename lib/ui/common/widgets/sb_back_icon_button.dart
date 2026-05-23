import 'package:flutter/material.dart';
import 'package:statball/app/config/themes/app_colors.dart';

class SbBackIconButton extends StatelessWidget {
  const SbBackIconButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.inputBorder, width: 1),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.textMuted,
          size: 16,
        ),
      ),
    );
  }
}
