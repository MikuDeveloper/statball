import 'package:flutter/material.dart';
import 'package:statball/app/config/themes/app_colors.dart';

class HeaderContent extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String accentWord;
  final String subtitle;

  const HeaderContent({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.accentWord,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ícono decorativo
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: iconColor.withValues(alpha: 0.30),
              width: 1,
            ),
          ),
          child: Icon(icon, color: iconColor, size: 26),
        ),

        const SizedBox(height: 20),

        // Título
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: const TextStyle(
                  color: AppColors.textPrimaryDark,
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  height: 1.18,
                  letterSpacing: -1.0,
                ),
              ),
              if (accentWord.isNotEmpty)
                TextSpan(
                  text: accentWord,
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    height: 1.18,
                    letterSpacing: -1.0,
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Subtítulo
        Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 14.5,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
