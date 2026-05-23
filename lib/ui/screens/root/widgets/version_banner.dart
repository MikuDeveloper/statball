import 'package:flutter/material.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/constants.dart'
    show defaultPadding, defaultRadius;

class VersionBanner extends StatelessWidget {
  const VersionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding * 1.25,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(defaultRadius * 1.25),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: const Text(
        'BETA  •  V1.0.0',
        style: TextStyle(
          color: AppColors.accent,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.8,
        ),
      ),
    );
  }
}
