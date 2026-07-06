import 'package:flutter/material.dart';
import 'package:statball/app/config/theme/theme_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultPadding;
import 'package:statball/app/global/utils.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      spacing: defaultPadding * 1.5,
      children: [
        _FeatureCard(feature: 'Registra', icon: Icons.app_registration_rounded),
        _FeatureCard(feature: 'Analiza', icon: Icons.analytics_rounded),
        _FeatureCard(feature: 'Evalua', icon: Icons.event_available_rounded),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature, required this.icon});

  final String feature;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(defaultPadding * 1.5),
          child: Center(
            child: Column(
              spacing: defaultPadding,
              mainAxisSize: .min,
              mainAxisAlignment: .center,
              children: [
                Text(
                  feature,
                  textAlign: .center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    color: Utils.setColorForTheme(
                      context: context,
                      light: ThemeColors.accent,
                      dark: ThemeColors.accentDark,
                    ),
                  ),
                ),
                Icon(icon, size: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
